import 'dart:convert';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/storage.dart';
import 'package:get_it/get_it.dart';
import 'package:audio_session/audio_session.dart';
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
    if (queueTitle.value.isNotEmpty) {
      SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(queueTitle.value);
      SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
      List<Song2> songs = (songDetailWrap.songs ?? []);
      if (songs.isEmpty) return;
      var items = songs
          .map((e) => MediaItem(
              id: e.id,
              duration: Duration(milliseconds: e.dt ?? 0),
              artUri: Uri.parse('${e.al.picUrl ?? ''}?param=600y600'),
              extras: {'url': '', 'image': e.al.picUrl ?? '', 'type': '', 'available': e.available},
              title: e.name ?? "",
              artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
          .toList();
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
      print('PAUSE');
      _player.pause();
    });
    audioSession.interruptionEventStream.listen((event) {
      print('interruption begin: ${event.begin}');
      print('interruption type: ${event.type}');
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
      print('Current player state: $playerState');
      if (playerState == PlayerState.completed) {
        await skipToNext();
        return;
      }
      playInterrupted = false;
      final playing = playerState == PlayerState.playing;
      if (playing) session?.setActive(true);
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl(label: 'rating', action: MediaAction.setRating, androidIcon: 'drawable/audio_service_unlike'),
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
      // print('_notifyAudioHandlerAboutPositionEvents=========${duration.inSeconds}');
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
