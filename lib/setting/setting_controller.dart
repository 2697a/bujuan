import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';

class SettingController extends GetxController {
  var isDark = Get.isDarkMode.obs;
  var isIgnoreAudioFocus = false.obs;

  @override
  void onReady() {
    var bool = SpUtil.getBool(IS_IGNORE_AUDIO_FOCUS, defValue: false);
    isIgnoreAudioFocus.value = bool;
    super.onReady();
  }

  changeTheme(value) {
    Future.delayed(Duration(milliseconds: 300), () {
      Get.changeTheme(!value ? lightTheme : darkTheme);
      SpUtil.putBool(IS_DARK_SP, value);
    });
    isDark.value = value;
  }

  toggleAudioFocus(value) async {
    isIgnoreAudioFocus.value = value;
    var i = await Starry.toggleAudioFocus(value);
    if (i == 1) {
      SpUtil.putBool(IS_IGNORE_AUDIO_FOCUS, value);
    }
  }

  exit() {
    Get.defaultDialog(
      radius: 6.0,
      title: "退出登录",
      content: Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Text("退出之后部分功能无法正常使用！")),
      textCancel: "迷途知返",
      textConfirm: "一意孤行",
      buttonColor: Colors.transparent,
      onConfirm: (){
        SpUtil.putString(USER_ID_SP, "");
        Get.find<HomeController>().login.value = false;
        Get.back();
      }
    );
  }
}
