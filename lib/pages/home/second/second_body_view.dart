import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../../common/constants/other.dart';

class SecondBodyView extends GetView<HomeController> {
  const SecondBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.w),
                      topRight: Radius.circular(0.w)),
                  gradient: LinearGradient(colors: [
                    controller.rx.value.light?.color.withOpacity(
                            controller.second.value
                                ? 1
                                : controller.slidePosition.value) ??
                        Colors.white,
                    controller.rx.value.dark?.color.withOpacity(
                            controller.second.value
                                ? 1
                                : controller.slidePosition.value) ??
                        Colors.green
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            )),
        Column(
          children: [
            Obx(() => SizedBox(
                height:
                    controller.getPanelMinSize()+MediaQuery.of(context).padding.top )),
            Obx(() => SizedBox(
                  height: 110.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        controller.mediaItem.value.title,
                        style: TextStyle(
                            fontSize: 34.sp,
                            fontWeight: FontWeight.bold,
                            color: controller.rx.value.dark?.bodyTextColor),
                        maxLines: 1,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                      Text(
                        controller.mediaItem.value.artist ?? '',
                        style: TextStyle(
                            fontSize: 28.sp,
                            color: controller.rx.value.dark?.bodyTextColor),
                        maxLines: 1,
                      )
                    ],
                  ),
                )),
            // Container(
            //   color: Colors.green,
            //   height: 585.h+MediaQuery.of(context).padding.top,
            // ),
            _buildSlide(),
            _buildBottom(),
            _buildPlayController(),
          ],
        ),
      ],
    );
  }

  Widget _buildSlide() {
    return Container(
      height: 190.h,
      padding: EdgeInsets.only(left: 20.w,  right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: FlutterRangeSlider(
                  min: 0,
                  max: controller.effects.length.toDouble(),
                  values: [
                    controller.duration.value.inMilliseconds /
                        (controller.mediaItem.value.duration?.inMilliseconds ??
                            0) *
                        100
                  ],
                  handler: FlutterSliderHandler(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                              controller.rx.value.light?.color.withOpacity(.7) ??
                                  Colors.black12),
                      child: const SizedBox.shrink()),
                  handlerWidth: 8,
                  handlerHeight: 25,
                  touchSize: 20,
                  tooltip: FlutterSliderTooltip(disabled: true),
                  hatchMark: FlutterSliderHatchMark(
                      labels: controller.effects,
                      linesAlignment: FlutterSliderHatchMarkAlignment.right,
                      density: 0.5),
                  trackBar: const FlutterSliderTrackBar(
                      activeTrackBarHeight: .1, inactiveTrackBarHeight: .1,activeTrackBar: BoxDecoration(color: Colors.transparent)),
                  onDragging: (a, b, c) => controller.audioServeHandler.seek(
                      Duration(
                          milliseconds: (controller.mediaItem.value.duration
                                      ?.inMilliseconds ??
                                  0) *
                              b ~/
                              100))),
            );
          }),
          Padding(padding: EdgeInsets.symmetric(vertical: 8.h)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 0.w),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ImageUtils.getTimeStamp(
                          controller.duration.value.inMilliseconds),
                      style: TextStyle(
                          color: controller.rx.value.dark?.bodyTextColor,
                          fontSize: 30.sp),
                    ),
                    Text(
                      ImageUtils.getTimeStamp(
                          controller.mediaItem.value.duration?.inMilliseconds ??
                              0),
                      style: TextStyle(
                          color: controller.rx.value.dark?.bodyTextColor,
                          fontSize: 30.sp),
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
        child: Obx(() => SafeArea(top: false,child: Padding(
          padding: EdgeInsets.only(
              left: 40.w,
              right: 40.w,bottom: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => controller.changeRepeatMode(),
                  icon: Icon(controller.getRepeatIcon(),
                      size: 42.w,
                      color: controller.rx.value.dark?.bodyTextColor)),
              Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () =>
                              controller.audioServeHandler.skipToPrevious(),
                          icon: Icon(
                            const IconData(0xe636, fontFamily: 'iconfont'),
                            size: 42.w,
                            color: controller.rx.value.dark?.bodyTextColor,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(30.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.w),
                              color: controller.rx.value.light?.color.withOpacity(.5),
                            ),
                            child: Icon(
                              controller.playing.value
                                  ? const IconData(0xe638,
                                  fontFamily: 'iconfont')
                                  : const IconData(0xe634,
                                  fontFamily: 'iconfont'),
                              size: 50.w,
                              color: controller.rx.value.dark?.bodyTextColor
                                  .withOpacity(.6),
                            ),
                          ),
                          onTap: () => controller.playOrPause(),
                        ),
                      ),
                      IconButton(
                          onPressed: () =>
                              controller.audioServeHandler.skipToNext(),
                          icon: Icon(
                            const IconData(0xe637, fontFamily: 'iconfont'),
                            size: 42.w,
                            color: controller.rx.value.dark?.bodyTextColor,
                          )),
                    ],
                  )),
              IconButton(
                  onPressed: () => controller.changeShuffleMode(),
                  icon: Icon(controller.getShuffleIcon(),
                      size: 42.w,
                      color: controller.rx.value.dark?.bodyTextColor)),
            ],
          ),
        ),)));
  }


  Widget _buildBottom(){
    return Obx(() => SafeArea(top: false,bottom:false,child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.w),
        color: controller.rx.value.dark?.color.withOpacity(.05)
      ),
      height: 120.h,
      width: 670.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.alarm_rounded,color: controller.rx.value.dark?.bodyTextColor,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: controller.rx.value.dark?.bodyTextColor,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.playlist_play_sharp,color: controller.rx.value.dark?.bodyTextColor,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.lyrics_outlined,color: controller.rx.value.dark?.bodyTextColor,)),
        ],
      ),
    ),));
  }
}
