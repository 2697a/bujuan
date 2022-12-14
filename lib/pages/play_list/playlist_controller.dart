import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../home/home_controller.dart';

class PlayListController extends HomeController {
  List<MediaItem> mediaItems = <MediaItem>[];
  String queueTitle = '';

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<MediaItem>> getData(String id) async {
    queueTitle = id;
    SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
    SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    // SongUrlListWrap songUrlListWrap = await NeteaseMusicApi().songUrl((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    mediaItems.clear();
    final songs = songDetailWrap.songs ?? [];
    for (int i = 0; i < songs.length; i++) {
      MediaItem mediaItem = MediaItem(
          id: songs[i].id,
          duration: Duration(milliseconds: songs[i].dt ?? 0),
          artUri: Uri.parse(songs[i].al.picUrl ?? ''),
          extras: {'url': 'http://music.163.com/song/media/outer/url?id=${songs[i].id}', 'image': songs[i].al.picUrl ?? '', 'type': ''},
          title: songs[i].name ?? "",
          artist: (songs[i].ar ?? []).map((e) => e.name).toList().join(' / '));
      mediaItems.add(mediaItem);
    }
    return mediaItems;
  }


  playIndex(int index) async {
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      print('加载列表。。。。。。。。====$index');
      await HomeController.to.audioServeHandler.addQueueItems(mediaItems);
      HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
    }
    HomeController.to.audioServeHandler
      ..skipToQueueItem(index)..play();
  }
}
