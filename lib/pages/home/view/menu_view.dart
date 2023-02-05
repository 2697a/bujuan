import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
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
    return Container(
      color: Colors.white,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 25.w)),
        GestureDetector(
          child: Obx(() => SimpleExtendedImage.avatar(
            UserController.to.userData.value.profile?.avatarUrl ?? '',
            width: 90.w,
          )),
          onTap: () {
            if (UserController.to.loginStatus.value == LoginStatus.noLogin) {
              context.router.pushNamed(Routes.login);
              return;
            }
            controller.myDrawerController.close!();
            Future.delayed(const Duration(milliseconds: 300), () {
              context.router.pushNamed(Routes.userSetting);
            });
          },
        ),
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 140.w),
              itemBuilder: (context1, index) => ClassStatelessWidget(child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 32.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                      Obx(() => Icon(controller.leftMenus[index].icon,
                          color: controller.currPathUrl.value == controller.leftMenus[index].pathUrl ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onSecondary)),
                    ],
                  ),
                ),
                onTap: () {
                  controller.myDrawerController.close!();
                  Future.delayed(const Duration(milliseconds: 350), () {
                    if (controller.leftMenus[index].path == Routes.setting) {
                      context.router.pushNamed(controller.leftMenus[index].path);
                      return;
                    }
                    context.router.replaceNamed(controller.leftMenus[index].path);
                  });
                },
              )),
              itemCount: controller.leftMenus.length,
            )),
      ],
    ));
  }
}
