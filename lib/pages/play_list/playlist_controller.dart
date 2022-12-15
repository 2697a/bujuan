import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../home/home_controller.dart';

class PlayListController extends GetxController {
  List<MediaItem> mediaItems = <MediaItem>[];
  String queueTitle = '';

  Future<SongDetailWrap> getData(String id) async {
    queueTitle = id;
    SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
    return await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    // SongUrlListWrap songUrlListWrap = await NeteaseMusicApi().songUrl((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
  }

  List<MediaItem> setData(SongDetailWrap songDetailWrap) {
    final songs = songDetailWrap.songs ?? [];
    mediaItems
      ..clear()
      ..addAll(songs
          .map((e) => MediaItem(
              id: e.id,
              duration: Duration(milliseconds: e.dt ?? 0),
              artUri: Uri.parse(e.al.picUrl ?? ''),
              extras: {'url': 'http://music.163.com/song/media/outer/url?id=${e.id}', 'image': e.al.picUrl ?? '', 'type': ''},
              title: e.name ?? "",
              artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
          .toList());
    return mediaItems;
  }

  playIndex(int index) async {
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      await HomeController.to.audioServeHandler.addQueueItems(mediaItems, index: index);
      HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
    } else {
      HomeController.to.audioServeHandler.skipToQueueItem(index);
    }
  }
}
