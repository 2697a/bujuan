import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/global/global_state_view.dart';
import 'package:bujuan/sheet_info/sheet_info_binding.dart';
import 'package:bujuan/sheet_info/sheet_info_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindView extends GetView<FindController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => StateView(controller.loadState.value,
            widget: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 15, childAspectRatio: 1),
              itemCount: controller.result.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Hero(tag: "${controller.result[index].id}", child: CachedNetworkImage(
                    imageUrl: "${controller.result[index].picUrl}?param=500y500",
                  )),
                  onTap: () => Get.to(() => SheetInfoView(controller.result[index].id,controller.result[index].picUrl),binding: SheetInfoBinding()),
                );
              },
            ))));
  }
}
