import 'dart:convert';

import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/netease_api/src/api/bean.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../common/storage.dart';

class UserController extends GetxController {
  List<Play> playlist = <Play>[].obs;
  ScrollController userScrollController = ScrollController();
  RxDouble op = 0.0.obs;
  final List<double> colors = [1, .9, .8, .7, .6, .5, .4, .3, .2, .1, 0];

  //用户登录状态
  RxBool loginStatus = false.obs;
  Rx<NeteaseAccountInfoWrap> userData = NeteaseAccountInfoWrap().obs;

  //进度
  @override
  void onInit() {
    super.onInit();
    getUserState();
    userScrollController.addListener(() {
      if (userScrollController.position.pixels <= 130.w && op.value != 0) {
        op.value = 0;
      }
      if (userScrollController.position.pixels >= 240.w && op.value < 1) {
        op.value = 1;
      }
    });
  }

  @override
  void onReady() {}

  static UserController get to => Get.find();

  getUserState() async {
    NeteaseAccountInfoWrap neteaseAccountInfoWrap = await NeteaseMusicApi().loginAccountInfo();
    if (neteaseAccountInfoWrap.code == 200 && neteaseAccountInfoWrap.profile != null) {
      loginStatus.value = true;
      userData.value = neteaseAccountInfoWrap;
      getUserPlayList();
    }
  }

  clearUser() {
    NeteaseMusicApi().logout().then((value) {
      if (value.code != 200) {
        WidgetUtil.showToast(value.message ?? '');
      }
      loginStatus.value = false;
    });
  }

  getUserPlayList() {
    NeteaseMusicApi().userPlayList(userData.value.profile?.userId ?? '-1').then((MultiPlayListWrap2 multiPlayListWrap2) {
      print('发生错误了========${jsonEncode(multiPlayListWrap2.toJson())}');
      playlist
        ..clear()
        ..addAll(multiPlayListWrap2.playlist ?? []);
    }).catchError((error) {
      print('发生错误了========${error}');
    });
  }
}
