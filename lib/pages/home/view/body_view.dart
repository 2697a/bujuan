
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/platform_utils.dart';
import '../../../widget/simple_extended_image.dart';

class BodyView extends GetView<Home> {
  const BodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.85);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Home.to.landscape?Colors.transparent:null,
      body: Stack(
        children: [
          Obx(() => Visibility(
                visible: controller.background.value.isNotEmpty,
                child: SimpleExtendedImage(
                  controller.background.value ?? '',
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.height,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: controller.panelMobileMinSize+controller.panelAlbumPadding*2),
            child: const AutoRouter(),
          )
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
class BodyViewL extends GetView<Home> {
  const BodyViewL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.85);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Home.to.landscape?Colors.transparent:null,
      body: Stack(
        children: [
          Obx(() => Visibility(
            visible: controller.background.value.isNotEmpty,
            child: SimpleExtendedImage(
              Home.to.mediaItem.value.extras?['image'] ?? '',
              fit: BoxFit.cover,
              width: Get.width,
              height: Get.height,
            ),
          )),
          Padding(
            padding: EdgeInsets.only(bottom: controller.panelMobileMinSize+controller.panelAlbumPadding*2),
            child: const AutoRouter(),
          )
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
