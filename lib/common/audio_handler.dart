import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/common/storage.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class AudioServeHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer(); //真正去播放的实例
  final _playlist = ConcatenatingAudioSource(children: []);
  final OnAudioQuery audioQuery = GetIt.instance<OnAudioQuery>();
  String directoryPath = '';

  AudioServeHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
    // _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
    _listenForSequenceStateChanges();
  }

  Future<void> _loadPlaylist() async {
    try {
      await _player.setAudioSource(_playlist);
      Directory directory = await getTemporaryDirectory();
      directoryPath = directory.path;
      String albumId = StorageUtil().getString(playQueueTitle);
      var index = StorageUtil().getInt(playIndex);
      var position = StorageUtil().getInt(playPosition);
      print('object========$albumId=====$index========$position');
      if (albumId.isNotEmpty) {
        List<SongModel> songs = await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, albumId);
        final List<MediaItem> mediaItems = [];
        for (var songModel in songs) {
          String path = '$directoryPath/${songModel.id}';
          File file = File(path);
          if (!await file.exists()) {
            Uint8List? a = await audioQuery.queryArtwork(songModel.id, ArtworkType.AUDIO, size: 800);
            await file.writeAsBytes(a!);
          }
          MediaItem mediaItem = MediaItem(
              id: '${songModel.id}',
              duration: Duration(milliseconds: songModel.duration ?? 0),
              artUri: Uri.file(path),
              extras: {'url': songModel.uri, 'data': songModel.data, 'type': songModel.fileExtension, 'albumId': songModel.albumId},
              title: songModel.title,
              artist: songModel.artist);
          mediaItems.add(mediaItem);
        }

        String title1 = queueTitle.value;
        if (albumId.isEmpty || title1 != albumId) {
          await addQueueItems(mediaItems);
          queueTitle.value = albumId;
        }
        skipToQueueItem(index);
        seek(Duration(milliseconds: position));
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          const MediaControl(label: 'rating', action: MediaAction.setRating, androidIcon: 'drawable/audio_service_unlike'),
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [1, 2, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[_player.loopMode]!,
        shuffleMode: (_player.shuffleModeEnabled) ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {

      var index = _player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      if (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices![index];
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _listenForCurrentSongIndexChanges() {
    _player.currentIndexStream.listen((index) async {
      print('_listenForCurrentSongIndexChanges========$index');
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (_player.shuffleModeEnabled) {
        index = _player.shuffleIndices![index];
      }
      if (index >= playlist.length) {
        if (_player.loopMode == LoopMode.all) {
          index = 0;
          _player.seek(Duration.zero, index: index);
        } else {
          return;
        }
      }
      await StorageUtil().setInt(playIndex, index);
      mediaItem.add(playlist[index]);
    });
  }

  void _listenForSequenceStateChanges() {
    _player.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // 通知系统
    queue.value..clear()..addAll(mediaItems);
    // 管理 Just Audio
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist
      ..clear()
      ..addAll(audioSource.toList());
    await _player.setAudioSource(_playlist);
    await StorageUtil().setString(playQueueTitle, queueTitle.value);
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url']),
      tag: mediaItem,
    );
  }

  @override
  Future<void> play() async {
    await _player.play();
  }

  @override
  Future<void> pause() async {
    _player.pause();
  }

  @override
  Future<void> stop() async {
    _player.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    if (_player.shuffleModeEnabled) {
      index = _player.shuffleIndices![index];
    }
    print('object============${queue.value.length}=============$index========${mediaItem.value?.title ?? '啥也没有'}');
    _player
      ..seek(Duration.zero, index: index)
      ..play();
    // if ((mediaItem.value?.title ?? '').isEmpty) {
    //   mediaItem.add(queue.value[index]);
    // }
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
    }
    return super.setRepeatMode(repeatMode);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      _player.setShuffleModeEnabled(false);
    } else {
      await _player.shuffle();
      _player.setShuffleModeEnabled(true);
    }
  }

  @override
  Future<void> onTaskRemoved() async {
    //  把当前播放列表和播放index存起来包括播放进度
    int index = playbackState.value.queueIndex ?? 0;
    int position = playbackState.value.position.inMilliseconds;
    await StorageUtil().setString(playQueueTitle, queueTitle.value);
    await StorageUtil().setInt(playIndex, index);
    await StorageUtil().setInt(playPosition, position);
    await _player.stop();
    await stop();
    await _player.dispose();
  }
}
