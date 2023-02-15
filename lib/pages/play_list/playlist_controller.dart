import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/bean.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';

class PlayListController<E, T> extends GetxController {
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  RxList<MediaItem> searchItems = <MediaItem>[].obs;
  BuildContext? context;
  SinglePlayListWrap? details;
  RxBool loading = true.obs;
  RxBool search = false.obs;
  RxBool isSearch = false.obs;
  RxBool sub = false.obs;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getSongIds((context?.routeData.args as Play).id);
    });
    textEditingController.addListener(() {
      if (textEditingController.text.isEmpty) {
        if (isSearch.value) isSearch.value = false;
      } else {
        if (!isSearch.value) isSearch.value = true;
        searchItems
          ..clear()
          ..addAll(mediaItems.where((p0) => p0.title.contains(textEditingController.text)).toList());
      }
    });
  }

  getSongIds(id) async {
    details ??= await NeteaseMusicApi().playListDetail(id);
    sub.value = details?.playlist?.subscribed ?? false;
    List<String> ids = details?.playlist?.trackIds?.map((e) => e.id).toList() ?? [];
    if (ids.length <= 1000) {
      await callRefresh(ids);
    } else {
      await callRefresh(ids.sublist(0, 1000));
      await callRefresh(ids.sublist(1000, ids.length), clear: false);
    }
  }

  callRefresh(List<String> ids, {bool clear = true}) async {
    SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail(ids);
    if (clear) mediaItems.clear();
    mediaItems.addAll(Home.to.song2ToMedia(songDetailWrap.songs ?? []));
    if (loading.value) {
      loading.value = false;
    }
  }

  static PlayListController get to => Get.find();

  @override
  void onClose() {
    super.onClose();
    textEditingController.dispose();
  }

  subscribePlayList() async {
    ServerStatusBean serverStatusBean = await NeteaseMusicApi().subscribePlayList((context?.routeData.args as Play).id, subscribe: !sub.value);
    if (serverStatusBean.code == 200) {
      sub.value = !sub.value;
    }
  }
}
