import 'package:aurora/aurora.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../common/constants/icon.dart';
import '../../../common/constants/platform_utils.dart';

class BodyView extends GetView<HomeController> {
  const BodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.6);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Obx(
      () => Scaffold(
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned(
              top: -210.w,
              right: -200.w,
              child: Aurora(
                size: 800.w,
                colors: [
                  controller.rx.value.light?.color.withOpacity(.25) ?? Colors.transparent,
                  controller.rx.value.main?.color.withOpacity(.25) ?? Colors.transparent,
                ],
                blur: 400,
              ),
            ),
            SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Opacity(opacity: .9,child: SvgPicture.asset(
                    AppIcons.meTop,
                    width: Get.width / 1.9,
                  ),),
                )),
            Padding(
              padding: EdgeInsets.only(
                bottom: controller.mediaItem.value.id.isNotEmpty ? controller.panelMobileMinSize + bottomHeight : 0,
              ),
              child: const AutoRouter(),
            )
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AutoRouter(),
    );
  }
}
