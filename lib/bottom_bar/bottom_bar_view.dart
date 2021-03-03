import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomBarView extends GetView<BottomBarController> {
  final Widget body;

  BottomBarView(this.body);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: controller.panelController,
      body: body,
      minHeight: 68.0,
      maxHeight: Get.height,
      color: Theme.of(context).primaryColor,
      panel: Center(
        child: Text("播放页面"),
      ),
      collapsed: InkWell(
        child: Container(
          child: Center(
            child: Text(
              "This is the collapsed Widget",
            ),
          ),
        ),
        onTap: () => controller.panelController.open(),
      ),
    );
  }
}
