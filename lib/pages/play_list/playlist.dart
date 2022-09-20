import 'package:bujuan/common/bean/playlist_entity.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/widget/request_widget.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlayList extends GetView<PlayListController> {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RequestBox<PlaylistEntity>(
          url: '/playlist/detail',
          data: {'id': Get.arguments},
          onSuccess: (data) {
            controller.setPlayList(data.playlist?.tracks ?? []);
          },
          childBuilder: (data) => ListView.builder(
                itemBuilder: (context, index) => _buildItem((data.playlist?.tracks ?? [])[index],index),
                itemCount: (data.playlist?.tracks ?? []).length,
              )),
    );
  }

  Widget _buildItem(PlaylistPlaylistTracks data,int index) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 10.w),child: ListTile(
      leading: SimpleExtendedImage(data.al?.picUrl??''),
      title: Text(data.name ?? ''),
      onTap: (){
        controller.playIndex(index);
      },
    ),);
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: Text(data.name ?? ''),
      ),
      onTap: () => controller.playIndex(index),
    );
  }
}
