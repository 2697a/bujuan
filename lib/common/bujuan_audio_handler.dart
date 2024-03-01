import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/common/constants/other.dart';

import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player_handler.dart';
import 'constants/key.dart';
import 'constants/platform_utils.dart';
import 'netease_api/src/api/play/bean.dart';
import 'netease_api/src/netease_api.dart';

Future<List<MediaItem>> getCachePlayList(RootIsolateData data) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.rootIsolateToken);
  List<MediaItem> items = data.playlist?.map((e) {
        var map = MediaItemMessage.fromMap(jsonDecode(e));
        return MediaItem(
          id: map.id,
          duration: map.duration,
          artUri: map.artUri,
          extras: map.extras,
          title: map.title,
          artist: map.artist,
          album: map.album,
        );
      }).toList() ??
      [];
  return items;
}

Future<List<String>> setCachePlayList(RootIsolateData data) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(data.rootIsolateToken);
  return data.items
          ?.map((e) => jsonEncode(MediaItemMessage(
                id: e.id,
                album: e.album,
                title: e.title,
                artist: e.artist,
                duration: e.duration,
                artUri: e.artUri,
                extras: e.extras,
              ).toMap()))
          .toList() ??
      [];
}

class RootIsolateData {
  RootIsolateToken rootIsolateToken;
  List<String>? playlist;
  List<MediaItem>? items;

  RootIsolateData(this.rootIsolateToken, {this.playlist, this.items});
}

class BujuanAudioHandler extends BaseAudioHandler with SeekHandler, QueueHandler implements AudioPlayerHandler {
  final _player = GetIt.instance<AudioPlayer>();
  final Box _box = GetIt.instance<Box>();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  AudioServiceRepeatMode _audioServiceRepeatMode = AudioServiceRepeatMode.all;
  final _playList = <MediaItem>[];
  final _playListShut = <MediaItem>[];
  int _curIndex = 0; // 播放列表索引
  bool playInterrupted = false;
  Timer? _sleepTimer;

  BujuanAudioHandler() {
    // 初始化
    _loadPlaylistByStorage();
    _notifyAudioHandlerAboutPlayStateEvents(); // 背景状态更改
    _notifyAudioHandlerAboutPositionEvents();
  }

  void _loadPlaylistByStorage() async {
    String repeatMode = _box.get(repeatModeSp, defaultValue: 'all');
    _audioServiceRepeatMode = AudioServiceRepeatMode.values.firstWhereOrNull((element) => element.name == repeatMode) ?? AudioServiceRepeatMode.all;
    _curIndex = _box.get(playByIndex) ?? 0;
    List<String> playList = _box.get(playQueue, defaultValue: <String>[]);
    if (playList.isNotEmpty) {
      List<MediaItem> items = await compute(getCachePlayList, RootIsolateData(rootIsolateToken, playlist: playList));
      await changeQueueLists(items, init: true, index: _curIndex);
    }
  }

  void _notifyAudioHandlerAboutPlayStateEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
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
          MediaControl.stop,
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
        shuffleMode: (_player.shuffleModeEnabled) ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _curIndex,
      ));
    });
  }

  void _notifyAudioHandlerAboutPositionEvents() {
    _player.playerStateStream.listen((state) {
      switch (state.processingState) {
        case ProcessingState.idle:
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          break;
        case ProcessingState.completed:
          skipToNext();
          print('object=====下一首${_curIndex}');
          break;
      }
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
    if (Home.to.fm.value && _playList.length >= 3) {
      _playList.removeRange(0, queue.value.length - 1);
      updateQueue(_playList);
      addQueueItems(mediaItems);
    } else {
      _playList.clear();
      updateQueue(mediaItems);
      _box.put(fmSp, true);
    }
    _curIndex = 0;
    _playList.addAll(mediaItems);
    if (isAddcurIndex) _curIndex++;
    if (!Home.to.fm.value) Home.to.fm.value = true;
    playIndex(_curIndex);
    List<String> playList = await compute(setCachePlayList, RootIsolateData(rootIsolateToken, items: mediaItems));
    queueTitle.value = 'Fm';
    _box.put(playQueue, playList);
  }

  //更改为不喜欢按钮
  @override
  Future<void> fastForward() async {
    // updateMediaItem(mediaItem.value?.copyWith(extras: {'liked':'true'})??const MediaItem(id: 'id', title: 'title'));
    Home.to.likeSong(liked: true);
  }

  //更改为喜欢按钮
  @override
  Future<void> rewind() async {
    Home.to.likeSong(liked: false);
  }

  @override
  Future<void> changeQueueLists(List<MediaItem> list, {int index = 0, bool init = false}) async {
    // if (!init && Home.to.fm.value) {
    //   Home.to.fm.value = false;
    //   _box.put(fmSp, false);
    // }
    _curIndex = index;
    _playList
      ..clear()
      ..addAll(list);
    bool isSu = _box.get(repeatModeSp, defaultValue: 'all') == AudioServiceRepeatMode.none.name;
    if (isSu) {
      _playListShut
        ..clear()
        ..addAll(list)
        ..shuffle();
      await updateQueue(_playListShut);
      String songId = list[index].id;
      if (init) songId = _box.get(playById, defaultValue: '');
      int indexBy = _playListShut.indexWhere((element) => element.id == songId);
      if (indexBy != -1) {
        _curIndex = indexBy;
      }
    } else {
      await updateQueue(_playList);
    }
    playIndex(_curIndex, playIt: !init);
    if (!init) {
      List<String> playList = await compute(setCachePlayList, RootIsolateData(rootIsolateToken, items: _playList));
      _box.put(playQueue, playList);
    }
    // _playList
    //   ..clear()
    //   ..addAll(list);
    // // notify system
    // await updateQueue(list);
    // List<String> playList = await compute(setCachePlayList, RootIsolateData(rootIsolateToken, items: _playList));
    // _box.put(playQueue, playList);
  }

  @override
  Future<void> playIndex(int index, {bool playIt = true}) async {
    // 接收到下标
    _curIndex = index;
    _box.put(playByIndex, _curIndex);
    await readySongUrl(playIt: playIt);
  }

  @override
  Future<void> readySongUrl({bool isNext = true, bool playIt = true}) async {
    bool high = false;
    bool cache = false;
    // 这里是获取歌曲url
    if (queue.value.isEmpty) return;
    var song = queue.value[_curIndex];
    _box.put(playById, song.id);
    String? url;
    if (song.extras?['type'] == MediaType.local.name || song.extras?['type'] == MediaType.neteaseCache.name) url = song.extras?['url'];
    if (url != null) {
      song.extras?.putIfAbsent('cache', () => true);
      mediaItem.add(song);
      if (song.extras?['type'] == MediaType.local.name) {
        //是本地音乐
        await _player.setFilePath(url);
      }
      if (song.extras?['type'] == MediaType.neteaseCache.name) {
        //网易云缓存的音乐要解密哦
        _player.setAudioSource(StreamSource(url, url.replaceAll('.uc!', '').split('.').last));
      }
      if (playIt) _player.play();
      return;
    }
    if (!PlatformUtils.isIOS) {
      // url = DownloadCacheManager.getCachedFilePath(song.id);
    }
    if (url != null && File(url).existsSync()) {
      song.extras?.putIfAbsent('cache', () => true);
      mediaItem.add(song);
      await _player.setFilePath(url);
      if (playIt) _player.play();
    } else {
      mediaItem.add(song);
      if (_box.get(unblockVipSp, defaultValue: false) && ((song.extras?['fee'] ?? 0) == 1 || (song.extras?['fee'] ?? 0) == 4)) {
        //如果开启会员解锁并且歌曲为vip,直接从rust获取
        print('============如果开启会员解锁,直接从rust获取=============');
        url = await getUnblockUrl(song);
      } else {
        SongUrlListWrap songUrl = await NeteaseMusicApi().songDownloadUrl([song.id], level: high ? 'lossless' : 'exhigh');
        url = ((songUrl.data ?? [])[0].url ?? '').split('?')[0];
        if (url.isEmpty && _box.get(unblockSp, defaultValue: false)) {
          url = await getUnblockUrl(song);
        }
      }
      if (url.isNotEmpty) {
        await _player.setUrl(url);
        if (playIt) _player.play();
      } else {
        if (isNext) {
          await skipToNext();
        } else {
          await skipToPrevious();
        }
      }
    }
  }

  Future<String> getUnblockUrl(MediaItem song) async {
    // try {
    //   String url = await api.getUnblockNeteaseMusicUrl(songName: song.title, artistsName: song.artist ?? '');
    //   print('============UnblockNeteaseMusic启动成功=============${song.title}==============$url');
    //   return url;
    // } catch (e) {
    //   print('===========rust获取失败===========');
    //   return '';
    // }
    return '';
  }

  @override
  Future<void> pause() async => await _player.pause();

  @override
  Future<void> play() async => await _player.play();

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    // TODO: implement skipToQueueItem
    // return super.skipToQueueItem(index);
  }

  @override
  Future<void> skipToNext() async {
    _setCurrIndex(next: true);
    print('下一首=======$_curIndex');
    await readySongUrl();
    // if (Home.to.fm.value) {
    //   // 如果是私人fm
    //   if (_curIndex == queue.value.length - 1) {
    //     // 判断如果是最后一首
    //     Home.to.getFmSongList();
    //   }
    // }
  }

  @override
  Future<void> skipToPrevious() async {
    await stop();
    _setCurrIndex();
    await readySongUrl(isNext: false);
  }

  void _setCurrIndex({bool next = false}) {
   if (_audioServiceRepeatMode == AudioServiceRepeatMode.one) return;

  var list = _audioServiceRepeatMode == AudioServiceRepeatMode.none ? _playListShut : _playList;

  // 计算新的索引值
  _curIndex = next ? _curIndex + 1 : _curIndex - 1;

  // 如果超出索引范围，循环到列表的开始或结尾
  if (_curIndex >= list.length) {
    _curIndex = 0;
  } else if (_curIndex < 0) {
    _curIndex = list.length - 1;
  }

  _box.put(playByIndex, _curIndex);
  }

  @override
  Future<void> stop() async {
    await _player.stop();
  }

  @override
  Future customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'sleep') {
      //睡眠
      _sleepTimer?.cancel();
      if ((extras?['time'] ?? 0) == 0) return;
      //记录一下当前时间
      _sleepTimer = Timer(Duration(seconds: extras?['time'] ?? 0), () {
        _player.pause();
        Home.to.sleepMinTo = 0;
        Home.to.sleepSlide.value = true;
      });
    }

    //取消计时器
    if (name == 'cancelSleep') {
      _sleepTimer?.cancel();
    }
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    MediaItem m = queue.value[_curIndex];
    if (repeatMode == AudioServiceRepeatMode.none) {
      //none当作随机播放吧
      _playListShut
        ..clear()
        ..addAll(_playList)
        ..shuffle();
      int index = _playListShut.indexWhere((element) => element.id == m.id);
      if (index != -1) _curIndex = index;
      await updateQueue(_playListShut);
    } else {
      int index = _playList.indexWhere((element) => element.id == m.id);
      if (index != -1) _curIndex = index;
      await updateQueue(_playList);
    }
    _audioServiceRepeatMode = repeatMode;
    // List<String> playList = await compute(setCachePlayList, RootIsolateData(rootIsolateToken, items: queue.value));
    // _box.put(playQueue, playList);
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
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

class StreamSource extends StreamAudioSource {
  String uri;
  String fileType;

  // Get the Android content uri and the corresponsing file type by using MediaStore API in android
  StreamSource(this.uri, this.fileType);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    // Use a method channel to read the file into a List of bytes
    Uint8List fileBytes = Uint8List.fromList(File(uri).readAsBytesSync().map((e) => e ^ 0xa3).toList());

    // Returning the stream audio response with the parameters
    return StreamAudioResponse(
      sourceLength: fileBytes.length,
      contentLength: (start ?? 0) - (end ?? fileBytes.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([fileBytes.sublist(start ?? 0, end)]),
      contentType: fileType,
    );
  }
}
