import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/simple_extended_image.dart';

class MenuView extends GetView<Home> {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
        GestureDetector(
          child: Obx(() => SimpleExtendedImage.avatar(
                '${controller.userData.value.profile?.avatarUrl ?? ''}?param=300y300',
                width: 90.w,
              )),
          onTap: () {
            if (controller.loginStatus.value == LoginStatus.noLogin) {
              context.router.pushNamed(Routes.login);
              return;
            }
            controller.myDrawerController.close!();
            Future.delayed(const Duration(milliseconds: 200), () {
              context.router.pushNamed(Routes.userSetting);
            });
          },
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 140.w),
          itemBuilder: (context1, index) => Container(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: IconButton(
              onPressed: () {
                controller.myDrawerController.close!();
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (controller.leftMenus[index].path.isEmpty) {
                    Home.to.sleep(context);
                    return;
                  }
                  if (controller.leftMenus[index].pathUrl.isEmpty) {
                    context.router.pushNamed(controller.leftMenus[index].path);
                    return;
                  }
                  context.router.replaceNamed(controller.leftMenus[index].path);
                });
              },
              icon: Obx(() => Icon(controller.leftMenus[index].icon,
                  size: 52.sp,
                  color: controller.currPathUrl.value == controller.leftMenus[index].pathUrl
                      ? Theme.of(context).primaryColor
                      : controller.leftImageNoObs
                          ? Theme.of(context).iconTheme.color
                          : Theme.of(context).scaffoldBackgroundColor)),
            ),
          ),
          itemCount: controller.leftMenus.length,
        )),
      ],
    ));
  }
}
