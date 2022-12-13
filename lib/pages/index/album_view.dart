import 'package:bujuan/pages/home/first/first_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../home/home_controller.dart';

class AlbumView extends GetView<IndexController> {
  const AlbumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              if (controller.login.value) {
                controller.myDrawerController.open!();
                return;
              }
            },
            icon: Obx(() => SimpleExtendedImage.avatar('${HomeController.to.login.value ? controller.userData.value.profile?.avatarUrl : ''}'))),
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
              TextSpan(
                  text: '云盘～',
                  style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
            ])),
      ),
      body: Obx(() => _buildAlbumView()),
    );
  }

  Widget _buildAlbumView() {
    return GridView.builder(
      padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: FirstController.to.getHomeBottomPadding()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: .73, crossAxisSpacing: 20.w),
      itemBuilder: (context, index) => _buildItem(controller.albums[index], index),
      itemCount: controller.albums.length,
    );
  }

  Widget _buildItem(AlbumModel albumModel, index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleExtendedImage(
              '${HomeController.to.directoryPath}${albumModel.id}',
              cacheWidth: 400,
              width: (Get.width-60.w) / 2,
              height: (Get.width-60.w) / 2,
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                  child: Text(
                    albumModel.album,
                    style: TextStyle(fontSize: 28.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                  child: Text(
                    albumModel.artist ?? '',
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => Get.toNamed(Routes.details, arguments: DetailsArguments(albumModel)),
      ),
    );
  }
}
