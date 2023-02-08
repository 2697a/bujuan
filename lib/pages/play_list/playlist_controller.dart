import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';

class PlayListController<E, T> extends GetxController {
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  BuildContext? context;
  SinglePlayListWrap? details;
  RxBool loading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSongIds((context?.routeData.args as Play).id);
      print(context?.routeData.path);
    });
  }

  getSongIds(id) async {
    details ??= await NeteaseMusicApi().playListDetail(id);
    List<String> ids = details?.playlist?.trackIds?.map((e) => e.id).toList() ?? [];
    if (ids.length <= 1000) {
      await callRefresh(ids);
    } else {
      await callRefresh(ids.sublist(0,1000));
      await callRefresh(ids.sublist(1000,ids.length),clear: false);
    }
  }


  callRefresh(List<String> ids, {bool clear = true}) async {
    SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail(ids);
    if (clear) mediaItems.clear();
    mediaItems.addAll(HomeController.to.song2ToMedia(songDetailWrap.songs ?? []));
    if(loading.value) {
      loading.value = false;
    }
  }

  static PlayListController get to => Get.find();

  @override
  void onClose() {
    super.onClose();
  }
}
