import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/mobile/flashy_navbar.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../../common/constants/other.dart';
import '../../../common/constants/platform_utils.dart';

class PanelView extends GetView<HomeController> {
  const PanelView({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.6);
    if (bottomHeight == 0) bottomHeight = 20.w;
    return GestureDetector(
      child: SlidingUpPanel(
        controller: controller.panelController,
        onPanelSlide: (value) {
          // TODO 忘记是干啥的了..... 应该是解决一大堆华东冲突
          controller.slidePosition.value = 1 - value;
          if (controller.second.value != value > 0.5) {
            controller.second.value = value > 0.5;
          }
        },
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          )
        ],
        color: Colors.transparent,
        panel: Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(top: 140.w),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    controller.rx.value.main?.color ?? Colors.transparent,
                    // controller.rx.value.light?.color ?? Colors.transparent,
                    Theme.of(context).bottomAppBarColor,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w))),
              child: Column(
                children: [
                  _buildSlide(showTime: false, disabled: true),
                  Expanded(
                      child: PreloadPageView.builder(
                    itemBuilder: (context, index) => controller.pages[index],
                    itemCount: controller.pages.length,
                    controller: controller.pageController,
                    preloadPagesCount: controller.pages.length,
                    onPageChanged: (index) {
                      controller.selectIndex.value = index;
                    },
                  ))
                ],
              ),
            )),
        body: Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).bottomAppBarColor,
                    controller.rx.value.main?.color ?? Colors.transparent,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w))),
              child: Column(
                children: [
                  // 歌曲信息
                  Obx(() => AnimatedOpacity(
                    opacity: controller.slidePosition.value,
                    duration: Duration.zero,
                    child: Container(
                      height: 60.h,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.panelControllerHome.close();
                              },
                              icon: Icon(
                                TablerIcons.chevron_down,
                                color: Theme.of(context).iconTheme.color?.withOpacity(.8),
                              )),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20.h),
                            height: 60.h,
                            width: 240.w,
                            // decoration: BoxDecoration(
                            //   color: controller.rx.value.light?.color.withOpacity(.6)??Colors.transparent,
                            //   borderRadius: BorderRadius.circular(25.h)
                            // ),
                            child: Text(
                              'Now Playing',
                              style: TextStyle(color: Theme.of(context).iconTheme.color?.withOpacity(.8), fontWeight: FontWeight.w500, fontSize: 32.sp),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                TablerIcons.brand_stackoverflow,
                                color: Theme.of(context).iconTheme.color?.withOpacity(.8),
                              )),
                        ],
                      ),
                    ),
                  )),
                  Obx(() => SizedBox(height: controller.getPanelMinSize())),
                  Obx(() => SizedBox(
                    height: 90.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.mediaItem.value.title,
                          style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6)),
                          maxLines: 1,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                        Text(
                          controller.mediaItem.value.artist ?? '',
                          style: TextStyle(fontSize: 24.sp, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6)),
                          maxLines: 1,
                        )
                      ],
                    ),
                  )),
                  //操控区域
                  _buildPlayController(),
                  //进度条
                  _buildSlide(),
                  //功能按钮
                  SizedBox(
                    height: 110.h + MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            )),
        header: _buildBottom(bottomHeight),
        minHeight: 110.h + bottomHeight,
        maxHeight: Get.height - controller.panelHeaderSize - MediaQuery.of(context).padding.top - 10.w,
      ),
      onHorizontalDragDown: (e) {
        return;
      },
    );
  }

  Widget _buildSlide({bool showTime = true, bool disabled = false}) {
    return Container(
      height: showTime ? 220.h : 100.h,
      padding: EdgeInsets.symmetric(horizontal: disabled ? 30.w : 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: showTime,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.w),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ImageUtils.getTimeStamp(controller.duration.value.inMilliseconds),
                      style: TextStyle(color: controller.rx.value.main?.bodyTextColor.withOpacity(.6), fontSize: 30.sp),
                    ),
                    Text(
                      ImageUtils.getTimeStamp(controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                      style: TextStyle(color: controller.rx.value.main?.bodyTextColor.withOpacity(.6), fontSize: 30.sp),
                    ),
                  ],
                );
              }),
            ),
          ),
          Visibility(
            visible: showTime,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.w),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 8.h)),
            ),
          ),
          Obx(() {
            return IgnorePointer(
              ignoring: disabled,
              child: SizedBox(
                width: Get.width,
                child: Visibility(
                  visible: controller.mediaItem.value.id.isNotEmpty,
                  child: FlutterRangeSlider(
                    min: 0,
                    disabled: disabled,
                    max: controller.mEffects.length.toDouble(),
                    values: [controller.duration.value.inMilliseconds / (controller.mediaItem.value.duration?.inMilliseconds ?? 0) * 100],
                    handler: FlutterSliderHandler(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: controller.rx.value.main?.color.withOpacity(.6) ?? Colors.black12,
                          // border: Border.all(color: controller.rx.value.dark?.color ?? Colors.transparent, width: 4.w),
                        ),
                        child: const SizedBox.shrink()),
                    handlerWidth: 22,
                    handlerHeight: 22,
                    touchSize: 18,
                    tooltip: FlutterSliderTooltip(disabled: true),
                    hatchMark: FlutterSliderHatchMark(
                        labels: controller.mEffects
                            .map((e) => FlutterSliderHatchMarkLabel(
                                percent: e['percent'],
                                label: Container(
                                  height: e['size'],
                                  decoration: BoxDecoration(
                                      color: controller.rx.value.main?.bodyTextColor.withOpacity(.6) ?? Colors.white.withOpacity(.3), borderRadius: BorderRadius.circular(1)),
                                  width: 1.3,
                                )))
                            .toList(),
                        linesAlignment: FlutterSliderHatchMarkAlignment.right,
                        density: 0.5),
                    trackBar: const FlutterSliderTrackBar(activeTrackBarHeight: .1, inactiveTrackBarHeight: .1, activeTrackBar: BoxDecoration(color: Colors.transparent)),
                    onDragCompleted: (a, b, c) {
                      if (!disabled) {
                        controller.audioServeHandler.seek(Duration(milliseconds: (controller.mediaItem.value.duration?.inMilliseconds ?? 0) * b ~/ 100));
                      }
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // height:329.h-MediaQuery.of(context).padding.top,
  Widget _buildPlayController() {
    return Expanded(child: Obx(() {
      return Padding(
        padding: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => controller.likeSong(),
                icon: Icon(UserController.to.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.hearts : TablerIcons.heart,
                    size: 44.w, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6))),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (controller.intervalClick(1)) {
                        controller.audioServeHandler.skipToPrevious();
                      }
                    },
                    icon: Icon(
                      TablerIcons.player_skip_back,
                      size: 46.w,
                      color: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
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
                        color: controller.rx.value.main?.color.withOpacity(.6),
                        // border: Border.all(color: controller.rx.value.main?.color.withOpacity(.8) ?? Colors.transparent, width: 0.w),
                      ),
                      child: Icon(
                        controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                        size: 52.w,
                        color: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
                      ),
                    ),
                    onTap: () => controller.playOrPause(),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (controller.intervalClick(1)) {
                        controller.audioServeHandler.skipToNext();
                      }
                    },
                    icon: Icon(
                      TablerIcons.player_skip_forward,
                      size: 46.w,
                      color: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
                    )),
              ],
            )),
            IconButton(
                onPressed: () => controller.changeRepeatMode(), icon: Icon(controller.getRepeatIcon(), size: 43.w, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6))),
          ],
        ),
      );
    }));
  }

  Widget _buildBottom(bottomHeight) {
    return Obx(() => Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(width: 70.w,height: 8.w,margin: EdgeInsets.only(top: 12.w),decoration: BoxDecoration(
            color: controller.rx.value.main?.bodyTextColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(4.w)
        ),),
        FlashyNavbar(
          height: 110.h,
          selectedIndex: controller.selectIndex.value,
          items: [
            FlashyNavbarItem(icon: const Icon(TablerIcons.atom_2)),
            FlashyNavbarItem(icon: const Icon(TablerIcons.playlist)),
            FlashyNavbarItem(icon: const Icon(TablerIcons.quote)),
            FlashyNavbarItem(icon: const Icon(TablerIcons.message_2)),
          ],
          onItemSelected: (index) {
            controller.pageController.jumpToPage(index);
            if (!controller.panelController.isPanelOpen) controller.panelController.open();
          },
          backgroundColor: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
        ),
      ],
    ));
  }
}

class BottomItem {
  IconData iconData;
  int index;
  VoidCallback? onTap;

  BottomItem(this.iconData, this.index, {this.onTap});
}
