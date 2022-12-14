import 'dart:convert';

import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../common/storage.dart';

class UserController extends HomeController {
  List<Play> playlist = <Play>[].obs;
  ScrollController userScrollController = ScrollController();
  RxDouble op = 0.0.obs;
  //用户登录状态
  RxBool loginStatus = false.obs;
  Rx<NeteaseAccountInfoWrap> userData = NeteaseAccountInfoWrap().obs;

  //进度
  @override
  void onInit()  {
    getUserState();
    userScrollController.addListener(() {
      print('userScrollController');
      if (userScrollController.position.pixels <= 30.w && op.value != 0) {
        op.value = 0;
      }
      if (userScrollController.position.pixels >= 240.w && op.value < 1) {
        op.value = 1;
      }
    });
  }
  @override
  void onReady() {
  }

  static UserController get to => Get.find();

  getUserState() {
    var data = StorageUtil().getJSON('STORAGE_USER_PROFILE_KEY');
    if (data!=null) {
      print('objectaaaaa=========$data');
      loginStatus.value = true;
      userData.value = NeteaseAccountInfoWrap.fromJson(jsonDecode(data));
      getUserPlayList();
    }
  }


  clearUser() {
    loginStatus.value = false;
     StorageUtil().remove('STORAGE_USER_PROFILE_KEY');
  }

  saveUser(NeteaseAccountInfoWrap neteaseAccountInfoWrap)  {
    loginStatus.value = true;
    getUserPlayList();
    userData.value = neteaseAccountInfoWrap;
    StorageUtil().setJSON('STORAGE_USER_PROFILE_KEY', jsonEncode(neteaseAccountInfoWrap.toJson()));
  }
  getUserPlayList() {
    NeteaseMusicApi()
        .userPlayList(userData.value.profile?.userId ?? '-1')
        .then((MultiPlayListWrap2 multiPlayListWrap2) => playlist
          ..clear()
          ..addAll(multiPlayListWrap2.playlist ?? []))
        .catchError((error) {});
  }
}
