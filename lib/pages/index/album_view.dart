import 'package:bujuan/pages/index/index_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumView extends GetView<IndexController> {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemBuilder: (context, index) => Text(controller.albums[index].album),
      itemCount: controller.albums.length,
    ));
  }
}
