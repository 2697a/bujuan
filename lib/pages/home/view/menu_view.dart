import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/simple_extended_image.dart';

class MenuView extends GetView<HomeController> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
        GestureDetector(
          child: Obx(() => SimpleExtendedImage.avatar(
                UserController.to.userData.value.profile?.avatarUrl ?? '',
                width: 200.w,
              )),
          onTap: () {
            if (UserController.to.loginStatus.value == LoginStatus.noLogin) {
              context.router.pushNamed(Routes.login);
              return;
            }
            controller.myDrawerController.close!();
            Future.delayed(const Duration(milliseconds: 400), () {
              context.router.pushNamed(Routes.userSetting);
            });
          },
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 140.w),
          itemBuilder: (context1, index) => InkWell(
            child: Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 32.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 8.w,
                        height: 50.w,
                        color: controller.currPathUrl.value == controller.leftMenus[index].pathUrl ? Theme.of(context).primaryColor : Colors.transparent,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                      Icon(controller.leftMenus[index].icon,
                          color: controller.currPathUrl.value == controller.leftMenus[index].pathUrl ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(left: 30.w, top: 8.w),
                        child: Text(
                          controller.leftMenus[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  controller.currPathUrl.value == controller.leftMenus[index].pathUrl ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor),
                        ),
                      )),
                    ],
                  ),
                )),
            onTap: () {
              controller.myDrawerController.close!();
              Future.delayed(const Duration(milliseconds: 400), () {
                if (controller.leftMenus[index].path == Routes.setting) {
                  context.router.pushNamed(controller.leftMenus[index].path);
                  return;
                }
                context.router.replaceNamed(controller.leftMenus[index].path);
              });
            },
          ),
          itemCount: controller.leftMenus.length,
        )),
        // ListTile(
        //   leading: Icon(
        //     TablerIcons.settings,
        //     color: Theme.of(context).bottomAppBarColor,
        //   ),
        //   title: Text(
        //     '极光/渐变播放页面切换',
        //     style: TextStyle(color: Theme.of(context).bottomAppBarColor),
        //   ),
        //   onTap: () {
        //     controller.myDrawerController.close!();
        //     Future.delayed(const Duration(milliseconds: 400), () => HomeController.to.isAurora.value = !HomeController.to.isAurora.value);
        //   },
        // ),
      ],
    ));
  }
}
