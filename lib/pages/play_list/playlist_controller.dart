import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../home/home_controller.dart';

class PlayListController extends GetxController {
  List<MediaItem> mediaItems = <MediaItem>[];
  String queueTitle = '';
  ScrollController scrollController = ScrollController();
  RxDouble aa = 0.0.obs;


  @override
  void onInit() {
    scrollController.addListener(() {
      aa.value = scrollController.position.pixels;
    });
    super.onInit();
  }

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
      HomeController.to.audioServeHandler.addQueueItems(mediaItems, playlistId: queueTitle, index: index);
    } else {
      HomeController.to.audioServeHandler.skipToQueueItem(index);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
