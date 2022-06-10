import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/common/api/src/netease_util.dart';
import 'package:bujuan/common/bean/lyric_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/weslide/weslide_controller.dart';

class HomeController extends GetxController {
  final String weSlideUpdate = 'weSlide';
  double panelMinSize = 120.w;
  double bottomBarHeight = 60;
  double panelMobileMinSize = 120.w + 60;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  PageController pageController = PageController(viewportFraction: .99);
  RxString lyric = ''.obs;
  //是否第一次进入首页
  bool first = true;
  RxInt selectIndex = 0.obs;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    assetsAudioPlayer.current.listen((event) {
      print('object=========${event?.audio.audio.metas.title}');
      NetUtils().doHandler<LyricEntity>('/lyric',param: {'id':event?.audio.audio.metas.id},onSuccess: (data){
        lyric.value = data.lrc?.lyric??'';
      });
    });
    assetsAudioPlayer.playlistAudioFinished.listen((event) {});
  }

  static HomeController get to => Get.find();

  void getBanner() async {}

  void playOrPause() async {
    await assetsAudioPlayer.playOrPause();
  }

  void changeSelectIndex(int index) {
    selectIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeRoute(String? route) {
    if (route == '/') {
      //首页
      bottomBarHeight = 60;
      panelMobileMinSize = (120.w + 60);
    } else {
      first = false;
      //其他页面
      bottomBarHeight = 0;
      panelMobileMinSize = 120.w;
    }
    if (!first) update([weSlideUpdate]);
  }
}
