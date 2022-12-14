import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/netease_api.dart';

class UserController extends HomeController {
  List<Play> playlist = <Play>[].obs;
  ScrollController userScrollController = ScrollController();
  RxDouble op = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    getUserPlayList();
    userScrollController.addListener(() {
      if (userScrollController.position.pixels <= 30.w && op.value != 0) {
        op.value = 0;
      }
      if (userScrollController.position.pixels >= 240.w && op.value < 1) {
        op.value = 1;
      }
    });
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
