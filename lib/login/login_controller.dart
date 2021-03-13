import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/user/user_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  ///账号
  TextEditingController accountController;

  ///密码
  TextEditingController passController;

  @override
  void onInit() {
    accountController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  void login() async {
    var pass = passController.text;
    var account = accountController.text;
    var loginEntity = await NetUtils().loginByPhone(account, pass);
    if (loginEntity != null && loginEntity.code == 200) {
      SpUtil.putString(USER_ID_SP, "${loginEntity.profile.userId}");
      SpUtil.putString(
          USER_AVATAR, "${loginEntity.profile.avatarUrl}?param=300y300");
      Get.find<UserController>().changeLoginState(true, loginEntity);
      Get.find<HomeController>()
          .changeAvatar("${loginEntity.profile.avatarUrl}?param=300y300");
      Get.back();
    }
  }
}
