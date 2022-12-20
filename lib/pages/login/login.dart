import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/icon.dart';
import 'package:bujuan/pages/login/login_controller.dart';
import 'package:bujuan/widget/custom_filed.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tabler_icons/tabler_icons.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                                controller.onClose();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 52.sp,
                              )))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
                        CustomFiled(
                          iconData: TablerIcons.phone,
                          textEditingController: controller.phone,
                          hitText: '输入邮箱/手机号',
                        ),
                        CustomFiled(
                          iconData: TablerIcons.lock,
                          textEditingController: controller.pass,
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
                          onTap: () => controller.loginCallPhone(context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.w),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.w),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  TablerIcons.qrcode,
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.w, left: 10.w),
                                  child: const Text(
                                    '二维码登录',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              controller.getQrCode(context);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => Visibility(
            visible: controller.qrCodeUrl.value.isNotEmpty,
            child: GestureDetector(
              child: Container(
                color: Theme.of(context).cardColor.withOpacity(.5),
                width: Get.width,
                height: Get.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      backgroundColor: Colors.white,
                      data: controller.qrCodeUrl.value,
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
                controller.timer?.cancel();
                controller.timer = null;
              },
            ),
          ))
        ],
      ),
    );
  }
}
