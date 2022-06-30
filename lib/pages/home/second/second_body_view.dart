import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../../common/constants/other.dart';

class SecondBodyView extends GetView<HomeController> {
  const SecondBodyView({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                controller.rx.value.light?.color.withOpacity(controller.slidePosition.value) ?? Colors.transparent,
                controller.rx.value.dark?.color.withOpacity(controller.slidePosition.value) ?? Colors.transparent
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
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
                      // mainAxisAlignment: MainAxisAlignment.center,
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
            _buildBottom(),
          ],
        ),
      ],
    );
  }

  Widget _buildSlide() {
    return Container(
      height: 220.h,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return FlutterRangeSlider(
              min: 0,
              max: controller.effects.length.toDouble(),
              values: [controller.duration.value.inMilliseconds / (controller.mediaItem.value.duration?.inMilliseconds ?? 0) * 100],
              handler: FlutterSliderHandler(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: controller.rx.value.light?.color.withOpacity(.7) ?? Colors.black12,
                      border: Border.all(color: controller.rx.value.dark?.color.withOpacity(.6) ?? Colors.transparent, width: 4.w)),
                  child: const SizedBox.shrink()),
              handlerWidth: 24,
              handlerHeight: 24,
              touchSize: 24,
              tooltip: FlutterSliderTooltip(disabled: true),
              hatchMark: FlutterSliderHatchMark(labels: controller.effects, linesAlignment: FlutterSliderHatchMarkAlignment.right, density: 0.5),
              trackBar: const FlutterSliderTrackBar(activeTrackBarHeight: .1, inactiveTrackBarHeight: .1, activeTrackBar: BoxDecoration(color: Colors.transparent)),
              onDragCompleted: (a, b, c) => controller.audioServeHandler.seek(Duration(milliseconds: (controller.mediaItem.value.duration?.inMilliseconds ?? 0) * b ~/ 100)),
            );
          }),
          Padding(padding: EdgeInsets.symmetric(vertical: 8.h)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 0.w),
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
          )
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
                  IconButton(onPressed: () => controller.changeRepeatMode(), icon: Icon(controller.getRepeatIcon(), size: 42.w, color: controller.rx.value.dark?.bodyTextColor)),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => controller.audioServeHandler.skipToPrevious(),
                          icon: Icon(
                            const IconData(0xe636, fontFamily: 'iconfont'),
                            size: 42.w,
                            color: controller.rx.value.dark?.bodyTextColor,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(26.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80.w),
                                color: controller.rx.value.light?.color.withOpacity(.5),
                                border: Border.all(color: controller.rx.value.dark?.color.withOpacity(.2) ?? Colors.transparent, width: 10.w)),
                            child: Icon(
                              controller.playing.value ? const IconData(0xe638, fontFamily: 'iconfont') : const IconData(0xe634, fontFamily: 'iconfont'),
                              size: 50.w,
                              color: controller.rx.value.dark?.bodyTextColor.withOpacity(.6),
                            ),
                          ),
                          onTap: () => controller.playOrPause(),
                        ),
                      ),
                      IconButton(
                          onPressed: () => controller.audioServeHandler.skipToNext(),
                          icon: Icon(
                            const IconData(0xe637, fontFamily: 'iconfont'),
                            size: 42.w,
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
    return Obx(() => SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(35.w), color: controller.rx.value.dark?.color.withOpacity(.05)),
            height: 120.h,
            width: 670.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.alarm_rounded,
                      color: controller.rx.value.dark?.bodyTextColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: controller.rx.value.dark?.bodyTextColor,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.playlist_play_sharp,
                      color: controller.rx.value.dark?.bodyTextColor,
                    )),
                IconButton(
                    onPressed: () {
                      showCupertinoModalBottomSheet(
                        context: controller.buildContext,
                        builder: (_) => _buildLyric(),
                        secondAnimation: controller.animationController,
                        closeProgressThreshold: .8
                      );
                    },
                    icon: Icon(
                      Icons.lyrics_outlined,
                      color: controller.rx.value.dark?.bodyTextColor,
                    )),
              ],
            ),
          ),
        ));
  }

  Widget _buildLyric() {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: Get.height - controller.panelHeaderSize-controller.getHeaderPadding().top,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          controller.rx.value.light?.color.withOpacity(controller.slidePosition.value) ?? Colors.transparent,
          controller.rx.value.dark?.color.withOpacity(controller.slidePosition.value) ?? Colors.transparent
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            alignment: Alignment.center,
            child: Text(
              controller.lyricList[index].mainText ?? '',
              style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
            ),
          ),
          itemCount: controller.lyricList.length,
        ),
      ),
    );
  }
}
