import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../home/home_controller.dart';

class PlayListController extends HomeController {
  List<MediaItem> mediaItems = <MediaItem>[].obs;
  String queueTitle = '';
  // Play play = Get.arguments;
  List<Song2> songs = <Song2>[];

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<MediaItem>> getData(String id) async {
    SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
    SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    SongUrlListWrap songUrlListWrap = await NeteaseMusicApi().songUrl((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    songs
      ..clear()
      ..addAll(songDetailWrap.songs ?? []);
    mediaItems.clear();
    for (int i = 0; i < songs.length; i++) {
      MediaItem mediaItem = MediaItem(
          id: songs[i].id,
          duration: Duration(milliseconds: songs[i].dt ?? 0),
          artUri: Uri.parse(songs[i].al.picUrl ?? ''),
          extras: {'url': songUrlListWrap.data?.firstWhere((element) => element.id == songs[i].id).url ?? '', 'image': songs[i].al.picUrl ?? '', 'type': ''},
          title: songs[i].name ?? "",
          artist: (songs[i].ar ?? []).map((e) => e.name).toList().join(' / '));
      mediaItems.add(mediaItem);
    }
    return mediaItems;
  }

  setPlayList(List<Song2> list) async {
    for (var track in list) {
      MediaItem mediaItem = MediaItem(
          id: track.id,
          duration: Duration(milliseconds: track.dt ?? 0),
          artUri: Uri.parse(track.al.picUrl ?? ''),
          extras: {
            'url': 'http://music.163.com/song/media/outer/url?id=${track.id}',
            'data': '',
            'type': '',
          },
          title: track.name ?? "",
          artist: '网易云');

      mediaItems.add(mediaItem);
    }
  }

  playIndex(int index) async {
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
      await HomeController.to.audioServeHandler.addQueueItems(mediaItems);
    }
    HomeController.to.audioServeHandler
      ..skipToQueueItem(index)
      ..play();
  }
}
