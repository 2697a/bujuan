import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  late BuildContext context;
  Album? album;
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;
  RxBool loading = true.obs;

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      album = context.routeData.queryParams.get('album');
      if (album != null) {
        AlbumDetailWrap albumDetailWrap = await NeteaseMusicApi().albumDetail(album?.id ?? '');
        mediaItems
          ..clear()
          ..addAll(Home.to.song2ToMedia(albumDetailWrap.songs ?? []));
        loading.value = false;
      }
    });
  }
}
