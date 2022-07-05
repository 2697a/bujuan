import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/wheel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../../common/constants/other.dart';

class SecondBodyView extends GetView<HomeController> {
  const SecondBodyView({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SlidingUpPanel(
          controller: controller.panelController,
          onPanelSlide: (value) {
            controller.slidePosition.value = 1 - value;
            if (controller.second.value != value > 0.5) {
              controller.second.value = value > 0.5;
              controller.isDownSlide = !controller.second.value;
              controller.update([controller.weSlideUpdate]);
            }
          },
          color: Colors.transparent,
          body: Stack(
            children: [
              Obx(() => Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [controller.rx.value.light?.color ?? Colors.transparent, controller.rx.value.dark?.color ?? Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  )),
              Column(
                children: [
                  Obx(() => SizedBox(height: controller.getPanelMinSize() + MediaQuery.of(context).padding.top)),
                  //歌曲信息
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Obx(() => SizedBox(
                          height: 110.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.mediaItem.value.title,
                                style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: controller.rx.value.dark?.bodyTextColor),
                                maxLines: 1,
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                              Text(
                                controller.mediaItem.value.artist ?? '',
                                style: TextStyle(fontSize: 28.sp, color: controller.rx.value.dark?.bodyTextColor),
                                maxLines: 1,
                              )
                            ],
                          ),
                        )),
                  ),
                  //操控区域
                  _buildPlayController(),
                  //进度条
                  _buildSlide(),
                  //功能按钮
                  SizedBox(
                    height: 100.h + MediaQuery.of(controller.buildContext).padding.bottom,
                  )
                ],
              ),
            ],
          ),
          panel: Obx(() => Container(
                decoration: BoxDecoration(color: controller.rx.value.dark?.color, borderRadius: BorderRadius.only(topLeft: Radius.circular(35.w), topRight: Radius.circular(35.w))),
                child: _buildPlayList(),
              )),
          header: _buildBottom(),
          minHeight: 100.h,
          maxHeight: Get.height - controller.getPanelMinSize() - MediaQuery.of(context).padding.top - 40.w,
        )),
        Obx(() => Container(
              decoration:
                  BoxDecoration(color: controller.rx.value.dark?.color, border: Border(top: BorderSide(color: controller.rx.value.dark?.color ?? Colors.transparent, width: 0))),
              height: MediaQuery.of(context).padding.bottom,
            ))
      ],
    );
  }

  Widget _buildSlide() {
    return Container(
      height: 220.h,
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.w),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ImageUtils.getTimeStamp(controller.duration.value.inMilliseconds),
                      style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 30.sp),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                      decoration: BoxDecoration(color: controller.rx.value.dark?.color.withOpacity(.1)),
                      child: Text(
                        '${controller.mediaItem.value.extras?['type'].toString().toUpperCase()}',
                        style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 28.sp),
                      ),
                    ),
                    Text(
                      ImageUtils.getTimeStamp(controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                      style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 30.sp),
                    ),
                  ],
                )),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 18.h)),
          Obx(() {
            return SizedBox(
              width: Get.width,
              child: FlutterRangeSlider(
                min: 0,
                max: controller.effects.length.toDouble(),
                values: [controller.duration.value.inMilliseconds / (controller.mediaItem.value.duration?.inMilliseconds ?? 0) * 100],
                handler: FlutterSliderHandler(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: controller.rx.value.light?.color.withOpacity(.7) ?? Colors.black12,
                        border: Border.all(color: controller.rx.value.dark?.color.withOpacity(.6) ?? Colors.transparent, width: 4.w)),
                    child: const SizedBox.shrink()),
                handlerWidth: 22,
                handlerHeight: 22,
                touchSize: 18,
                tooltip: FlutterSliderTooltip(disabled: true),
                hatchMark: FlutterSliderHatchMark(labels: controller.effects, linesAlignment: FlutterSliderHatchMarkAlignment.right, density: 0.5),
                trackBar: const FlutterSliderTrackBar(activeTrackBarHeight: .1, inactiveTrackBarHeight: .1, activeTrackBar: BoxDecoration(color: Colors.transparent)),
                onDragCompleted: (a, b, c) => controller.audioServeHandler.seek(Duration(milliseconds: (controller.mediaItem.value.duration?.inMilliseconds ?? 0) * b ~/ 100)),
              ),
            );
          }),
        ],
      ),
    );
  }

  // height:329.h-MediaQuery.of(context).padding.top,
  Widget _buildPlayController() {
    return Expanded(
        child: Obx(() => Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: () => controller.changeRepeatMode(), icon: Icon(controller.getRepeatIcon(), size: 46.w, color: controller.rx.value.dark?.bodyTextColor)),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => controller.audioServeHandler.skipToPrevious(),
                          icon: Icon(
                            TablerIcons.playerSkipBack,
                            size: 46.w,
                            color: controller.rx.value.dark?.bodyTextColor,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(bottom: 5.h),
                            height: 100.h,
                            width: 100.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.w),
                                color: controller.rx.value.light?.color.withOpacity(.5),
                                border: Border.all(color: controller.rx.value.dark?.color.withOpacity(.2) ?? Colors.transparent, width: 6.w)),
                            child: Icon(
                              controller.playing.value ? TablerIcons.playerPause : TablerIcons.playerPlay,
                              size: 52.w,
                              color: controller.rx.value.dark?.bodyTextColor.withOpacity(.6),
                            ),
                          ),
                          onTap: () => controller.playOrPause(),
                        ),
                      ),
                      IconButton(
                          onPressed: () => controller.audioServeHandler.skipToNext(),
                          icon: Icon(
                            TablerIcons.playerSkipForward,
                            size: 46.w,
                            color: controller.rx.value.dark?.bodyTextColor,
                          )),
                    ],
                  )),
                  IconButton(onPressed: () => controller.changeShuffleMode(), icon: Icon(controller.getShuffleIcon(), size: 42.w, color: controller.rx.value.dark?.bodyTextColor)),
                ],
              ),
            )));
  }

  Widget _buildBottom() {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          height: 100.h,
          width: 750.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    TablerIcons.thumbUp,
                    color: controller.rx.value.dark?.bodyTextColor,
                  )),
              IconButton(
                  onPressed: () {
                    controller.panelController.open();
                  },
                  icon: Icon(
                    TablerIcons.playlist,
                    color: controller.rx.value.dark?.bodyTextColor,
                  )),
              IconButton(
                  onPressed: () {
                    controller.panelController.open();
                  },
                  icon: Icon(
                    TablerIcons.quote,
                    color: controller.rx.value.dark?.bodyTextColor,
                  )),
              IconButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                      context: controller.buildContext,
                      builder: (_) => _buildSleep(),
                      duration: const Duration(milliseconds: 320),
                    );
                  },
                  icon: Icon(
                    TablerIcons.alarm,
                    color: controller.rx.value.dark?.bodyTextColor,
                  )),
            ],
          ),
        ));
  }

  //歌词
  Widget _buildLyric() {
    return Material(
      child: Obx(() => Container(
            height: Get.height * .8,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [controller.rx.value.light?.color ?? Colors.transparent, controller.rx.value.dark?.color ?? Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                  ],
                ),
                Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
                  child: Text(controller.lyricList.value),
                ))
              ],
            ),
          )),
    );
  }

  //播放列表
  Widget _buildPlayList() {
    return Container(
      padding: EdgeInsets.only(top: 100.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.w),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.mediaItem.value.title,
                      style: TextStyle(fontSize: 28.sp, color: controller.rx.value.light?.color),
                    ),
                    Text(
                      controller.mediaItem.value.artist ?? '',
                      style: TextStyle(fontSize: 28.sp, color: controller.rx.value.light?.color),
                    )
                  ],
                )),
                LoadingAnimationWidget.staggeredDotsWave(color: controller.rx.value.light?.color ?? Colors.black12, size: 38.w),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              child: _buildPlayListItem(controller.audioServeHandler.queue.value[index], index),
            ),
            itemCount: controller.audioServeHandler.queue.value.length,
          ))
        ],
      ),
    );
  }

  Widget _buildPlayListItem(MediaItem mediaItem, int index) {
    bool playing = controller.mediaItem.value.id == mediaItem.id;
    return InkWell(
      child: SizedBox(
        width: Get.width,
        height: 110.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SimpleExtendedImage(
              mediaItem.artUri?.path ?? '',
              width: 75.w,
              height: 75.w,
              cacheWidth: 200,
              borderRadius: BorderRadius.circular(10.w),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 12.w)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mediaItem.title,
                  style: TextStyle(fontSize: 28.sp, color: playing ? controller.rx.value.light?.color : controller.rx.value.dark?.bodyTextColor),
                ),
                Text(
                  mediaItem.artist ?? '',
                  style: TextStyle(fontSize: 24.sp, color: playing ? controller.rx.value.light?.color : controller.rx.value.dark?.bodyTextColor),
                )
              ],
            )),
          ],
        ),
      ),
      onTap: () => controller.audioServeHandler.skipToQueueItem(index),
    );
  }

  Widget _buildSleep() {
    return Material(
      color: Colors.transparent,
      child: Obx(() => Container(
            height: Get.height * .4,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [controller.rx.value.light?.color ?? Colors.transparent, controller.rx.value.dark?.color ?? Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: Text(
                    '${controller.sleep.value}分钟',
                    style: TextStyle(fontSize: 100.w, color: controller.rx.value.dark?.color.withOpacity(.6)),
                  ),
                )),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100.w),
                    child: WheelSlider(
                      totalCount: 100,
                      perspective: 0.01,
                      initValue: controller.sleep.value,
                      lineColor: controller.rx.value.light?.color,
                      pointerColor: controller.rx.value.dark?.titleTextColor ?? Colors.black,
                      onValueChanged: (val) {
                        print('object========$val');
                        controller.sleep.value = val;
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
