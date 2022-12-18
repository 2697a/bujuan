import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../home/home_controller.dart';

class PlayListController extends GetxController {
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
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

  Future<List<MediaItem>> getData(String id) async {
    queueTitle = id;
    SinglePlayListWrap singlePlayListWrap = await NeteaseMusicApi().playListDetail(id);
    SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    SongUrlListWrap songUrlListWrap = await NeteaseMusicApi().songAvailableCheck((singlePlayListWrap.playlist?.trackIds ?? []).map((e) => e.id).toList());
    StorageUtil().setStringList(queueTitle, (songUrlListWrap.data ?? []).map((e) => e.id).toList());
    List<SongUrl>? data = (songUrlListWrap.data ?? []).where((element) => (element.url ?? '').isEmpty).toList();
    print('object========${data.length}');
    List<Song2> songs = (songDetailWrap.songs ?? []).map((e) => e..available = data.indexWhere((element) => element.id == e.id) == -1).toList();
    mediaItems.clear();
    for (var e in songs) {
      mediaItems.add(MediaItem(
          id: e.id,
          duration: Duration(milliseconds: e.dt ?? 0),
          artUri: Uri.parse(e.al.picUrl ?? ''),
          extras: {'url': (songUrlListWrap.data ?? []).firstWhere((element) => element.id == e.id).url ?? '', 'image': e.al.picUrl ?? '', 'type': '', 'available': e.available},
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
      HomeController.to.audioServeHandler.queueTitle.value = title;
      HomeController.to.audioServeHandler.addQueueItems(mediaItems, playlistId: queueTitle, index: index, isPlay: true);
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
