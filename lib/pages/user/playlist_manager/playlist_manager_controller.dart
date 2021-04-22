import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayListManagerController extends GetxController {
  var playList = [].obs;
  var delList = [].obs;

  @override
  void onInit() {
    playList = Get.arguments['play_list'];
    super.onInit();
  }

  delPlayList() {
    if (delList.length > 0) {
      Get.defaultDialog(
          title: '提示',
          content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text('确定要删除选中歌单吗?')),
          textConfirm: '删除',
          confirmTextColor: Colors.white,
          onConfirm: (){
            NetUtils().delPlayList(delList.join(',')).then((value) {
              if (value) {
                UserController.to.getUserSheet(forcedRefresh: true);
                delList.forEach((element) {
                  playList.remove(element);
                });
              }
            });
            Get.back();
          });
    }
  }
}
