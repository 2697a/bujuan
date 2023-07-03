import 'package:bujuan/pages/play_list/playlist_view.dart';
import 'package:bujuan/pages/playlist_manager/playlist_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlaylistManagerView extends GetView<PlaylistManager> {
  const PlaylistManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => ListView.builder(itemBuilder: (context,index) => PlayListItem( play: controller.playlist[index]),itemCount: controller.playlist.length,)),
    );
  }
}
