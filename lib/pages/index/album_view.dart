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
      body: Obx(() => _buildAlbumView()),
    );
  }

  Widget _buildAlbumView() {
    return ListView.builder(
      padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: HomeController.to.getHomeBottomPadding()),
      itemCount: controller.albums.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildItem(controller.albums[index], index),
    );
  }

  Widget _buildItem(AlbumModel albumModel, index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                controller.colors[index].light?.color.withOpacity(.5) ??
                    Colors.transparent,
                controller.colors[index].dark?.color.withOpacity(.5) ??
                    Colors.transparent
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(20.w)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: index % 2 == 0,
                child: SimpleExtendedImage(
                  '${HomeController.to.directoryPath}${albumModel.id}',
                  cacheWidth: 400,
                  width: 250.w,
                  height: 250.w,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w),bottomLeft: Radius.circular(20.w)),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: index % 2 == 0?CrossAxisAlignment.end:CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                    child: Text(
                      albumModel.album,
                      style: TextStyle(fontSize: 48.sp,color: controller.colors[index].light?.bodyTextColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                    child: Text(
                      albumModel.artist ?? '',
                      style: TextStyle(fontSize: 34.sp,color: controller.colors[index].light?.bodyTextColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                    child: Text(
                      '${albumModel.numOfSongs} 首',
                      style: TextStyle(fontSize: 34.sp,color: controller.colors[index].light?.bodyTextColor),
                    ),
                  )
                ],
              )),
              Visibility(
                visible: index % 2 != 0,
                child: SimpleExtendedImage(
                  '${HomeController.to.directoryPath}${albumModel.id}',
                  cacheWidth: 400,
                  width: 250.w,
                  height: 250.w,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20.w),bottomRight: Radius.circular(20.w)),
                ),
              ),
            ],
          ),
        ),
        onTap: () => Get.toNamed(Routes.details,
            arguments: DetailsArguments(albumModel)),
      ),
    );
  }
}
