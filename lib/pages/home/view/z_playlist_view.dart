import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PlayListView extends GetView<HomeController>{
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPlayList();
  }


  //播放列表
  Widget buildPlayList() {
    return Obx(() => ListView.builder(
      physics: const ClampingScrollPhysics(),
      controller: controller.playListScrollController,
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      itemExtent: 110.w,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.centerLeft,
        child: _buildPlayListItem(controller.mediaItems[index], index),
      ),
      itemCount: controller.mediaItems.length,
    ));
  }

  Widget _buildPlayListItem(MediaItem mediaItem, int index) {
    return InkWell(
      child: Obx(() => SizedBox(
        width: Get.width,
        height: 110.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mediaItem.title,
                      maxLines: 1,
                      style: TextStyle(fontSize: 30.sp, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6)),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
                    Text(
                      mediaItem.artist ?? '',
                      maxLines: 1,
                      style: TextStyle(fontSize: 24.sp, color: controller.rx.value.main?.bodyTextColor.withOpacity(.4)),
                    )
                  ],
                )),
            Visibility(
              visible: controller.mediaItem.value.id == mediaItem.id,
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: controller.rx.value.main?.bodyTextColor.withOpacity(.6) ?? Colors.red,
                size: 40.w,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
            IconButton(
                onPressed: () {
                  controller.audioServeHandler.removeQueueItemAt(index);
                },
                icon: Icon(
                  TablerIcons.trash_x,
                  color: controller.rx.value.main?.bodyTextColor.withOpacity(.4),
                  size: 42.w,
                ))
          ],
        ),
      )),
      onTap: () => controller.audioServeHandler.playIndex(index),
    );
  }

}