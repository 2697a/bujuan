import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/icon.dart';
import 'package:bujuan/pages/login/login_controller.dart';
import 'package:bujuan/widget/custom_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../widget/cupertino_removable_text_field.dart';

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
                              },
                              icon:  Icon(Icons.close,size: 52.sp,)))
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),child: Column(
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
                      )
                    ],
                  ),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
