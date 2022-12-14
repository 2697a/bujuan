import 'package:bujuan/common/constants/text_styles.dart';
import 'package:bujuan/pages/home/first/first_view.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

class FirstController extends HomeController{
  double panelHeaderSize = 90.h;
  double secondPanelHeaderSize = 120.w;
  double bottomBarHeight = 0;
  double panelMobileMinSize = 90.h;
  double topBarHeight = 70.h;
  final List<LeftMenu> leftMenus = [
    LeftMenu('个人中心',TablerIcons.user,Routes.user),
    LeftMenu('推荐歌单',TablerIcons.smartHome,Routes.index),
    LeftMenu('个人云盘',TablerIcons.cloud,Routes.search),
  ];

  double pointerDy = 0;
  //进度
  @override
  void onInit() async {
  }

  @override
  void onReady() {

  }
  static FirstController get to => Get.find();

  //获取panel页面顶部的高度
  double getTopHeight() {
    return topBarHeight * slidePosition.value;
  }

  getHomeBottomPadding() {
    return (panelHeaderSize * .5);
  }

  //外层panel的高度和颜色
  double getPanelMinSize() {
    return panelHeaderSize * (1 + slidePosition.value * 5.6);
  }

  //获取图片的宽高
  double getImageSize() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 5.2);
  }


  //获取图片离左侧的间距
  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }


  //获取歌词和列表Header的高度
  double getSecondPanelMinSize() {
    return secondPanelHeaderSize + MediaQuery.of(context!).padding.bottom;
  }
}