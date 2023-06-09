import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:macos_window_utils/widgets/titlebar_safe_area.dart';

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
            if (!Home.to.landscape) controller.myDrawerController.close!();
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
                if (!Home.to.landscape) controller.myDrawerController.close!();
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
                      : Theme.of(context).iconTheme.color)),
            ),
          ),
          itemCount: controller.leftMenus.length,
        )),
      ],
    ));
  }
}

class MenuViewL extends GetView<Home> {
  const MenuViewL({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.withOpacity(.2),width: .6.w))
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 35.w)),
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
                if (!Home.to.landscape) controller.myDrawerController.close!();
                Future.delayed(const Duration(milliseconds: 200), () {
                  context.router.pushNamed(Routes.userSetting);
                });
              },
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 40.w),
              itemCount: controller.leftMenus.length,
              itemBuilder: (context1, index) => InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32.w),
                  child: Obx(
                    () => Icon(controller.leftMenus[index].icon,
                        size: 54.w,
                        color: controller.currPathUrl.value == controller.leftMenus[index].pathUrl ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color),
                  ),
                ),
                onTap: () {
                  if (!Home.to.landscape) controller.myDrawerController.close!();
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
              ),
            )),
          ],
        ),
      ),
    );
  }
}
