import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/second/second_body_view.dart';
import 'package:bujuan/pages/home/second/second_panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/weslide/weslide.dart';

class SecondView extends GetView<HomeController> {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => WeSlide(
          controller: controller.weSlideController1,
          panelMaxSize: Get.height - controller.panelHeaderSize - controller.paddingTop - 10.w,
          panelMinSize: controller.getSecondPanelMinSize(),
          hidePanelHeader: false,
          boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
              gradient: LinearGradient(
                  colors: [controller.rx.value.light?.color ?? Colors.white, controller.rx.value.dark?.color ?? Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          onPosition: (value) => controller.changeSlidePosition(1 - value, second: true),
          body: const SecondBodyView(),
          panel: const SecondPanelView(),
          panelHeader: _buildSecondHead(),
        ));
  }

  Widget _buildSecondHead() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: controller.paddingBottom),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)), color: controller.rx.value.dark?.color ?? Colors.white),
        width: Get.width,
        height: controller.getSecondPanelMinSize(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.w),
              decoration: BoxDecoration(color: controller.rx.value.dark?.bodyTextColor, borderRadius: BorderRadius.circular(5.w)),
              width: 60.w,
              height: 8.w,
            ),
            Expanded(
                child: DefaultTabController(
              length: 3,
              child: TabBar(
                isScrollable: false,
                labelColor: controller.rx.value.dark?.bodyTextColor,
                unselectedLabelColor: controller.rx.value.dark?.titleTextColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: controller.rx.value.dark?.bodyTextColor,
                // indicator: const BoxDecoration(),
                labelStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 28.sp),
                onTap: (index) {
                  if (!controller.weSlideController1.isOpened) {
                    controller.weSlideController1.show();
                  }
                  controller.secondPageController.jumpToPage(index);
                },
                tabs: const [
                  Tab(
                    text: '列表',
                  ),
                  Tab(
                    text: '歌词',
                  ),
                  Tab(
                    text: '相关',
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        if (!controller.weSlideController1.isOpened) {
          controller.weSlideController1.show();
        }
      },
    );
  }
}
