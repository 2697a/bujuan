import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/play/cloud_entity.dart';
import '../../widget/data_widget.dart';
import '../home/home_controller.dart';
import '../user/user_controller.dart';

class AlbumView extends GetView<IndexController> {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              if (UserController.to.loginStatus.value) {
                HomeController.to.myDrawerController.open!();
                return;
              }
            },
            icon: Obx(() => SimpleExtendedImage.avatar('${UserController.to.loginStatus.value ? UserController.to.userData.value.profile?.avatarUrl : ''}',width: 85.w))),
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
          TextSpan(text: '云盘～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
        ])),
      ),
      body: RequestWidget<CloudEntity>(
          dioMetaData: controller.cloudSongDioMetaData(limit: 80),
          childBuilder: (data) {
            List<MediaItem> list = (data.data ?? []).map((e) => MediaItem(
                id: '${e.songId}',
                duration: Duration(milliseconds: e.simpleSong?.dt ?? 0),
                artUri: Uri.parse('${e.simpleSong?.al?.picUrl ?? ''}?param=500y500'),
                extras: {'url': '', 'image': e.simpleSong?.al?.picUrl ?? '', 'type': '', 'available': false},
                title: e.songName ?? "",
                artist: (e.simpleSong?.ar ?? []).map((e) => e.name).toList().join(' / '))).toList();
            controller.mediaItems..clear()..addAll(list);
            return ListView.builder(
              itemBuilder: (context, index) => _buildItem(list[index], index),
              itemCount: list.length,
            );
          }),
    );
  }

  Widget _buildItem(MediaItem data, int index) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: SimpleExtendedImage(
        '${data.extras!['image']}?param=200y200',
        width: 80.w,
        height: 80.w,
      ),
      title: Text(data.title ?? ''),
      subtitle: Text(data.artist ?? ''),
      onTap: () {
        controller.playIndex(index);
      },
    );
  }
}
