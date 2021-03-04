import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:bujuan/bottom_bar/bottom_bar_view.dart';
import 'package:bujuan/global/global_state_view.dart';
import 'package:bujuan/sheet_info/sheet_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SheetInfoView extends GetView<SheetInfoController> {
  final id;

  SheetInfoView(this.id);

  @override
  Widget build(BuildContext context) {
    controller.getSheetInfo(id);
    return Scaffold(
      body: BottomBarView(
        panelController: controller.panelController,
        body: Obx(() => StateView(
              controller.loadState.value,
              widget: Scaffold(
                appBar: AppBar(
                  title: Text("${controller.result.value.name}"),
                ),
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Text(controller.result.value.tracks[index].ar[0].name),
                      title: Text(controller.result.value.tracks[index].name),
                      onTap: () {
                        Get.find<BottomBarController>().changeSong(controller.result.value.tracks[index]);
                      },
                    );
                  },
                  itemCount: controller.result.value.tracks == null ? 0 : controller.result.value.tracks.length,
                ),
              ),
            )),
      ),
    );
  }
}
