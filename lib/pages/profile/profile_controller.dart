import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  goToCloud(){
    Get.toNamed('/cloud');
  }
  exit() {
    Get.defaultDialog(
        radius: 6.0,
        title: '退出登录',
        content: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('退出之后部分功能无法正常使用！')),
        textCancel: '迷途知返',
        textConfirm: '一意孤行',
        buttonColor: Colors.transparent,
        onConfirm: () {
          SpUtil.putString(USER_ID_SP, '');
          HomeController.to.login.value = false;
          HomeController.to.changeIndex(1);
          Get.back();
          Get.back();
        });
  }
}
