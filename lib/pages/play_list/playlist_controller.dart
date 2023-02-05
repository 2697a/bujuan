import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../home/home_controller.dart';

class PlayListController extends GetxController {
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  String queueTitle = '';

  DioMetaData playListDetailDioMetaData(String categoryId, {int subCount = 5}) {
    var params = {'id': categoryId, 'n': 1000, 's': '$subCount', 'shareUserId': '0'};
    return DioMetaData(Uri.parse('https://music.163.com/api/v6/playlist/detail'), data: params, options: joinOptions());
  }

  DioMetaData songDetailDioMetaData(List<String> songIds) {
    var params = {
      'ids': songIds,
      'c': songIds.map((e) => jsonEncode({'id': e})).toList()
    };
    return DioMetaData(joinUri('/api/v3/song/detail'), data: params, options: joinOptions());
  }

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
          artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=300y300'),
          extras: {'url': '', 'image': e.al?.picUrl ?? '', 'type': '', 'available': e.available},
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

  // playIndex(int index) async {
  //   String title = HomeController.to.audioServeHandler.queueTitle.value;
  //   if (title.isEmpty || title != queueTitle) {
  //     HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
  //     HomeController.to.audioServeHandler
  //       ..changeQueueLists(mediaItems, index: index)
  //       ..playIndex(index);
  //
  //   } else {
  //     HomeController.to.audioServeHandler.playIndex(index);
  //   }
  // }

  @override
  void onClose() {
    WidgetUtil.showToast('PlayListController关闭了');
    super.onClose();
  }
}
