import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/widget/refresh_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/constants/colors.dart';
import '../../widget/weslide/weslide_controller.dart';

class HomeController extends SuperController {
  final String weSlideUpdate = 'weSlide';
  double panelHeaderSize = 110.w;
  double secondPanelHeaderSize = 120.w;
  double paddingBottom = MediaQueryData.fromWindow(window).padding.bottom;
  double paddingTop = MediaQueryData.fromWindow(window).padding.top;
  double bottomBarHeight = 0;
  double panelMobileMinSize = 0;
  double topBarHeight = 120.w;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  WeSlideController weSlideController1 = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  PageController pageController = PageController(viewportFraction: .99);
  RxString lyric = ''.obs;
  Rx<Color> textColor = const Color(0xFFFFFFFF).obs;
  double offset = 0;
  double down = 0;
  RxBool isScroll = true.obs;

  //是否第一次进入首页
  bool first = true;
  RxInt selectIndex = 0.obs;
  final assetsAudioPlayer = AssetsAudioPlayer();
  RxInt playPosition = 0.obs;
  RxDouble slidePosition = 0.0.obs;
  RxDouble slidePosition2 = 0.0.obs;
  Rx<PaletteColorData> rx = PaletteColorData().obs;
  RxBool second = false.obs;
  bool firstSlideIsDownSlide = true;
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(systemNavigationBarColor: AppTheme.onPrimary);
  RxBool isRoot = true.obs;

  PageController secondPageController = PageController();
  RequestRefreshController refreshController = RequestRefreshController();
  final OnAudioQuery audioQuery = OnAudioQuery();
  late BuildContext buildContext;
  @override
  void onInit() {
    bottomBarHeight = 60 + paddingBottom;
    panelMobileMinSize = 110.w + bottomBarHeight;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    assetsAudioPlayer.current.listen((event) {
      if (event == null) {
        assetsAudioPlayer.next();
        return;
      }
      ImageUtils.getImageColor(event.audio.audio.metas.image?.path ?? '', (paletteColorData) {
        rx.value = paletteColorData;
        textColor.value = paletteColorData.light?.titleTextColor ?? AppTheme.onPrimary;
      });
    });
    assetsAudioPlayer.currentPosition.listen((event) {
      playPosition.value = event.inMilliseconds;
    });
    requestPermission();
  }

  static HomeController get to => Get.find();

  requestPermission() async {
    // Web platform don't support permissions methods.
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
  }

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

    // if (!this.second.value) {
    //   if (value >= .98) {
    //     changeSystemNavigationBarColor(rx.value.dark?.color ?? AppTheme.onPrimary);
    //   } else {
    //     if (systemUiOverlayStyle.systemNavigationBarColor != AppTheme.onPrimary) {
    //       changeSystemNavigationBarColor(Get.isPlatformDarkMode ? ThemeData.dark().bottomAppBarColor : ThemeData.light().bottomAppBarColor);
    //     }
    //   }
    // }
  }

  void changeSystemNavigationBarColor(Color color) {
    if (Platform.isAndroid) {
      systemUiOverlayStyle = SystemUiOverlayStyle(systemNavigationBarColor: color);
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
    return panelHeaderSize * (1 + slidePosition.value * 4.8);
  }

  double getPanelAdd() {
    return paddingTop * (second.value ? 1 : slidePosition.value) + getTopHeight() + (isRoot.value ? 0 : paddingBottom);
  }

  double getImageSize() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 4.8);
  }

  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }

  double getTitleLeft() {
    return ((Get.width - 60.w) - getPanelMinSize()) / 2 * slidePosition.value + getPanelMinSize();
  }

  Color getHeaderColor() {
      return Theme.of(buildContext).bottomAppBarColor.withOpacity((second.value ? (1 - slidePosition.value) : slidePosition.value) > 0 ? 0 : 1);
    // return Color.fromRGBO(255, 255, 255, (second.value ? (1 - slidePosition.value) : slidePosition.value) > 0 ? 0 : 1);
  }

  Color getLightTextColor() {
    if (!second.value && slidePosition.value == 1) {
      return textColor.value;
    } else {
      if (second.value && slidePosition.value == 0) {
        return textColor.value;
      }
      return Colors.black;
    }
  }

  double getTopHeight() {
    return topBarHeight * slidePosition.value;
  }

  EdgeInsets getHeaderPadding() {
    return EdgeInsets.only(left: 30.w, right: 30.w, top: paddingTop * (second.value ? 1 : slidePosition.value));
  }

  //
  double getSecondPanelMinSize() {
    return secondPanelHeaderSize + paddingBottom;
  }

  void changeSelectIndex(int index) {
    selectIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeRoute(String? route) {
    isRoot.value = route == '/';
    print('object=========$route');
    // if (isRoot.value) {
    //   //首页
    //   bottomBarHeight = 60 + paddingBottom;
    //   panelMobileMinSize = panelHeaderSize + bottomBarHeight;
    // } else {
    //   first = false;
    //   //其他页面
    //   bottomBarHeight = 0;
    //   panelMobileMinSize = panelHeaderSize + paddingBottom;
    // }
    // if (!first) update([weSlideUpdate]);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Future.delayed(const Duration(seconds: 1),() =>
    //     changeSystemNavigationBarColor(Theme.of(Get.context!).bottomAppBarColor));
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
