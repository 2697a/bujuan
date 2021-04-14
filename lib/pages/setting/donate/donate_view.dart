import 'package:bujuan/pages/setting/donate/donate_controller.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateView extends GetView<DonateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('捐赠'),
      ),
      body: PreloadPageView.builder(
        itemBuilder: (context, index) {
          return Image.asset(controller.list[index]);
        },
        itemCount: controller.list.length,
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.currIndex.value = index;
        },
      ),
      bottomNavigationBar: Obx(() => TitledBottomNavigationBar(
              currentIndex: controller.currIndex.value,
              // Use this to update the Bar giving a position
              onTap: (index) {
                controller.pageController?.jumpToPage(index);
              },
              items: [
                TitledNavigationBarItem(
                    title: Text('支付宝'),
                    icon: Icons.workspaces_filled,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('微信'),
                    icon: Icons.workspaces_filled,
                    backgroundColor: Theme.of(Get.context).primaryColor),
              ])),
    );
  }
}
