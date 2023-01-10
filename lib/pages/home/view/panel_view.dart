import 'package:aurora/aurora.dart';
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
      child: Obx(() => SlidingUpPanel(
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
            onPanelOpened: () {
              controller.didChangePlatformBrightness();
            },
            onPanelClosed: () {
              controller.changeStatusIconColor(true);
            },
            color: Colors.transparent,
            panel: Visibility(
              visible: controller.isAurora.value,
              replacement: _buildDefaultPanel(context),
              child: _buildAuroraPanel(context),
            ),
            body: Visibility(
              visible: controller.isAurora.value,
              replacement: _buildDefaultBody(context),
              child: _buildAuroraBody(context),
            ),
            header: _buildBottom(bottomHeight, context),
            minHeight: 110.h + bottomHeight,
            maxHeight: Get.height - controller.panelHeaderSize - MediaQuery.of(context).padding.top - 10.w,
          )),
      onHorizontalDragDown: (e) {
        return;
      },
    );
  }

  Widget _buildSlide(BuildContext context, {bool showTime = true, bool disabled = false}) {
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
                      style: TextStyle(color: controller.getPlayPageTheme(context), fontSize: 30.sp),
                    ),
                    Text(
                      ImageUtils.getTimeStamp(controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                      style: TextStyle(color: controller.getPlayPageTheme(context), fontSize: 30.sp),
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
                          color: controller.rx.value.main?.bodyTextColor.withOpacity(.2) ?? Colors.black12,
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
                                  decoration: BoxDecoration(color: controller.getPlayPageTheme(context), borderRadius: BorderRadius.circular(1)),
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
  Widget _buildPlayController(BuildContext context) {
    return Expanded(child: Obx(() {
      return Padding(
        padding: EdgeInsets.only(left: 40.w, right: 40.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => controller.likeSong(),
                icon: Icon(UserController.to.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.hearts : TablerIcons.heart,
                    size: 44.w, color: controller.getPlayPageTheme(context))),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (controller.fm.value) {
                        return;
                      }
                      if (controller.intervalClick(1)) {
                        controller.audioServeHandler.skipToPrevious();
                      }
                    },
                    icon: Icon(
                      TablerIcons.player_skip_back,
                      size: 46.w,
                      color: controller.getPlayPageTheme(context).withOpacity(controller.fm.value ? 0.3 : .7),
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
                        color: controller.rx.value.main?.bodyTextColor.withOpacity(.2) ?? Colors.black12,
                      ),
                      child: Icon(
                        controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                        size: 52.w,
                        color: controller.getPlayPageTheme(context),
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
                      color: controller.getPlayPageTheme(context),
                    )),
              ],
            )),
            IconButton(
                onPressed: () {
                  if (controller.fm.value) {
                    return;
                  }
                  controller.changeRepeatMode();
                },
                icon: Icon(
                  controller.getRepeatIcon(),
                  size: 43.w,
                  color: controller.getPlayPageTheme(context).withOpacity(controller.fm.value ? 0.3 : .7),
                )),
          ],
        ),
      );
    }));
  }

  Widget _buildBottom(bottomHeight, context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 70.w,
            height: 8.w,
            margin: EdgeInsets.only(top: 12.w),
            decoration: BoxDecoration(color: controller.getPlayPageTheme(context).withOpacity(.5), borderRadius: BorderRadius.circular(4.w)),
          ),
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
            backgroundColor: controller.getPlayPageTheme(context),
          ),
        ],
      );
    });
  }

  Widget _buildDefaultBody(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                controller.slidePosition.value < 0.1 && !controller.second.value
                    ? Theme.of(context).bottomAppBarColor
                    : !controller.gradientBackground.value
                        ? controller.rx.value.main?.color ?? Colors.transparent
                        : controller.rx.value.light?.color ?? Colors.transparent,
                controller.rx.value.main?.color ?? Colors.transparent,
              ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w))),
          child: _buildBodyContent(context),
        ));
  }

  Widget _buildDefaultPanel(BuildContext context) {
    return Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              controller.rx.value.main?.color ?? Colors.transparent,
              !controller.gradientBackground.value ? controller.rx.value.main?.color ?? Colors.transparent : controller.rx.value.light?.color ?? Colors.transparent,
              // controller.rx.value.main?.color ?? Colors.transparent,
              // Theme.of(context).bottomAppBarColor,
            ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w))),
        child: _buildPanelContent(context)));
  }

  Widget _buildAuroraBody(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: -100.w - 110 * controller.slidePosition.value,
                right: -200.w * controller.slidePosition.value,
                child: Aurora(
                  size: 800.w,
                  colors: [
                    controller.rx.value.light?.color.withOpacity(.5) ?? Colors.transparent,
                    controller.rx.value.main?.color.withOpacity(.5) ?? Colors.transparent,
                  ],
                  blur: 400,
                ),
              ),
              Positioned(
                bottom: -110.w,
                left: -200.w,
                child: Aurora(
                  size: 800.w,
                  colors: [
                    controller.rx.value.light?.color.withOpacity(.4) ?? Colors.transparent,
                    controller.rx.value.main?.color.withOpacity(.4) ?? Colors.transparent,
                  ],
                  blur: 400,
                ),
              ),
              _buildBodyContent(context)
            ],
          ),
        ));
  }

  Widget _buildAuroraPanel(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only(top: 0.w),
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w))),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: -140.h + (460.h * (1 - controller.slidePosition.value)),
                child: Aurora(
                  size: 800.w,
                  colors: [
                    controller.rx.value.light?.color.withOpacity(.4) ?? Colors.transparent,
                    controller.rx.value.main?.color.withOpacity(.4) ?? Colors.transparent,
                  ],
                  blur: 400,
                ),
              ),
              _buildPanelContent(context)
            ],
          ),
        ));
  }

  Widget _buildPanelContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 140.w),
      child: Column(
        children: [
          _buildSlide(context, showTime: false, disabled: true),
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
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      children: [
        // 歌曲信息
        Obx(() => AnimatedOpacity(
              opacity: controller.slidePosition.value,
              duration: Duration.zero,
              child: Container(
                height: 70.h,
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
                          color: controller.getPlayPageTheme(context),
                        )),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 5.w),
                        height: 60.h,
                        // decoration: BoxDecoration(
                        //   color: controller.rx.value.light?.color.withOpacity(.6)??Colors.transparent,
                        //   borderRadius: BorderRadius.circular(25.h)
                        // ),
                        child: Text(
                          controller.mediaItem.value.artist ?? '',
                          style: TextStyle(color: controller.getPlayPageTheme(context), fontWeight: FontWeight.w500, fontSize: 32.sp),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          TablerIcons.brand_stackoverflow,
                          color: controller.getPlayPageTheme(context),
                        )),
                  ],
                ),
              ),
            )),
        Obx(() => Container(
              height: controller.getPanelMinSize(),
            )),
        Obx(() => SizedBox(
              height: 90.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.mediaItem.value.title,
                    style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: controller.getPlayPageTheme(context)),
                    maxLines: 1,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                  Text(
                    controller.mediaItem.value.artist ?? '',
                    style: TextStyle(fontSize: 28.sp, color: controller.getPlayPageTheme(context)),
                    maxLines: 1,
                  )
                ],
              ),
            )),
        //操控区域
        _buildPlayController(context),
        //进度条
        _buildSlide(context),
        //功能按钮
        SizedBox(
          height: 110.h + MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}

class BottomItem {
  IconData iconData;
  int index;
  VoidCallback? onTap;

  BottomItem(this.iconData, this.index, {this.onTap});
}
