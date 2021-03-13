import 'package:bujuan/play_list/play_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayListView extends GetView<PlayListController> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${controller.playList[index].title}"),
          subtitle: Text("${controller.playList[index].artist}"),
          onTap: () => controller.playMusicByIndex(index),
        );
      },
      itemCount: controller.playList.length,
    );
  }
}
