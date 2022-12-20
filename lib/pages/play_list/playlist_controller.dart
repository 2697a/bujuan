import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants/key.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../common/storage.dart';
import '../home/home_controller.dart';

class PlayListController extends GetxController {
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  String queueTitle = '';

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<MediaItem>> getData(String id) async {
    queueTitle = id;
    SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
    SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    List<Song2> songs = (songDetailWrap.songs ?? []);
    mediaItems.clear();
    for (var e in songs) {
      mediaItems.add(MediaItem(
          id: e.id,
          duration: Duration(milliseconds: e.dt ?? 0),
          artUri: Uri.parse('${e.al.picUrl ?? ''}?param=300y300'),
          extras: {'url': '', 'image': e.al.picUrl ?? '', 'type': '', 'available': e.available},
          title: e.name ?? "",
          artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')));
    }
    return mediaItems;
  }

  static PlayListController get to => Get.find();

  List<MediaItem> setData(SongDetailWrap songDetailWrap) {
    final songs = songDetailWrap.songs ?? [];

    return mediaItems;
  }

  playIndex(int index) async {
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
      HomeController.to.audioServeHandler
        ..changeQueueLists(mediaItems, index: index)
        ..playIndex(index);

      print('playIndex==========更新播放列表');
    } else {
      HomeController.to.audioServeHandler.playIndex(index);
      print('playIndex==========不更新播放列表');
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
