import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../routes/router.dart';

class LoginController extends HomeController {
  final TextEditingController phone = TextEditingController();
  final TextEditingController pass = TextEditingController();
  @override
onReday(){
  print('object');
}
  loginCallPhone(context) {
    NeteaseMusicApi().loginCellPhone(phone.text, pass.text).then((NeteaseAccountInfoWrap neteaseAccountInfoWrap)  {
      UserController.to.saveUser(neteaseAccountInfoWrap);
      AutoRouter.of(context).pop();
    });
  }

  @override
  void onClose() {
    super.onClose();
    phone.dispose();
    pass.dispose();
  }
}
