import 'dart:convert';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/storage.dart';
import 'package:get_it/get_it.dart';
import 'package:audio_session/audio_session.dart';
import 'package:json_annotation/json_annotation.dart';
import 'audio_player_handler.dart';
import 'constants/key.dart';
import 'netease_api/src/api/play/bean.dart';
import 'netease_api/src/netease_api.dart';

class TextAudioHandler extends BaseAudioHandler with SeekHandler, QueueHandler implements AudioPlayerHandler {
  final _player = GetIt.instance<AudioPlayer>();
  AudioServiceRepeatMode _audioServiceRepeatMode = AudioServiceRepeatMode.all;
  AudioServiceShuffleMode _audioServiceShuffleMode = AudioServiceShuffleMode.none;
  final _playList = <MediaItem>[];
  final _playListShut = <MediaItem>[];
  List<int> _playedIndexList = []; //播放过的index,循环播放时使用
  int _curIndex = 0; // 播放列表索引
  bool playInterrupted = false;
  AudioSession? session;

  TextAudioHandler() {
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
    if (queueTitle.value.isNotEmpty && playList.isNotEmpty) {
      List<MediaItem> items = playList.map((e) {
        var map = MediaItemMessage.fromMap(jsonDecode(e));
        return MediaItem(
          id: map.id,
          duration: map.duration,
          artUri: map.artUri,
          extras: map.extras,
          title: map.title,
          artist: map.artist,
        );
      }).toList();
      changeQueueLists(items);
      playIndex(_curIndex, playIt: false);
    }
  }

  void _initAudioSession() async {
    session = await AudioSession.instance;
    await session?.configure(const AudioSessionConfiguration.music());
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
            if (audioSession.androidAudioAttributes!.usage == AndroidAudioUsage.game) {
              _player.setVolume(1);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
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
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) _player.resume();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
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
      playInterrupted = false;
      final playing = playerState == PlayerState.playing;
      if (playing) session?.setActive(true);
      playbackState.add(playbackState.value.copyWith(
        controls: [
          const MediaControl(label: 'rating', action: MediaAction.setRating, androidIcon: 'drawable/audio_service_unlike'),
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

  void _listenPlayEnd() {
    _player.onSeekComplete.listen((event) {
      _player.resume();
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
  Future<void> addFmItems(List<MediaItem> mediaItems, bool isAddcurIndex) {
    // TODO: implement addFmItems
    throw UnimplementedError();
  }

  @override
  Future<void> changeQueueLists(List<MediaItem> list, {int index = 0}) async {
    _playList
      ..clear()
      ..addAll(list);
    _playedIndexList.clear();
    for (int i = 0; i <= list.length; i++) {
      _playedIndexList.add(i);
    }
    _playedIndexList.shuffle();
    // notify system
    queue.value.clear();
    final newQueue = queue.value..addAll(list);
    queue.add(newQueue); // 添加到背景播放列表

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
    if (_playList.isEmpty) return;
    var song = _playList[_curIndex];
    SongUrlListWrap songUrl = await NeteaseMusicApi().songUrl([song.id]);
    print('SongUrlListWrap==========${jsonEncode(songUrl.toJson())}');
    String url = (songUrl.data ?? [])[0].url ?? '';
    if (url.isNotEmpty) {
      // 加载音乐
      // url = url.replaceFirst('http', 'https');
      try {
        playIt ? await _player.play(UrlSource(url), mode: PlayerMode.mediaPlayer) : await _player.setSourceUrl(url);
      } catch (e) {
        print('error======$e');
      }
      mediaItem.add(song);
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
  }

  @override
  Future<void> skipToPrevious() async {
    _setCurrIndex();
    await readySongUrl(isNext: false);
  }

  void _setCurrIndex({bool next = false}) {
    if (_audioServiceShuffleMode != AudioServiceShuffleMode.none) {
      //说明循环模式已经开启了,这里不管AudioServiceShuffleMode的具体值，只要不是none 就按照随机模式来
      // TODO 随机逻辑今天先不写
      _curIndex = _playedIndexList[_curIndex];
    } else {
      switch (_audioServiceRepeatMode) {
        case AudioServiceRepeatMode.all:
        case AudioServiceRepeatMode.group:
        case AudioServiceRepeatMode.none:
          //一律按列表循环
          // 当触发播放下一首
          if (next ? _curIndex >= _playList.length - 1 : _curIndex <= 0) {
            next ? _curIndex = 0 : _curIndex = _playList.length - 1;
          } else {
            next ? _curIndex++ : _curIndex--;
          }
          StorageUtil().setInt(playByIndex, _curIndex);
          playbackState.add(playbackState.value.copyWith(
            queueIndex: _curIndex,
          ));
          break;
        default:
          break;
      }
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    _audioServiceRepeatMode = repeatMode;
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    _audioServiceShuffleMode = shuffleMode;
  }

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
