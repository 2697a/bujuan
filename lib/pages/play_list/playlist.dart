import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class PlayList extends GetView<PlayListController> {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getData((context.routeData.args as Play).id);
    return GestureDetector(
      child: Stack(
        children: [
          SimpleExtendedImage(
            (context.routeData.args as Play).coverImgUrl ?? '',
            width: Get.width,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Song Sheet'),
              backgroundColor: Colors.transparent,
            ),
            body: AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(50.w)),
              padding: EdgeInsets.only(top: 30.w),
              margin: EdgeInsets.only(top: Get.width / 5),
              child: Obx(() => ListView.builder(
                    itemExtent: 120.w,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) => _buildItem(controller.mediaItems[index], index),
                    itemCount: controller.mediaItems.length,
                  )),
            ),
          )
        ],
      ),
      onHorizontalDragDown: (e) {
        return;
      },
    );
  }

  Widget _buildItem(MediaItem data, int index) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            SimpleExtendedImage(
              '${data.extras?['image'] ?? ''}?param=200y200',
              width: 85.w,
              height: 85.w,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                  Text(
                    data.artist ?? '',
                    style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () => controller.playIndex(index),
    );
    // return ListTile(
    //   dense: true,
    //   contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
    //   leading: SimpleExtendedImage(
    //     '${data.extras?['image'] ?? ''}?param=200y200',
    //     width: 80.w,
    //     height: 80.w,
    //   ),
    //   title: Text(data.title),
    //   subtitle: Text(data.artist??''),
    //   onTap: () {
    //     controller.playIndex(index);
    //   },
    // );
  }


}
