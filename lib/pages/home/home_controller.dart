import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/common/api/src/netease_util.dart';
import 'package:bujuan/common/bean/lyric_entity.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constants/colors.dart';
import '../../widget/weslide/weslide_controller.dart';

class HomeController extends GetxController {
  final String weSlideUpdate = 'weSlide';
  double panelMinSize = 100.w;
  double bottomBarHeight = 60;
  double panelMobileMinSize = 100.w + 60;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  WeSlideController weSlideController1 = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  PageController pageController = PageController(viewportFraction: .99);
  RxString lyric = ''.obs;

  //是否第一次进入首页
  bool first = true;
  RxInt selectIndex = 0.obs;
  final assetsAudioPlayer = AssetsAudioPlayer();

  RxInt playPosition = 0.obs;
  RxDouble slidePosition = 0.0.obs;
  double scaleImage = 1;
  Rx<PaletteColorData> rx = PaletteColorData().obs;
  RxBool second = false.obs;
  bool firstSlideIsDownSlide = true;
  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(systemNavigationBarColor: AppTheme.onPrimary);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    assetsAudioPlayer.current.listen((event) {
      print('object=========${event?.audio.audio.metas.title}');
      ImageUtils.getImageColor(
          event?.audio.audio.metas.image?.path ?? '', Get.context!,
          (paletteColorData) {
        rx.value = paletteColorData;
      });
      NetUtils().doHandler<LyricEntity>('/lyric',
          param: {'id': event?.audio.audio.metas.id}, onSuccess: (data) {
        lyric.value = data.lrc?.lyric ?? '';
      });
    });
    assetsAudioPlayer.currentPosition.listen((event) {
      playPosition.value = event.inMilliseconds;
    });
    assetsAudioPlayer.playlistAudioFinished.listen((event) {});
  }

  static HomeController get to => Get.find();

  void getBanner() async {}

  void playOrPause() async {
    await assetsAudioPlayer.playOrPause();
  }

  void changeSlidePosition(value, {bool second = false}) {
    slidePosition.value = value;
    if (this.second.value != second || (second && value == 1)) {
      this.second.value = second && value < 1;
    }
    if (this.second.value) {
      firstSlideIsDownSlide = value > 0;
      if (!first) update([weSlideUpdate]);
    }

    if (!this.second.value) {
      if (value == 1) {
        print('转开1');
        changeSystemNavigationBarColor(
            rx.value.dark?.color ?? AppTheme.onPrimary);
      } else {
        if (systemUiOverlayStyle.systemNavigationBarColor !=
            AppTheme.onPrimary) {
          changeSystemNavigationBarColor(AppTheme.onPrimary);
          print(
              '转开2====${SystemUiOverlayStyle.light.systemNavigationBarColor}=====${AppTheme.onPrimary}');
        }
      }
    }
  }

  void changeSystemNavigationBarColor(Color color) {
    if (Platform.isAndroid) {
      systemUiOverlayStyle =
          SystemUiOverlayStyle(systemNavigationBarColor: color);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  Future<bool> onWillPop() async {
    if (weSlideController1.isOpened) {
      weSlideController1.hide();
      return false;
    }
    if (weSlideController.isOpened) {
      weSlideController.hide();
      return false;
    }
    return true;
  }

  //外层panel的高度和颜色
  double getPanelMinSize() {
    return panelMinSize * (1 + slidePosition.value * 4);
  }

  double getImageSize() {
    return panelMinSize * .8 * (1 + slidePosition.value * 5.5);
  }

  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }

  double getTitleLeft() {
    return ((Get.width - 60.w) - getPanelMinSize()) / 2 * slidePosition.value +
        getPanelMinSize();
  }

  Color getHeaderColor() {
    return Color.fromRGBO(
        255,
        255,
        255,
        (second.value ? (1 - slidePosition.value) : slidePosition.value) > 0
            ? 0
            : 1);
  }

  EdgeInsets getHeaderPadding() {
    return EdgeInsets.only(
        left: 30.w,
        right: 30.w,
        top: MediaQuery.of(Get.context!).padding.top *
            (second.value ? 1 : slidePosition.value));
  }

  void changeSelectIndex(int index) {
    selectIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeRoute(String? route) {
    if (route == '/') {
      //首页
      bottomBarHeight = 60;
      panelMobileMinSize = (100.w + 60);
    } else {
      first = false;
      //其他页面
      bottomBarHeight = 0;
      panelMobileMinSize = 100.w;
    }
    if (!first) update([weSlideUpdate]);
  }
}
