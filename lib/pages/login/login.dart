import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/constants/icon.dart';
import '../../common/constants/other.dart';
import '../../common/netease_api/src/api/bean.dart';
import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../widget/custom_filed.dart';
import '../user/user_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewStateP();
}

class _LoginViewStateP extends State<LoginView> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController pass = TextEditingController();
  Timer? timer;
  String qrCodeUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loginCallPhone(context) async {
    if (phone.text.isEmpty || pass.text.isEmpty) {
      WidgetUtil.showToast('账号密码为必填项，请检查');
      return;
    }
    WidgetUtil.showLoadingDialog(context);
    NeteaseAccountInfoWrap neteaseAccountInfoWrap;
    if (phone.text.contains('@')) {
      neteaseAccountInfoWrap = await NeteaseMusicApi().loginEmail(phone.text, pass.text);
    } else {
      neteaseAccountInfoWrap = await NeteaseMusicApi().loginCellPhone(phone.text, pass.text);
    }
    if (mounted) Navigator.of(context).pop();
    if (neteaseAccountInfoWrap.code != 200) {
      WidgetUtil.showToast(neteaseAccountInfoWrap.message ?? '未知错误');
      return;
    }
    UserController.to.getUserState();
    AutoRouter.of(context).pop();
  }

  getQrCode(context) async {
    QrCodeLoginKey qrCodeLoginKey = await NeteaseMusicApi().loginQrCodeKey();
    if (qrCodeLoginKey.code != 200) {
      WidgetUtil.showToast(qrCodeLoginKey.message ?? '未知错误');
      return;
    }
    String codeUrl = NeteaseMusicApi().loginQrCodeUrl(qrCodeLoginKey.unikey);
    setState(() => qrCodeUrl = codeUrl);
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) async {
      ServerStatusBean serverStatusBean = await NeteaseMusicApi().loginQrCodeCheck(qrCodeLoginKey.unikey);
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
  void dispose() {
    super.dispose();
    phone.dispose();
    timer?.cancel();
    pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Home.to.landscape? _loginL():_loginP();
  }


  Widget _loginP(){
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              margin: EdgeInsets.only(top: 20.w),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AppIcons.loginTop,
                        width: Get.width,
                        fit: BoxFit.fitWidth,
                      ),
                      SafeArea(
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                AutoRouter.of(context).pop();
                              },
                              icon: Icon(Icons.close, size: 52.sp)))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
                        CustomFiled(
                          iconData: TablerIcons.phone,
                          textEditingController: phone,
                          hitText: '输入邮箱/手机号',
                        ),
                        CustomFiled(
                          iconData: TablerIcons.lock,
                          textEditingController: pass,
                          hitText: '输入密码',
                          pass: true,
                        ),
                        GestureDetector(
                          child: Container(
                            height: 88.w,
                            alignment: Alignment.center,
                            width: Get.width,
                            margin: EdgeInsets.symmetric(vertical: 40.w, horizontal: 5.w),
                            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20.w)),
                            child: Text(
                              '立即登录',
                              style: TextStyle(fontSize: 28.sp, color: Colors.white),
                            ),
                          ),
                          onTap: () => loginCallPhone(context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 20.w),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    height: 1.w,
                                    color: Colors.grey.withOpacity(.6),
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Text(
                                  'Or',
                                  style: TextStyle(color: Colors.grey.withOpacity(.9)),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    height: 1.w,
                                    color: Colors.grey.withOpacity(.6),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 45.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  TablerIcons.qrcode,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.w, left: 10.w),
                                  child: const Text(
                                    '二维码登录',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            getQrCode(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: qrCodeUrl.isNotEmpty,
            child: GestureDetector(
              child: Container(
                color: Theme.of(context).cardColor.withOpacity(.5),
                width: Get.width,
                height: Get.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // QrImage(
                    //   backgroundColor: Colors.white,
                    //   data: qrCodeUrl,
                    //   version: QrVersions.auto,
                    //   size: 400.w,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.w),
                      child: Text(
                        '请扫描二维码码登录',
                        style: TextStyle(fontSize: 32.sp, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                timer?.cancel();
                timer = null;
                setState(() {
                  qrCodeUrl = '';
                });
              },
            ),
          )
        ],
      ),
    );
  }
  Widget _loginL(){
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(flex: 3,child:  Stack(
                children: [
                  SvgPicture.asset(
                    AppIcons.loginTop,
                    width: Get.width,
                    fit: BoxFit.fitWidth,
                  ),
                  SafeArea(
                      child: IconButton(
                          padding:  EdgeInsets.only(top:110.w,left:30.w),
                          onPressed: () {
                            AutoRouter.of(context).pop();
                          },
                          icon: Icon(Icons.close, size: 62.sp)))
                ],
              ),),
              Expanded(flex: 2,child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  margin: EdgeInsets.only(top: 20.w),
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
                            CustomFiled(
                              iconData: TablerIcons.phone,
                              textEditingController: phone,
                              hitText: '输入邮箱/手机号',
                            ),
                            CustomFiled(
                              iconData: TablerIcons.lock,
                              textEditingController: pass,
                              hitText: '输入密码',
                              pass: true,
                            ),
                            GestureDetector(
                              child: Container(
                                height: 88.w,
                                alignment: Alignment.center,
                                width: Get.width,
                                margin: EdgeInsets.symmetric(vertical: 40.w, horizontal: 5.w),
                                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20.w)),
                                child: Text(
                                  '立即登录',
                                  style: TextStyle(fontSize: 28.sp, color: Colors.white),
                                ),
                              ),
                              onTap: () => loginCallPhone(context),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.w, horizontal: 20.w),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        height: 1.w,
                                        color: Colors.grey.withOpacity(.6),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Text(
                                      'Or',
                                      style: TextStyle(color: Colors.grey.withOpacity(.9)),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        height: 1.w,
                                        color: Colors.grey.withOpacity(.6),
                                      )),
                                ],
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 45.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      TablerIcons.qrcode,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5.w, left: 10.w),
                                      child: const Text(
                                        '二维码登录',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                getQrCode(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),),
            ],
          ),
          Visibility(
            visible: qrCodeUrl.isNotEmpty,
            child: GestureDetector(
              child: Container(
                color: Theme.of(context).cardColor.withOpacity(.5),
                width: Get.width,
                height: Get.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImageView(
                      backgroundColor: Colors.white,
                      data: qrCodeUrl,
                      version: QrVersions.auto,
                      size: 400.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.w),
                      child: Text(
                        '请扫描二维码码登录',
                        style: TextStyle(fontSize: 32.sp, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                timer?.cancel();
                timer = null;
                setState(() {
                  qrCodeUrl = '';
                });
              },
            ),
          )
        ],
      ),
    );
  }
}



