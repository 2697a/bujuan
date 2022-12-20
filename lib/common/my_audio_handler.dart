// import 'package:audio_service/audio_service.dart';
// import 'package:bujuan/common/just_audio_modify.dart';
// import 'package:bujuan/common/netease_api/netease_music_api.dart';
// import 'package:bujuan/common/storage.dart';
//
// import 'audio_player_handler.dart';
// import 'constants/key.dart';
//
// class MyAudioHandler extends BaseAudioHandler with SeekHandler implements AudioPlayerHandler {
//   final _player = AudioPlayer(); // 播放器
//   final _playlist = ConcatenatingAudioSource(children: []); // 播放列表
//   final _songlist = <MediaItem>[]; // 这个是播放列表
//   int _curIndex = 0; // 播放列表索引
//
//   MyAudioHandler() {
//     // 初始化
//     _loadEmptyPlaylist(); // 加载播放列表
//     _notifyAudioHandlerAboutPlaybackEvents(); // 背景状态更改
//     // _listenForDurationChanges(); // 当时间更改时更新背景
//     _listenPlayEnd();
//     // _listenForCurrentSongIndexChanges(); // 这个也是改背景
//   }
//
//   Future<void> _loadEmptyPlaylist() async {
//     String queueTitle = StorageUtil().getString(playQueueTitle);
//     if (queueTitle.isNotEmpty) {
//       await changeQueueLists(await _getData(queueTitle));
//       _curIndex = StorageUtil().getInt(playByIndex);
//       playIndex(_curIndex, playIt: false);
//     }
//   }
//
//   Future<List<MediaItem>> _getData(String id) async {
//     SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
//     SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
//     List<Song2> songs = (songDetailWrap.songs ?? []);
//     return songs
//         .map((e) => MediaItem(
//             id: e.id,
//             duration: Duration(milliseconds: e.dt ?? 0),
//             artUri: Uri.parse(e.al.picUrl ?? ''),
//             extras: {'url': '', 'image': e.al.picUrl ?? '', 'type': '', 'available': e.available},
//             title: e.name ?? "",
//             artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
//         .toList();
//   }
//
//   _savePlayIndex(int index) {
//     StorageUtil().setInt(playByIndex, index);
//   }
//
//   void _listenPlayEnd() {
//     _player.playerStateStream.listen((state) {
//       if (state.playing) {
//       } else {}
//       switch (state.processingState) {
//         case ProcessingState.idle:
//           break;
//         case ProcessingState.loading:
//           break;
//         case ProcessingState.buffering:
//           break;
//         case ProcessingState.ready:
//           break;
//         case ProcessingState.completed:
//           skipToNext();
//           break;
//       }
//     });
//   }
//
//   void _notifyAudioHandlerAboutPlaybackEvents() {
//     _player.playbackEventStream.listen((PlaybackEvent event) {
//       final playing = _player.playing;
//       playbackState.add(playbackState.value.copyWith(
//         controls: [
//           MediaControl.skipToPrevious,
//           if (playing) MediaControl.pause else MediaControl.play,
//           MediaControl.stop,
//           MediaControl.skipToNext,
//         ],
//         systemActions: const {
//           MediaAction.seek,
//         },
//         androidCompactActionIndices: const [0, 1, 3],
//         processingState: const {
//           ProcessingState.idle: AudioProcessingState.idle,
//           ProcessingState.loading: AudioProcessingState.loading,
//           ProcessingState.buffering: AudioProcessingState.buffering,
//           ProcessingState.ready: AudioProcessingState.ready,
//           ProcessingState.completed: AudioProcessingState.completed,
//         }[_player.processingState]!,
//         shuffleMode: (_player.shuffleModeEnabled) ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
//         playing: playing,
//         updatePosition: _player.position,
//         bufferedPosition: _player.bufferedPosition,
//         speed: _player.speed,
//         queueIndex: _curIndex,
//       ));
//     });
//   }
//
//   @override
//   Future<void> addQueueItems(List<MediaItem> mediaItems) async {
//     if (_songlist.isNotEmpty) {
//       // 判断当前歌曲的位置是否是处于最后一位
//
//       _songlist.insertAll(_curIndex + 1, mediaItems);
//
//       final newQueue = queue.value..insertAll(_curIndex + 1, mediaItems);
//       // _curIndex++;
//       queue.add(newQueue);
//     } else {
//       _songlist.insertAll(_curIndex, mediaItems);
//       final newQueue = queue.value..insertAll(_curIndex, mediaItems);
//       queue.add(newQueue);
//     }
//   }
//
//   // 私人Fm的添加
//   @override
//   Future<void> addFmItems(List<MediaItem> mediaItems, bool isadd) async {
//     // final audioSource = mediaItems.map(_futterSongItem);
//     if (_songlist.isNotEmpty) {
//       // 判断当前歌曲的位置是否是处于最后一位
//
//       _songlist.insertAll(_curIndex + 1, mediaItems);
//
//       final newQueue = queue.value..insertAll(_curIndex + 1, mediaItems);
//       if (isadd) {
//         _curIndex++;
//       }
//       queue.add(newQueue);
//     } else {
//       _songlist.insertAll(_curIndex, mediaItems);
//       final newQueue = queue.value..insertAll(_curIndex, mediaItems);
//       queue.add(newQueue);
//     }
//   }
//
//   // Song _futterSongItem(MediaItem mediaItem) {
//   //   return Song(
//   //     int.parse(mediaItem.id),
//   //     mediaItem.duration!,
//   //     artists: mediaItem.artist ?? '',
//   //     picUrl: mediaItem.extras?["picUrl"] ?? '',
//   //     name: mediaItem.title,
//   //   );
//   // }
//
//   @override
//   Future<void> changeQueueLists(List<MediaItem> mediaitems, {int index = 0}) async {
//     // 这里是替换播放列表
//     _songlist.clear();
//     _songlist.addAll(mediaitems);
//     _curIndex = index; // 更换了播放列表，将索引归0
//
//     // notify system
//     queue.value.clear();
//     final newQueue = queue.value..addAll(mediaitems);
//     queue.add(newQueue); // 添加到背景播放列表
//     if (queueTitle.value.isNotEmpty) StorageUtil().setString(playQueueTitle, queueTitle.value);
//   }
//
//   Future<String> _getSongUrl(id) async {
//     SongUrlListWrap songUrlListWrap = await NeteaseMusicApi().songUrl([id]);
//     final data = songUrlListWrap.data ?? [];
//     return data.isNotEmpty ? data[0].url ?? '' : '';
//   }
//
//   @override
//   Future<void> playIndex(int index, {bool playIt = true}) async {
//     // 接收到下标
//     _curIndex = index;
//     readySongUrl(playIt: playIt);
//   }
//
//   @override
//   Future<void> removeQueueItemAt(int index) async {
//     // manage Just Audio
//     _playlist.removeAt(index);
//
//     // notify system
//     final newQueue = queue.value..removeAt(index);
//     queue.add(newQueue);
//   }
//
//   @override
//   Future<void> addQueueItem(MediaItem mediaItem) async {
//     // manage Just Audio
//     if (_songlist.isNotEmpty) {
//       // 判断当前歌曲的位置是否是处于最后一位
//       _songlist.insert(_curIndex + 1, mediaItem);
//       final newQueue = queue.value..insert(_curIndex + 1, mediaItem);
//       _curIndex++;
//       queue.add(newQueue);
//     } else {
//       _songlist.insert(_curIndex, mediaItem);
//       final newQueue = queue.value..insert(_curIndex, mediaItem);
//       queue.add(newQueue);
//     }
//
//     // notify system
//   }
//
//   @override
//   Future<void> readySongUrl({bool isNext = true, bool playIt = true}) async {
//     // 保存index
//     print('readySongUrl======================$_curIndex');
//     _savePlayIndex(_curIndex);
//     // 这里是获取歌曲url
//     var song = _songlist[_curIndex];
//     SongUrlListWrap a = await NeteaseMusicApi().songUrl([song.id]);
//     String url = (a.data ?? [])[0].url ?? '';
//     if (url.isNotEmpty) {
//       // 加载音乐
//       url = url.replaceFirst('http', 'https');
//       try {
//         await _player.setAudioSource(AudioSource.uri(
//           Uri.parse(url),
//           tag: song,
//         ));
//       } catch (e) {
//         print('error======$e');
//       }
//       // 这里需要重新更新一次
//       final playlist = queue.value;
//       if (playlist.isEmpty) return;
//       mediaItem.add(playlist[_curIndex]);
//       if (playIt) play(); // 播放
//     } else {
//       if (isNext) {
//         skipToNext();
//       } else {
//         skipToPrevious();
//       }
//     }
//   }
//
//   @override
//   Future<void> play() async {
//     _player.play();
//   }
//
//   @override
//   Future<void> pause() => _player.pause();
//
//   @override
//   Future<void> seek(Duration position) => _player.seek(position);
//
//   @override
//   Future<void> skipToNext() async {
//     // 当触发播放下一首
//     if (_curIndex >= _songlist.length - 1) {
//       _curIndex = 0;
//     } else {
//       _curIndex++;
//     }
//     // 然后触发获取url
//     readySongUrl();
//     // final model = getIt<PageManager>();
//     // print('触发播放下一首');
//     // if (model.isPersonFm.value) {
//     //   // 如果是私人fm
//     //   print('私人fm========$_curIndex');
//     //   if (_curIndex == _songlist.length - 1) {
//     //     // 判断如果是最后一首
//     //     print('触发');
//     //     model.getPersonFmList();
//     //   }
//     // }
//   }
//
//   @override
//   Future<void> skipToPrevious() async {
//     if (_curIndex <= 0) {
//       _curIndex = _songlist.length - 1;
//     } else {
//       _curIndex--;
//     }
//     readySongUrl(isNext: false);
//   }
//
//   @override
//   Future<void> stop() async {
//     await _player.stop();
//     return super.stop();
//   }
//
//   @override
//   Future<void> onTaskRemoved() async {
//     print('objectonTaskqRemoved');
//     //  把当前播放列表和播放index存起来包括播放进度
//     await stop();
//     await _player.dispose();
//   }
// }
