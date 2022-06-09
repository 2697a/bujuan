import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/weslide/weslide_controller.dart';

class HomeController extends GetxController {
  RxDouble panelMinSize = 120.w.obs;
  RxDouble bottomBarHeight = 60.0.obs;
  RxDouble panelMobileMinSize = (120.w + 60).obs;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  PageController pageController = PageController(viewportFraction: .99);

  //是否是移动端
  bool isMobile = false;

  RxInt selectIndex = 0.obs;

  @override
  void onInit() {
    isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getBanner();
  }

  static HomeController get to => Get.find();

  void getBanner() async {}

  void changeSelectIndex(int index) {
    selectIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeRoute(String? route) {
    if (route == '/') {
      //首页
      bottomBarHeight.value = 60;
      panelMobileMinSize.value = (120.w + 60);
    } else {
      //其他页面
      bottomBarHeight.value = 0;
      panelMobileMinSize.value = 120.w;
    }
  }
}
