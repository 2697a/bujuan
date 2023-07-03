import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

class ZPlayListView extends GetView<Home> {
  const ZPlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPlayList(context);
  }

  //播放列表
  Widget buildPlayList(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: !controller.fm.value,
        child: Listener(
          onPointerMove: (event) {
            if (event.position.dy > controller.scrollDown.value && controller.playListScrollController.offset == 0) {
              controller.canScroll.value = false;
            } else {
              controller.canScroll.value = true;
            }
          },
          onPointerUp: (event){
            controller.canScroll.value = true;
          },
          onPointerDown: (event) {
            //记录手指放下的y位置
            controller.scrollDown.value = event.position.dy;
            controller.canScroll.value = true;
          },
          child: Obx(() => ListView.builder(
                physics: controller.canScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
                controller: controller.playListScrollController,
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                itemExtent: 110.w,
                itemBuilder: (context, index) => _buildPlayListItem(controller.mediaItems[index], index, context),
                itemCount: controller.mediaItems.length,
              )),
        ),
      );
    });
  }

  Widget _buildPlayListItem(MediaItem mediaItem, int index, BuildContext context) {
    // return ListTile(
    //   title: Obx(() => Text(
    //     mediaItem.title,
    //     maxLines: 1,
    //     style: TextStyle(color: controller.bodyColor.value),
    //   )),
    //   subtitle: Obx(() => Text(
    //     mediaItem.artist ?? '',
    //     maxLines: 1,
    //     style: TextStyle(color: controller.bodyColor.value),
    //   )),
    //   onTap: () => controller.audioServeHandler.playIndex(index),
    // );
    return InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.landscape
                  ? Text(
                      mediaItem.title,
                      maxLines: 1,
                      style: TextStyle(fontSize: 30.sp, color: (Theme.of(context).iconTheme.color ?? Colors.black)),
                    )
                  : Obx(() => Text(
                        mediaItem.title,
                        maxLines: 1,
                        style: TextStyle(fontSize: 30.sp, color: controller.bodyColor.value),
                      )),
              Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
              controller.landscape
                  ? Text(
                      mediaItem.artist ?? '',
                      maxLines: 1,
                      style: TextStyle(fontSize: 24.sp, color: (Theme.of(context).iconTheme.color ?? Colors.black)),
                    )
                  : Obx(() => Text(
                        mediaItem.artist ?? '',
                        maxLines: 1,
                        style: TextStyle(fontSize: 24.sp, color: controller.bodyColor.value),
                      ))
            ],
          )),
          Obx(() => Visibility(
                visible: controller.mediaItem.value.id == mediaItem.id,
                child: Icon(
                  TablerIcons.circle_letter_p,
                  color: controller.landscape ? (Theme.of(context).iconTheme.color ?? Colors.black) : controller.bodyColor.value,
                ),
              )),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
          IconButton(
              onPressed: () => controller.audioServeHandler.removeQueueItemAt(index),
              icon: controller.landscape
                  ? Icon(
                      TablerIcons.trash_x,
                      color: (Theme.of(context).iconTheme.color ?? Colors.black),
                      size: 42.w,
                    )
                  : Obx(() => Icon(
                        TablerIcons.trash_x,
                        color: controller.bodyColor.value,
                        size: 42.w,
                      )))
        ],
      ),
      onTap: () => controller.audioServeHandler.playIndex(index),
    );
  }
}
