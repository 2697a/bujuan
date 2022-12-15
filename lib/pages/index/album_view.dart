import 'package:bujuan/pages/index/index_controller.dart';
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
            icon: Obx(() => SimpleExtendedImage.avatar('${UserController.to.loginStatus.value ? UserController.to.userData.value.profile?.avatarUrl : ''}'))),
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
              TextSpan(
                  text: '云盘～',
                  style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
            ])),
      ),
      body: FutureBuilder<List<CloudData>>(
          future: controller.getCloudData(),
          builder: (c, s) => DataView<List<CloudData>>(
              snapshot: s,
              childBuilder: ListView.builder(
                itemBuilder: (context, index) => _buildItem((s.data ?? [])[index], index),
                itemCount: (s.data ?? []).length,
              ))),
    );
  }

  Widget _buildItem(CloudData data, int index) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: SimpleExtendedImage(
        '${data.simpleSong?.al?.picUrl?? ''}?param=200y200',
        width: 80.w,
        height: 80.w,
      ),
      title: Text(data.songName??''),
      subtitle: Text(data.artist??''),
      onTap: () {
        // controller.playIndex(index);
      },
    );
  }
}
