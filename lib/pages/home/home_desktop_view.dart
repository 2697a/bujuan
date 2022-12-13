import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/left_menu/left_menu.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../widget/weslide/weslide.dart';

class HomeDesktopView extends GetView<HomeController> {
  const HomeDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _buildDesktop(),
    );
  }

  //桌面端布局之后横屏也采用该布局
  Widget _buildDesktop() {
    return Row(
      children: [
        const LeftMenu(),
        // Expanded(
        //     child: Obx(() => WeSlide(
        //           controller: controller.weSlideController,
        //           panelWidth: Get.width - (controller.isCollapsedAfterSec.isTrue ? 100.w : 300.w),
        //           bodyWidth: Get.width - (controller.isCollapsedAfterSec.isTrue ? 100.w : 300.w),
        //           body: GetMaterialApp(
        //             initialRoute: AppPages.inital,
        //             getPages: AppPages.routes,
        //             debugShowCheckedModeBanner: false,
        //             defaultTransition: Transition.fadeIn,
        //           ),
        //           panel: Container(
        //             width: Get.width,
        //             alignment: Alignment.center,
        //             child: const Text('我是播放区域'),
        //             color: Colors.transparent,
        //           ),
        //           panelMinSize: controller.panelHeaderSize,
        //           parallax: true,
        //           parallaxOffset: 1,
        //           panelMaxSize: Get.height,
        //           panelHeader: _buildPanelHeader(),
        //         ))),
      ],
    );
  }

  //移动端布局
  Widget _buildMobile() {
    return const SizedBox.shrink();
  }

  //底部播放栏
  // Widget _buildPanelHeader() {
  //   return InkWell(
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 20.w),
  //       height: controller.panelHeaderSize,
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           SimpleExtendedImage(
  //             'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3D0efa92278544ebf86d246c3becc9fb1c%2F8b82b9014a90f603161737633b12b31bb051ed6b.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1657277594&t=3e65a7e9a2ce4d736964bc7450c854f5',
  //             height: 100.w,
  //             width: 100.w,
  //           ),
  //           Expanded(
  //               child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 20.w),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   '发如雪',
  //                   style: TextStyle(fontSize: 28.sp),
  //                 ),
  //                 Text(
  //                   '周杰伦',
  //                   style: TextStyle(fontSize: 26.sp, color: Colors.grey),
  //                 ),
  //               ],
  //             ),
  //           )),
  //           const Icon(Icons.keyboard_arrow_up_outlined)
  //         ],
  //       ),
  //     ),
  //     onTap: () => controller.weSlideController.show(),
  //   );
  // }
}
