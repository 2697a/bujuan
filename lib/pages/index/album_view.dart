import 'package:bujuan/pages/index/index_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AlbumView extends GetView<IndexController> {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      itemBuilder: (context, index) => InkWell(
        child: Text(controller.albums[index].album),
        onTap:() => context.go('/details'),
      ),
      itemCount: controller.albums.length,
    ));
  }
}
