import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../../common/constants/other.dart';
import '../../../common/constants/platform_utils.dart';
import '../../../widget/list_wheel/clickable_list_wheel_widget.dart';

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
            controller.isDownSlide.value = !controller.second.value;
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
              duration: const Duration(milliseconds: 150),
              padding: EdgeInsets.only(top: 140.w),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    controller.rx.value.main?.color ?? Colors.transparent,
                    controller.rx.value.light?.color ?? Colors.transparent,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))),
              child: Column(
                children: [
                  _buildSlide(showTime: false, disabled: true),
                  Expanded(
                      child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) => controller.selectIndex.value = index,
                    children: [
                      _buildPlayList(),
                      _buildLyric(),
                    ],
                  ))
                ],
              ),
            )),
        body: Stack(
          children: [
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Theme.of(context).bottomAppBarColor,
                        controller.rx.value.light?.color ?? Colors.transparent,
                        controller.rx.value.main?.color ?? Colors.transparent,
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))),
                )),
            Column(
              children: [
                Obx(() => SizedBox(height: controller.getPanelMinSize() + MediaQuery.of(context).padding.top)),
                // 歌曲信息
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Obx(() => SizedBox(
                        height: 140.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.mediaItem.value.title,
                              style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.bold, color: controller.rx.value.main?.bodyTextColor),
                              maxLines: 1,
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                            Text(
                              controller.mediaItem.value.artist ?? '',
                              style: TextStyle(fontSize: 28.sp, color: controller.rx.value.main?.bodyTextColor),
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
                  height: 100.h + MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ],
        ),
        header: _buildBottom(bottomHeight),
        minHeight: 100.h + bottomHeight,
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
      padding: EdgeInsets.only(left: 40.w, right: 40.w),
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
              child: Padding(padding: EdgeInsets.symmetric(vertical: 18.h)),
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
                          color: controller.rx.value.dark?.color.withOpacity(.6) ?? Colors.black12,
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
        padding: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => controller.changeRepeatMode(), icon: Icon(controller.getRepeatIcon(), size: 46.w, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6))),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (controller.intervalClick(1)) {
                        controller.buttonCarouselController.previousPage(duration: const Duration(milliseconds: 150), curve: Curves.linear);
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
                        color: controller.rx.value.dark?.color.withOpacity(.4),
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
                        controller.buttonCarouselController.nextPage(duration: const Duration(milliseconds: 150), curve: Curves.linear);
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
                onPressed: () => controller.changeShuffleMode(),
                icon: Icon(controller.getShuffleIcon(), size: 42.w, color: controller.rx.value.main?.bodyTextColor.withOpacity(.6))),
          ],
        ),
      );
    }));
  }

  Widget _buildBottom(bottomHeight) {
    return Column(
      children: [
        Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              height: 100.h,
              width: 710.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(
                      UserController.to.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.thumb_up : TablerIcons.thumb_up_off,
                      color: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
                    ),
                    onTap: () async {},
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8.w),
                        height: 8.w,
                        width: 8.w,
                        color: controller.selectIndex.value == 0 ? controller.rx.value.main?.bodyTextColor.withOpacity(.6) : Colors.transparent,
                      ),
                      IconButton(
                          onPressed: () {
                            if (!controller.panelController.isPanelOpen) controller.panelController.open();
                            controller.pageController.jumpToPage(0);
                          },
                          icon: Icon(
                            TablerIcons.playlist,
                            color: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
                          )),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8.w),
                        height: 8.w,
                        width: 8.w,
                        color: controller.selectIndex.value == 1 ? controller.rx.value.main?.bodyTextColor.withOpacity(.6) : Colors.transparent,
                      ),
                      IconButton(
                          onPressed: () {
                            if (!controller.panelController.isPanelOpen) controller.panelController.open();
                            controller.pageController.jumpToPage(1);
                          },
                          icon: Icon(
                            TablerIcons.quote,
                            color: controller.rx.value.main?.bodyTextColor.withOpacity(.6),
                          )),
                    ],
                  ),
                  InkWell(
                    child: Icon(
                      TablerIcons.message_2,
                      color: controller.rx.value.main?.bodyTextColor,
                    ),
                    onTap: () => controller.buildContext.router.push(const TalkView().copyWith(args: controller.mediaItem.value.id)),
                  ),
                ],
              ),
            )),
        GestureDetector(
          child: Container(
            width: Get.width,
            color: Colors.transparent,
            height: bottomHeight,
          ),
          onVerticalDragDown: (e) {
            return;
          },
        )
      ],
    );
  }

  //播放列表
  Widget _buildPlayList() {
    return ListView.builder(
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
    );
  }

  Widget _buildPlayListItem(MediaItem mediaItem, int index) {
    return InkWell(
      child: SizedBox(
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
                  style: TextStyle(fontSize: 30.sp, color: controller.rx.value.main?.bodyTextColor),
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
                color: controller.rx.value.main?.bodyTextColor ?? Colors.red,
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
      ),
      onTap: () => controller.buttonCarouselController.jumpToPage(index),
    );
  }

  //歌词
  Widget _buildLyric() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
      child: Visibility(
        visible: controller.lyricsLineModels.isNotEmpty,
        replacement: Center(
          child: Text('暂无歌词～', style: TextStyle(fontSize: 34.sp, color: controller.rx.value.light?.color)),
        ),
        child: Listener(
          onPointerDown: (event) {
            controller.onMove.value = true;
          },
          onPointerMove: (event) {
            //手指移动暂停歌词自动滚动
            controller.onMove.value = true;
          },
          onPointerUp: (event) {
            //手指放开 延时三秒开始自动滚动（用户三秒期间可以滑动到指定位置并播放）
            Future.delayed(const Duration(milliseconds: 1500), () => controller.onMove.value = false);
          },
          child: ClickableListWheelScrollView(
            itemHeight: controller.lyricsLineModelsTran.isNotEmpty ? 162.w : 90.w,
            itemCount: controller.lyricsLineModels.length,
            onItemTapCallback: (index) {
              //点击歌词
              controller.audioServeHandler.seek(Duration(milliseconds: controller.lyricsLineModels[index].startTime ?? 0));
            },
            scrollController: controller.lyricScrollController,
            child: ListWheelScrollView.useDelegate(
              itemExtent: controller.lyricsLineModelsTran.isNotEmpty ? 162.w : 90.w,
              controller: controller.lyricScrollController,
              physics: const ClampingScrollPhysics(),
              overAndUnderCenterOpacity: 0.5,
              perspective: 0.0001,
              onSelectedItemChanged: (index) {
                //TODO 此处可以获取实时歌词
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) => Container(
                  width: Get.width,
                  height: controller.lyricsLineModelsTran.isNotEmpty ? 162.w : 90.w,
                  alignment: Alignment.center,
                  child: Text(
                    controller.lyricsLineModels[index].mainText ?? '',
                    style: TextStyle(fontSize: controller.lyricsLineModelsTran.isNotEmpty ? 28.sp : 32.sp, color: controller.rx.value.main?.bodyTextColor),
                    textAlign: TextAlign.center,
                    maxLines: 4,
                  ),
                ),
                childCount: controller.lyricsLineModels.length,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //评论列表
  Widget _buildTalkList() {
    return Container();
  }
}

class BottomItem {
  IconData iconData;
  int index;

  BottomItem(this.iconData, this.index);
}

class _MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
