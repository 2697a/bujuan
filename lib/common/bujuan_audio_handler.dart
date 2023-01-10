import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:audio_session/audio_session.dart';
import 'audio_player_handler.dart';
import 'constants/key.dart';
import 'constants/platform_utils.dart';
import 'netease_api/src/api/play/bean.dart';
import 'netease_api/src/netease_api.dart';

class BujuanAudioHandler extends BaseAudioHandler with SeekHandler, QueueHandler implements AudioPlayerHandler {
  final _player = GetIt.instance<AudioPlayer>();
  AudioServiceRepeatMode _audioServiceRepeatMode = AudioServiceRepeatMode.all;
  final _playList = <MediaItem>[];
  final _playListShut = <MediaItem>[];
  int _curIndex = 0; // 播放列表索引
  bool playInterrupted = false;
  AudioSession? session;

  BujuanAudioHandler() {
    // 初始化
    _initAudioSession();
    _loadPlaylistByStorage();
    _notifyAudioHandlerAboutPlayStateEvents(); // 背景状态更改
    _notifyAudioHandlerAboutPositionEvents();
  }

  void _loadPlaylistByStorage() async {
    _curIndex = StorageUtil().getInt(playByIndex);
    queueTitle.value = StorageUtil().getString(playQueueTitle);
    List<String> playList = StorageUtil().getStringList(playQueue);
    print('开始读取${playList.join(',')}');
    if (playList.isNotEmpty) {
      List<MediaItem> items = playList.map((e) {
        var map = MediaItemMessage.fromMap(jsonDecode(e));
        return MediaItem(id: map.id, duration: map.duration, artUri: map.artUri, extras: map.extras, title: map.title, artist: map.artist, album: map.album);
      }).toList();
      changeQueueLists(items, init: true);
      playbackState.add(playbackState.value.copyWith(
        queueIndex: _curIndex,
      ));
      playIndex(_curIndex, playIt: false);
    }
  }

  void _initAudioSession() async {
    session = await AudioSession.instance;
    await session?.configure(const AudioSessionConfiguration.speech());
    _handleInterruptions(session!);
  }

  //设置音频焦点
  void _handleInterruptions(AudioSession audioSession) {
    // just_audio can handle interruptions for us, but we have disabled that in
    // order to demonstrate manual configuration.
    audioSession.becomingNoisyEventStream.listen((_) {
      _player.pause();

    });
    audioSession.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            print('begin==========duck');
            if (audioSession.androidAudioAttributes!.usage == AndroidAudioUsage.game) {
              _player.setVolume(1);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
          print('begin==========pauseunknown');
            if (_player.state == PlayerState.playing) {
              _player.pause();
              playInterrupted = true;
            }
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            // _player.setVolume(min(1.0, _player.volume * 2));
          print('duck==========');
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            print('pause==========${playInterrupted}');
            if (playInterrupted) _player.resume();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            print('unknown==========');
            playInterrupted = false;
            break;
        }
      }
    });
    audioSession.devicesChangedEventStream.listen((event) {
      print('Devices added: ${event.devicesAdded}');
      print('Devices removed: ${event.devicesRemoved}');
    });
  }

  void _notifyAudioHandlerAboutPlayStateEvents() {
    _player.onPlayerStateChanged.listen((PlayerState playerState) async {
      if (playerState == PlayerState.completed) {
        await skipToNext();
        return;
      }
      // playInterrupted = false;
      final playing = playerState == PlayerState.playing;
      if (playing) session?.setActive(true);
      playbackState.add(playbackState.value.copyWith(
        controls: [
          PlatformUtils.isAndroid
              ? ((mediaItem.value?.extras?['liked'] ?? false)
                  ? const MediaControl(label: 'fastForward', action: MediaAction.fastForward, androidIcon: 'drawable/audio_service_like')
                  : const MediaControl(label: 'rewind', action: MediaAction.rewind, androidIcon: 'drawable/audio_service_unlike'))
              : const MediaControl(label: 'setRating', action: MediaAction.setRating, androidIcon: 'drawable/audio_service_like'),
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop
        ],
        systemActions: {MediaAction.playPause, MediaAction.seek, MediaAction.skipToPrevious, MediaAction.skipToNext},
        androidCompactActionIndices: [1, 2, 3],
        processingState: AudioProcessingState.completed,
        playing: playing,
      ));
    });
  }

  void _notifyAudioHandlerAboutPositionEvents() {
    _player.onPositionChanged.listen((Duration duration) {
      playbackState.add(playbackState.value.copyWith(updatePosition: duration, bufferedPosition: duration));
    });
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {}

  @override
  Future<void> removeQueueItemAt(int index) async {
    if (index == _curIndex) {
      WidgetUtil.showToast('正在播放的歌曲无法移除');
      return;
    }
    _playList.removeAt(index);
    if (index < _curIndex) _curIndex--;
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future<void> addFmItems(List<MediaItem> mediaItems, bool isAddcurIndex) async {
    if (HomeController.to.fm.value && _playList.length >=3) {
      _playList.removeRange(0, queue.value.length - 1);
      updateQueue(_playList);
      addQueueItems(mediaItems);
    } else {
      _playList.clear();
      updateQueue(mediaItems);
      StorageUtil().setBool(fmSp,true);
    }
    _curIndex = 0;
    _playList.addAll(mediaItems);
    if (isAddcurIndex) _curIndex++;
    if (!HomeController.to.fm.value) HomeController.to.fm.value = true;
    playIndex(_curIndex);
    List<String> playList = mediaItems
        .map((e) => jsonEncode(MediaItemMessage(
              id: e.id,
              album: e.album,
              title: e.title,
              artist: e.artist,
              genre: e.genre,
              duration: e.duration,
              artUri: e.artUri,
              playable: e.playable,
              displayTitle: e.displayTitle,
              displaySubtitle: e.displaySubtitle,
              displayDescription: e.displayDescription,
              extras: e.extras,
            ).toMap()))
        .toList();
    print('开始存储${playList.join(',')}');

    queueTitle.value = 'Fm';
    StorageUtil().setStringList(playQueue, playList);
    StorageUtil().setString(playQueueTitle, 'Fm');
  }

  //更改为不喜欢按钮
  @override
  Future<void> fastForward() async {
    // updateMediaItem(mediaItem.value?.copyWith(extras: {'liked':'true'})??const MediaItem(id: 'id', title: 'title'));
    HomeController.to.likeSong(liked: true);
  }

  //更改为喜欢按钮
  @override
  Future<void> rewind() async {
    HomeController.to.likeSong(liked: false);
  }

  @override
  Future<void> changeQueueLists(List<MediaItem> list, {int index = 0, bool init = false}) async {
    if (!init && HomeController.to.fm.value) {
      HomeController.to.fm.value = false;
      StorageUtil().setBool(fmSp,false);
    }
    _playList
      ..clear()
      ..addAll(list);
    // notify system
    updateQueue(list);
    List<String> playList = list
        .map((e) => jsonEncode(MediaItemMessage(
              id: e.id,
              album: e.album,
              title: e.title,
              artist: e.artist,
              genre: e.genre,
              duration: e.duration,
              artUri: e.artUri,
              playable: e.playable,
              displayTitle: e.displayTitle,
              displaySubtitle: e.displaySubtitle,
              displayDescription: e.displayDescription,
              extras: e.extras,
            ).toMap()))
        .toList();
    StorageUtil().setStringList(playQueue, playList);
    if (queueTitle.value.isNotEmpty) StorageUtil().setString(playQueueTitle, queueTitle.value);
  }

  @override
  Future<void> playIndex(int index, {bool playIt = true}) async {
    // 接收到下标
    _curIndex = index;
    await readySongUrl(playIt: playIt);
    StorageUtil().setInt(playByIndex, _curIndex);
  }

  @override
  Future<void> readySongUrl({bool isNext = true, bool playIt = true}) async {
    // 这里是获取歌曲url
    if (queue.value.isEmpty) return;
    var song = queue.value[_curIndex];
    SongUrlListWrap songUrl = await NeteaseMusicApi().songUrl([song.id]);
    String url = (songUrl.data ?? [])[0].url ?? '';
    if (url.isNotEmpty) {
      mediaItem.add(song);
      // 加载音乐
      // url = url.replaceFirst('http', 'https');
      try {
        playIt ? await _player.play(UrlSource(url), mode: PlayerMode.mediaPlayer) : await _player.setSourceUrl(url);
      } catch (e) {
        print('error======$e');
      }
    } else {
      if (isNext) {
        await skipToNext();
      } else {
        await skipToPrevious();
      }
    }
  }

  @override
  Future<void> pause() async => await _player.pause();

  @override
  Future<void> play() async => await _player.resume();

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> skipToNext() async {
    _setCurrIndex(next: true);
    await readySongUrl();
    print('触发播放下一首');
    if (HomeController.to.fm.value) {
      // 如果是私人fm
      print('私人fm========$_curIndex');
      if (_curIndex == queue.value.length - 1) {
        // 判断如果是最后一首
        print('触发');
        HomeController.to.getFmSongList();
      }
    }
  }

  @override
  Future<void> skipToPrevious() async {
    _setCurrIndex();
    await readySongUrl(isNext: false);
  }

  void _setCurrIndex({bool next = false}) {
    if (_audioServiceRepeatMode == AudioServiceRepeatMode.one) return;
    if (next ? _curIndex >= _playList.length - 1 : _curIndex <= 0) {
      next ? _curIndex = 0 : _curIndex = _playList.length - 1;
    } else {
      next ? _curIndex++ : _curIndex--;
    }
    StorageUtil().setInt(playByIndex, _curIndex);
    playbackState.add(playbackState.value.copyWith(
      queueIndex: _curIndex,
    ));
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    if (repeatMode == AudioServiceRepeatMode.none) {
      //none当作随机播放吧
      _playListShut
        ..clear()
        ..addAll(_playList)
        ..shuffle();
      int index = _playListShut.indexWhere((element) => element.id == mediaItem.value?.id);
      if (index != -1) _curIndex = index;
      updateQueue(_playListShut);
    } else {
      int index = _playList.indexWhere((element) => element.id == mediaItem.value?.id);
      if (index != -1) _curIndex = index;
      updateQueue(_playList);
    }
    _audioServiceRepeatMode = repeatMode;
  }

  // @override
  // Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
  //   if (shuffleMode != AudioServiceShuffleMode.none) {
  //     _playListShut
  //       ..clear()
  //       ..addAll(_playList)
  //       ..shuffle();
  //     int index = _playListShut.indexWhere((element) => element.id == mediaItem.value?.id);
  //     if (index != -1) _curIndex = index;
  //     updateQueue(_playListShut);
  //   } else {
  //     int index = _playList.indexWhere((element) => element.id == mediaItem.value?.id);
  //     if (index != -1) _curIndex = index;
  //     updateQueue(_playList);
  //   }
  // }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
    await _player.release();
    await _player.dispose();
  }
}

class MediaItemMessage {
  /// A unique id.
  final String id;

  /// The title of this media item.
  final String title;

  /// The album this media item belongs to.
  final String? album;

  /// The artist of this media item.
  final String? artist;

  /// The genre of this media item.
  final String? genre;

  /// The duration of this media item.
  final Duration? duration;

  /// The artwork for this media item as a uri.
  final Uri? artUri;

  /// Whether this is playable (i.e. not a folder).
  final bool? playable;

  /// Override the default title for display purposes.
  final String? displayTitle;

  /// Override the default subtitle for display purposes.
  final String? displaySubtitle;

  /// Override the default description for display purposes.
  final String? displayDescription;

  /// The rating of the MediaItemMessage.

  /// A map of additional metadata for the media item.
  ///
  /// The values must be integers or strings.
  final Map<String, dynamic>? extras;

  /// Creates a [MediaItemMessage].
  ///
  /// The [id] must be unique for each instance.
  const MediaItemMessage({
    required this.id,
    required this.title,
    this.album,
    this.artist,
    this.genre,
    this.duration,
    this.artUri,
    this.playable = true,
    this.displayTitle,
    this.displaySubtitle,
    this.displayDescription,
    this.extras,
  });

  /// Creates a [MediaItemMessage] from a map of key/value pairs corresponding to
  /// fields of this class.
  factory MediaItemMessage.fromMap(Map<String, dynamic> raw) => MediaItemMessage(
        id: raw['id'] as String,
        title: raw['title'] as String,
        album: raw['album'] as String?,
        artist: raw['artist'] as String?,
        genre: raw['genre'] as String?,
        duration: raw['duration'] != null ? Duration(milliseconds: raw['duration'] as int) : null,
        artUri: raw['artUri'] != null ? Uri.parse(raw['artUri'] as String) : null,
        playable: raw['playable'] as bool?,
        displayTitle: raw['displayTitle'] as String?,
        displaySubtitle: raw['displaySubtitle'] as String?,
        displayDescription: raw['displayDescription'] as String?,
        extras: castMap(raw['extras'] as Map?),
      );

  /// Converts this [MediaItemMessage] to a map of key/value pairs corresponding to
  /// the fields of this class.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'title': title,
        'album': album,
        'artist': artist,
        'genre': genre,
        'duration': duration?.inMilliseconds,
        'artUri': artUri?.toString(),
        'playable': playable,
        'displayTitle': displayTitle,
        'displaySubtitle': displaySubtitle,
        'displayDescription': displayDescription,
        'extras': extras,
      };
}

Map<String, dynamic>? castMap(Map? map) => map?.cast<String, dynamic>();
