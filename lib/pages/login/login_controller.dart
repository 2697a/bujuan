import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/bean.dart';
import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/netease_api.dart';

class LoginController extends GetxController {
  final TextEditingController phone = TextEditingController();
  final TextEditingController pass = TextEditingController();
  Timer? timer;
  RxString qrCodeUrl = ''.obs;
  // CreatorController creatorController = CreatorController();

  @override
  onReday() {
    print('object');
  }

  loginCallPhone(context) {
    if (phone.text.isEmpty || pass.text.isEmpty) {
      WidgetUtil.showToast('账号密码为必填项，请检查');
      return;
    }
    NeteaseMusicApi().loginCellPhone(phone.text, pass.text).then((NeteaseAccountInfoWrap neteaseAccountInfoWrap) {
      if (neteaseAccountInfoWrap.code != 200) {
        WidgetUtil.showToast(neteaseAccountInfoWrap.message ?? '未知错误');
        return;
      }
      UserController.to.getUserState();
      AutoRouter.of(context).pop();
    });
  }

  getQrCode(context) async {
    QrCodeLoginKey qrCodeLoginKey = await NeteaseMusicApi().loginQrCodeKey();
    if (qrCodeLoginKey.code != 200) {
      WidgetUtil.showToast(qrCodeLoginKey.message ?? '未知错误');
      return;
    }
    String codeUrl = NeteaseMusicApi().loginQrCodeUrl(qrCodeLoginKey.unikey);
    qrCodeUrl.value = codeUrl;
    print('object============${qrCodeUrl}');
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      ServerStatusBean serverStatusBean = await NeteaseMusicApi().loginQrCodeCheck(qrCodeLoginKey.unikey);
      print('loginQrCodeCheck=====${jsonEncode(serverStatusBean.toJson())}');
      if (serverStatusBean.code == 800) {
        WidgetUtil.showToast('二维码过期请重新获取');
        timer?.cancel();
        timer = null;
        return;
      }
      if (serverStatusBean.code == 803) {
        WidgetUtil.showToast('授权成功！');
        UserController.to.getUserState();
        AutoRouter.of(context).pop();
        timer?.cancel();
        timer = null;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    phone.dispose();
    timer?.cancel();
    pass.dispose();
  }
}
