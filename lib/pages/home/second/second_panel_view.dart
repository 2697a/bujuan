import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SecondPanelView extends GetView<HomeController> {
  const SecondPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Get.width,
          padding: EdgeInsets.only(top: controller.secondPanelHeaderSize + MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)), color: controller.rx.value.dark?.color ?? Colors.white),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.secondPageController,
            children: [
              _buildPlayList(),
              _buildLyricList(),
              Text(controller.lyric.value),
            ],
          ),
        ));
  }

  Widget _buildPlayList() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          controller.offset = notification.metrics.pixels;
          return false;
        },
        child: Listener(
          onPointerMove: (event) {
            // 触摸事件过程 手指一直在屏幕上且发生距离滑动
            if (controller.isScroll.value != !(controller.offset == 0 && event.position.dy > controller.down)) {
              controller.isScroll.value = !(controller.offset == 0 && event.position.dy > controller.down);
            }
          },
          onPointerUp: (event) {
            controller.isScroll.value = true;
          },
          onPointerDown: (event) {
            controller.down = event.position.dy;
          },
          child: ListView.builder(
            physics: controller.isScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildPlayListItem(controller.audioServeHandler.queue.value[index], index),
            itemCount: controller.audioServeHandler.queue.value.length,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
          ),
        ));
  }

  Widget _buildPlayListItem(MediaItem audio, int index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio.title,
                  style: TextStyle(color: controller.rx.value.dark?.bodyTextColor,fontSize: 28.sp),
                ),
                Text(
                  '${audio.artist ?? ''}  ${ImageUtils.getTimeStamp(audio.duration?.inMilliseconds??0)}',
                  style: TextStyle(color: controller.rx.value.dark?.bodyTextColor,fontSize: 24.sp),
                )
              ],
            )),
            Offstage(
              offstage: controller.mediaItem.value.id != audio.id,
              child: LoadingAnimationWidget.staggeredDotsWave(color: controller.rx.value.dark?.bodyTextColor??Colors.white, size: 38.w),
            )
          ],
        ),
      ),
      onTap: () => controller.audioServeHandler.skipToQueueItem(index),
    );
  }

  Widget _buildLyricList() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          controller.offset = notification.metrics.pixels;
          return false;
        },
        child: Listener(
          onPointerMove: (event) {
            // 触摸事件过程 手指一直在屏幕上且发生距离滑动
            if (controller.isScroll.value != !(controller.offset == 0 && event.position.dy > controller.down)) {
              controller.isScroll.value = !(controller.offset == 0 && event.position.dy > controller.down);
            }
          },
          onPointerUp: (event) {
            controller.isScroll.value = true;
          },
          onPointerDown: (event) {
            controller.down = event.position.dy;
          },
          child: ListView.builder(
            physics: controller.isScroll.value ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => _buildLyricItem((controller.lyric.value).split('\n')[index]),
            itemCount: (controller.lyric.value).split('\n').length,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
          ),
        ));
  }

  Widget _buildLyricItem(String lyric) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
        child: Text(
          lyric,
          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor),
        ),
      ),
    );
  }
}
