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
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w)),
                  gradient: LinearGradient(colors: [
                    controller.rx.value.light?.color.withOpacity(
                            controller.second.value
                                ? 1
                                : controller.slidePosition.value) ??
                        Colors.transparent,
                    controller.rx.value.dark?.color.withOpacity(
                            controller.second.value
                                ? 1
                                : controller.slidePosition.value) ??
                        Colors.transparent
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            )),
        Column(
          children: [
            Obx(() => SizedBox(
                height:
                    controller.getPanelMinSize() + controller.getTopHeight())),
            Obx(() => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.mediaItem.value.title,
                            style: TextStyle(
                                fontSize: 36.sp,
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
                      )),
                    ],
                  ),
                )),
            _buildSlide(),
            _buildPlayController(),
          ],
        ),
      ],
    );
  }

  Widget _buildSlide() {
    print('bbbbbbbbbbbbbbbbbbbbbbbb');
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 20.w, right: 20.w),
      child: Column(
        children: [
          Obx(() {
            print('aaaaaaaaaaaaaaa');
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 40.w),
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
                      activeTrackBarHeight: .1, inactiveTrackBarHeight: .1),
                  onDragging: (a, b, c) => controller.audioServeHandler.seek(
                      Duration(
                          milliseconds: (controller.mediaItem.value.duration
                                      ?.inMilliseconds ??
                                  0) *
                              b ~/
                              100))),
            );
          }),
          // Obx(() =>  SizedBox(
          //   height: 48.w,
          //   child: SliderTheme(
          //       data: SliderThemeData(
          //           activeTrackColor: controller.rx.value.dark?.bodyTextColor,
          //           trackHeight: 3.w,
          //           thumbShape: RoundSliderThumbShape(
          //               elevation: 0, enabledThumbRadius: 3.w),
          //           thumbColor: Colors.transparent),
          //       child: Slider(
          //           value: controller.duration.value.inMilliseconds /
          //               (controller.mediaItem.value.duration?.inMilliseconds ??
          //                   0) *
          //               100,
          //           max: 100,
          //           onChanged: (value) {
          //             controller.audioServeHandler.seek(Duration(
          //                 milliseconds: (controller.mediaItem.value.duration
          //                     ?.inMilliseconds ??
          //                     0) *
          //                     value ~/
          //                     100));
          //           })),
          // ),),
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

  Widget _buildPlayController() {
    return Expanded(
        child: Obx(() => Padding(
              padding: EdgeInsets.only(
                  left: 40.w,
                  right: 40.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => controller.changeRepeatMode(),
                      icon: Icon(controller.getRepeatIcon(),
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
                            size: 46.w,
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
                              size: 62.w,
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
                            size: 46.w,
                            color: controller.rx.value.dark?.bodyTextColor,
                          )),
                    ],
                  )),
                  IconButton(
                      onPressed: () => controller.changeShuffleMode(),
                      icon: Icon(controller.getShuffleIcon(),
                          color: controller.rx.value.dark?.bodyTextColor)),
                ],
              ),
            )));
  }


  Widget _buildBottom(){
    return Container(
      height: 180.w,
      color: controller.rx.value.dark?.color,
      child: Row(
        children: [

        ],
      ),
    );
  }
}
