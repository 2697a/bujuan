import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/other.dart';

class SecondBodyView extends GetView<HomeController> {
  const SecondBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Opacity(
          opacity: controller.slidePosition.value,
          child: Column(
            children: [
              SizedBox(
                  height:
                      controller.getPanelMinSize() + controller.getTopHeight()),
              Padding(
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
              ),
              _buildSlide(),
              _buildPlayController(),
            ],
          ),
        ));
  }

  Widget _buildSlide() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 50.w, right: 20.w),
      child: Column(
        children: [
          SizedBox(
            height: 48.w,
            child: SliderTheme(
                data: SliderThemeData(
                    activeTrackColor: controller.rx.value.dark?.bodyTextColor,
                    trackHeight: 3.w,
                    thumbShape: RoundSliderThumbShape(
                        elevation: 0, enabledThumbRadius: 3.w),
                    thumbColor: Colors.transparent),
                child: Slider(
                    value: controller.duration.value.inMilliseconds /
                        (controller.mediaItem.value.duration?.inMilliseconds ??
                            0) *
                        100,
                    max: 100,
                    onChanged: (value) {
                      controller.audioServeHandler.seek(Duration(
                          milliseconds: (controller.mediaItem.value.duration
                                      ?.inMilliseconds ??
                                  0) *
                              value ~/
                              100));
                    })),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Row(
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
                      controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                  style: TextStyle(
                      color: controller.rx.value.dark?.bodyTextColor,
                      fontSize: 30.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlayController() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(
          left: 40.w,
          right: 40.w,
          bottom:
              controller.isRoot.value ? controller.secondPanelHeaderSize : 0),
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
                    const IconData(0xe63c, fontFamily: 'iconfont'),
                    size: 32.w,
                    color: controller.rx.value.dark?.bodyTextColor,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.w),
                      color: controller.rx.value.dark?.color,
                    ),
                    child: Icon(
                      controller.playing.value
                          ?  const IconData(0xe63e, fontFamily: 'iconfont') : const IconData(0xe63a, fontFamily: 'iconfont'),
                      size: 52.w,
                      color:
                      controller.rx.value.dark?.bodyTextColor.withOpacity(.6),
                    ),
                  ),
                  onTap: () => controller.playOrPause(),
                ),
              ),
              IconButton(
                  onPressed: () => controller.audioServeHandler.skipToNext(),
                  icon: Icon(
                    const IconData(0xe63d, fontFamily: 'iconfont'),
                    size: 32.w,
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
    ));
  }
}
