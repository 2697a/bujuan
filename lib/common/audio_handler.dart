import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/storage.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'netease_api/src/api/play/bean.dart';
import 'netease_api/src/netease_api.dart';

class AudioServeHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer(); //真正去播放的实例
  final _playlist = ConcatenatingAudioSource(children: []);
  final OnAudioQuery audioQuery = GetIt.instance<OnAudioQuery>();
  String directoryPath = '';

  AudioServeHandler() {
    _loadPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForCurrentSongIndexChanges();
    _listenForSequenceStateChanges();
  }

  Future<void> _loadPlaylist() async {
    String playTitle = StorageUtil().getString(playQueueTitle);
    int index = StorageUtil().getInt(playIndex);
    print('object======获取歌单数据=====$playTitle=========$index');
    if (playTitle.isNotEmpty) {
      List<MediaItem> items = _setData(await _getData(playTitle));
      if (index < items.length) {
        addQueueItems(items, playlistId: playTitle, index: index, isPlay: false);
      }
    }
  }

  Future<SongDetailWrap> _getData(String id) async {
    SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
    return await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
  }

  List<MediaItem> _setData(SongDetailWrap songDetailWrap) {
    //获取歌单数据
    final songs = songDetailWrap.songs ?? [];
    return songs
        .map((e) => MediaItem(
            id: e.id,
            duration: Duration(milliseconds: e.dt ?? 0),
            artUri: Uri.parse(e.al.picUrl ?? ''),
            extras: {'url': 'http://music.163.com/song/media/outer/url?id=${e.id}', 'image': e.al.picUrl ?? '', 'type': ''},
            title: e.name ?? "",
            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
        .toList();
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
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      StorageUtil().setInt(playIndex, index ?? 0);
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
  Future<void> addQueueItems(List<MediaItem> mediaItems, {String playlistId = '', int index = 0, bool isPlay = true}) async {
    // 管理 Just Audio
    print('object==========${playlistId}');
    mediaItem.value = mediaItems[index];
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist
      ..clear()
      ..addAll(audioSource.toList());
    await _player.setAudioSource(_playlist);
    _player.seek(Duration.zero, index: index);
    if (isPlay) _player.play();
    // 通知系统
    queue.value.clear();
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
    if (playlistId.isNotEmpty) {
      StorageUtil().setString(playQueueTitle, playlistId);
      queueTitle.value = playlistId;
    }
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
    // if (index < 0 || index >= queue.value.length) return;
    // if (_player.shuffleModeEnabled) {
    //   index = _player.shuffleIndices![index];
    // }
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
    await StorageUtil().setInt(playPosition, position);
    await _player.stop();
    await stop();
    await _player.dispose();
  }
}
