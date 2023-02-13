import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/platform_utils.dart';
import '../../../widget/simple_extended_image.dart';
import 'menu_view.dart';

class BodyView extends GetView<Home> {
  const BodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.8);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: controller.globalKey,
      // drawer: Drawer(
      //   width: Get.width / 1.45,
      //   elevation: 0,
      //   child: const MenuView(),
      // ),
      // drawerScrimColor: Colors.transparent,
      // drawerEdgeDragWidth: 500.w,
      body: Stack(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(bottom: controller.panelHeaderSize + bottomHeight),
          //   child: const AutoRouter(),
          // )
          Obx(() =>Visibility(visible: controller.background.value.isNotEmpty,child: SimpleExtendedImage(
            controller.background.value,
            fit: BoxFit.cover,
            width: Get.width,
            height: Get.height,
          ),)),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.26),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: controller.panelHeaderSize + bottomHeight),
            child: const AutoRouter(),
          )
          // BackdropFilter(
          //   /// 过滤器
          //   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          //   /// 必须设置一个空容器
          //   child: Padding(
          //     padding: EdgeInsets.only(bottom: controller.panelHeaderSize + bottomHeight),
          //     child: const AutoRouter(),
          //   ),
          // )
        ],
      ),
      //
      // body: Obx(
      //       () => Stack(
      //     alignment: Alignment.topRight,
      //     children: [
      //       Positioned(
      //         top: -210.w,
      //         right: -200.w,
      //         child: Aurora(
      //           size: 800.w,
      //           colors: [
      //             controller.rx.value.lightVibrantColor?.color ?? Colors.transparent,
      //             controller.rx.value.dominantColor?.color ?? Colors.transparent,
      //           ],
      //           blur: 400,
      //         ),
      //       ),
      //       Visibility(
      //         visible: controller.leftImage.value,
      //         child: Positioned(
      //           top: -40.w,
      //           right: -75.w,
      //           child: Lottie.asset(
      //             'assets/lottie/vr_animation.json',
      //             width: Get.width / 1.6,
      //             fit: BoxFit.fitWidth,
      //             // filterQuality: FilterQuality.low,
      //           ),
      //         ),
      //       ),
      //       const AutoRouter(),
      //     ],
      //   ),
      // ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: AutoRouter(),
    );
  }
}
