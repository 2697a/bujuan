import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/first/first_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/simple_extended_image.dart';

class MenuView extends GetView<FirstController>{
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            SimpleExtendedImage.avatar(
              UserController.to.userData.value.profile?.avatarUrl ?? '',
              width: 200.w,
            ),
            Expanded(child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 140.w),
              itemBuilder: (context, index) => InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(controller.leftMenus[index].icon, color: Colors.white.withOpacity(.9)),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.w, top: 8.w),
                            child: Text(
                              controller.leftMenus[index].title,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          )),
                    ],
                  ),
                ),
                onTap: () {
                  controller.myDrawerController.close!();
                  Future.delayed(const Duration(milliseconds: 400), () => context.router.replaceNamed(controller.leftMenus[index].path));
                },
              ),
              itemCount: controller.leftMenus.length,
            )),
            ListTile(
              dense: true,
              title: Text('注销登陆',style: TextStyle(color: Colors.white),),
              onTap: (){
                UserController.to.clearUser();
              },
            )
          ],
        ));
  }

}