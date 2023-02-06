import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/platform_utils.dart';
import '../../../widget/simple_extended_image.dart';

class BodyView extends GetView<HomeController> {
  const BodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.6);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Obx(() => Visibility(visible: controller.leftImage.value,child: SimpleExtendedImage(
            controller.mediaItem.value.extras!['image']+'?param=500y500',
            // 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201812%2F08%2F20181208180816_Svj8N.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1678285931&t=939264ffeb3cfa36778506271162f2bd',
            fit: BoxFit.cover,
            width: Get.width,
            height: Get.height,
          ),)),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.35),
          ),
          BackdropFilter(
            /// 过滤器
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            /// 必须设置一个空容器
            child: Padding(
              padding: EdgeInsets.only(bottom: controller.panelHeaderSize + bottomHeight),
              child: const AutoRouter(),
            ),
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
