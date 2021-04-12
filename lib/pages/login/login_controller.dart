import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';

class LoginController extends GetxController {
  ///账号
  TextEditingController accountController;

  ///密码
  TextEditingController passController;
  var state = ButtonState.idle.obs;

  @override
  void onInit() {
    accountController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  void login() async {
    FocusScope.of(Get.context).requestFocus(FocusNode());
    state.value = ButtonState.loading;
    var pass = passController.text;
    var account = accountController.text;
    if (account == '' || pass == '') {
      state.value = ButtonState.fail;
      restState();
      return;
    }
    var isEmail = GetUtils.isEmail(account);
    var loginEntity = isEmail ? await NetUtils().loginByEmail(account, pass) : await NetUtils().loginByPhone(account, pass);
    if (loginEntity != null && loginEntity.code == 200) {
      state.value = ButtonState.success;
     await SpUtil.putString(USER_ID_SP, '${loginEntity.profile.userId}');
     await HomeController.to.getUserProfile('${loginEntity.profile.userId}');
     await UserController.to.getUserSheet();
     await HomeController.to.getLikeSongList();
     Future.delayed(Duration(milliseconds: 600),()=>Get.back());
    } else {
      state.value = ButtonState.fail;
      restState();
    }
  }

  @override
  void onClose() {
    accountController.text = '';
    passController.text = '';
    super.onClose();
  }

  restState() {
    Future.delayed(Duration(milliseconds: 1200), () {
      state.value = ButtonState.idle;
    });
  }
}
