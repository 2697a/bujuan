import 'package:bujuan/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/cupertino_removable_text_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            _buildLoginView(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginView(context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 60.w),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24.w)),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 100.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    child: const Text(
                      ' Phone',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                RemovableTextField(
                  controller: controller.phone,
                  showDeleteIcon: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    child: const Text(
                      ' Pass',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                RemovableTextField(
                  controller: controller.pass,
                  contentPadding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 10.w),
                  showDeleteIcon: false,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        height: 80.w,
                        margin: EdgeInsets.symmetric(vertical: 60.w),
                        decoration: BoxDecoration(
                            color: Colors.red,
                          borderRadius: BorderRadius.circular(40.w)
                        ),
                        child: const Text('登录',style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                  onTap: () {
                    print('object');
                    controller.login(context);
                  },
                )
              ],
            ),
          ),
        ),
        Image.asset(
          'assets/images/logo.png',
          height: 120.w,
          width: 120.w,
        ),
      ],
    );
  }
}
