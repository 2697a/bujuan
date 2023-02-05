import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/mobile/flashy_navbar.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keframe/keframe.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../common/constants/other.dart';
import '../../../common/constants/platform_utils.dart';
import '../../../routes/router.gr.dart';

class PanelView extends GetView<HomeController> {
  const PanelView({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.6);
    if (bottomHeight == 0) bottomHeight = 20.w;
    return WillPopScope(
        child: GestureDetector(
          child: SlidingUpPanel(
            controller: controller.panelController,
            onPanelSlide: (value) {
              controller.slidePosition.value = 1 - value;
              if (controller.second.value != value >= 0.5) controller.second.value = value > 0.5;
            },
            boxShadow: const [
              BoxShadow(
                blurRadius: 8.0,
                color: Color.fromRGBO(0, 0, 0, 0.05),
              )
            ],
            color: Colors.transparent,
            panel: ClassWidget(child: _buildDefaultPanel(context, bottomHeight)),
            body: ClassWidget(child: Visibility(child: _buildDefaultBody1(context))),
            header: ClassWidget(child: _buildBottom(bottomHeight, context)),
            minHeight: 110.h + bottomHeight,
            maxHeight: Get.height - controller.panelHeaderSize - MediaQuery.of(context).padding.top - 10.w,
          ),
          onHorizontalDragDown: (e) {
            return;
          },
        ),
        onWillPop: () => controller.onWillPop());
  }

  Widget _buildSlide(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50.w, right: 50.w, bottom: 50.w),
      height: 100.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClassStatelessWidget(
              child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            addAutomaticKeepAlives: false,
            cacheExtent: 1.3,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            itemBuilder: (context, index) => Obx(() => Container(
                  margin: EdgeInsets.symmetric(vertical: controller.mEffects[index]['size'] / 2, horizontal: 3.w),
                  decoration: BoxDecoration(color: controller.bodyColor.value, borderRadius: BorderRadius.circular(4)),
                  width: 1.8,
                )),
            itemCount: controller.mEffects.length,
          )),
          ClassWidget(
              child: Obx(() => ProgressBar(
                    progress: controller.duration.value,
                    buffered: controller.duration.value,
                    total: controller.mediaItem.value.duration ?? const Duration(seconds: 10),
                    progressBarColor: Colors.transparent,
                    baseBarColor: Colors.transparent,
                    bufferedBarColor: Colors.transparent,
                    thumbColor: controller.bodyColor.value.withOpacity(.1),
                    barHeight: 0.w,
                    thumbRadius: 20.w,
                    barCapShape: BarCapShape.square,
                    timeLabelType: TimeLabelType.remainingTime,
                    timeLabelLocation: TimeLabelLocation.none,
                    timeLabelTextStyle: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                    onSeek: (duration) {
                      controller.audioServeHandler.seek(duration);
                    },
                  )))
        ],
      ),
    );
  }

  // height:329.h-MediaQuery.of(context).padding.top,
  Widget _buildPlayController(BuildContext context) {
    return Expanded(
        child: ClassWidget(
            child: Padding(
      padding: EdgeInsets.only(left: 40.w, right: 40.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => IconButton(
              onPressed: () => controller.likeSong(),
              icon: Icon(UserController.to.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.hearts : TablerIcons.heart,
                  size: 44.w, color: controller.bodyColor.value))),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => IconButton(
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
                    color: controller.bodyColor.value,
                  ))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: InkWell(
                  child: Obx(() => Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 5.h),
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.w),
                          color: controller.bodyColor.value.withOpacity(.1),
                        ),
                        child: Icon(
                          controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                          size: 52.w,
                          color: controller.bodyColor.value,
                        ),
                      )),
                  onTap: () => controller.playOrPause(),
                ),
              ),
              Obx(() => IconButton(
                  onPressed: () {
                    if (controller.intervalClick(1)) {
                      controller.audioServeHandler.skipToNext();
                    }
                  },
                  icon: Icon(
                    TablerIcons.player_skip_forward,
                    size: 46.w,
                    color: controller.bodyColor.value,
                  ))),
            ],
          )),
          Obx(() => IconButton(
              onPressed: () {
                if (controller.fm.value) {
                  return;
                }
                controller.changeRepeatMode();
              },
              icon: Icon(
                controller.getRepeatIcon(),
                size: 43.w,
                color: controller.bodyColor.value,
              ))),
        ],
      ),
    )));
  }

  // Widget functionWidget({required Widget child}) {
  //   return Container(child: child);
  // }

  Widget _buildBottom(bottomHeight, context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Obx(() => Container(
              width: 70.w,
              height: 8.w,
              margin: EdgeInsets.only(top: 12.w),
              decoration: BoxDecoration(color: controller.bodyColor.value.withOpacity(.3), borderRadius: BorderRadius.circular(4.w)),
            )),
        Obx(() => FlashyNavbar(
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
              backgroundColor: controller.bodyColor.value,
            )),
      ],
    );
  }

  Widget _buildDefaultBody(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                !controller.panelOpenPositionThan1.value && !controller.second.value
                    ? Theme.of(context).bottomAppBarColor
                    : !controller.gradientBackground.value
                        ? controller.rx.value.dominantColor?.color ?? Colors.transparent
                        : controller.rx.value.lightVibrantColor?.color ??
                            controller.rx.value.lightMutedColor?.color ??
                            controller.rx.value.dominantColor?.color ??
                            Colors.transparent,
                controller.rx.value.dominantColor?.color ?? Colors.transparent,
              ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
            ),
          );
        }),
        BackdropFilter(
          /// 过滤器
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),

          /// 必须设置一个空容器
          child: _buildBodyContent(context),
        ),
      ],
    );
  }

  Widget _buildDefaultBody1(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Visibility(visible: controller.panelOpenPositionThan1.value,child: SimpleExtendedImage(controller.mediaItem.value.extras!['image']+ '?param=500y500',fit: BoxFit.cover,height: Get.height,width: Get.width,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),),);
        }),
        Container(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
          child: BackdropFilter(
            /// 过滤器
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            /// 必须设置一个空容器
            child: _buildBodyContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultPanel(BuildContext context, bottomHeight) {
    return Stack(
      children: [
        // Obx(() {
        //   return SimpleExtendedImage(controller.mediaItem.value.extras!['image']+ '?param=500y500',fit: BoxFit.cover,height: Get.height,width: Get.width,
        //     borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),);
        // }),
        // Container(
        //   color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
        // ),
        // Obx(() => Visibility(
        //       replacement: AnimatedContainer(
        //         duration: const Duration(milliseconds: 200),
        //         decoration: BoxDecoration(
        //           color: controller.rx.value.dominantColor?.color ?? Colors.transparent,
        //           borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //         ),
        //       ),
        //       visible: controller.gradientBackground.value,
        //       child: AnimatedContainer(
        //           duration: const Duration(milliseconds: 200),
        //           decoration: BoxDecoration(
        //             gradient: LinearGradient(colors: [
        //               controller.rx.value.dominantColor?.color ?? Colors.transparent,
        //               !controller.gradientBackground.value
        //                   ? controller.rx.value.dominantColor?.color ?? Colors.transparent
        //                   : controller.rx.value.lightVibrantColor?.color ??
        //                       controller.rx.value.lightMutedColor?.color ??
        //                       controller.rx.value.dominantColor?.color ??
        //                       Colors.transparent,
        //             ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        //             borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //           )),
        //     )),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
          child: BackdropFilter(
            /// 过滤器
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            /// 必须设置一个空容器
            child: _buildPanelContent(context, bottomHeight),
          ),
        ),
      ],
    );
  }

  Widget _buildPanelContent(BuildContext context, bottomHeight) {
    return Padding(
      padding: EdgeInsets.only(top: 110.h + bottomHeight),
      child: PreloadPageView.builder(
        itemBuilder: (context, index) => controller.pages[index],
        itemCount: controller.pages.length,
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        preloadPagesCount: controller.pages.length,
        onPageChanged: (index) {
          controller.selectIndex.value = index;
        },
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      children: [
        // 歌曲信息
        Obx(() {
          return Visibility(
            visible: controller.panelOpenPositionThan1.value && !controller.second.value,
            replacement: Container(
              height: 70.h,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Container(
              height: 70.h,
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => IconButton(
                      onPressed: () {
                        controller.panelControllerHome.close();
                      },
                      icon: Icon(
                        TablerIcons.chevron_down,
                        color: controller.bodyColor.value,
                      ))),
                  Expanded(
                    child: Obx(() => Visibility(
                          visible: controller.topLyric.value,
                          child: Obx(() => Text(
                                controller.currLyric.value.fixAutoLines(),
                                style: TextStyle(fontSize: 28.sp, color: controller.bodyColor.value),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )),
                        )),
                  ),
                  Obx(() => Visibility(
                        visible: (controller.mediaItem.value.extras?['mv'] ?? 0) > 0,
                        child: IconButton(
                            onPressed: () {
                              // context.router.push(const MvView().copyWith(queryParams: {'mvId': controller.mediaItem.value.extras?['mv'] ?? 0}));
                            },
                            icon: Icon(
                              TablerIcons.brand_youtube,
                              color: controller.bodyColor.value,
                            )),
                      )),
                  Obx(() => IconButton(
                      onPressed: () {
                        WidgetUtil.showToast('分享暂未开启');
                      },
                      icon: Icon(
                        TablerIcons.brand_stackoverflow,
                        color: controller.bodyColor.value,
                      ))),
                ],
              ),
            ),
          );
        }),
        ClassWidget(
            child: Obx(() => Visibility(
                  visible: controller.isDraggable.value,
                  replacement: SizedBox(
                    height: 100.w * 7,
                  ),
                  child: Obx(() => SizedBox(
                        height: controller.getPanelMinSize(),
                      )),
                ))),
        ClassWidget(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 55.w),
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                    controller.mediaItem.value.title.fixAutoLines(),
                    style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: controller.bodyColor.value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
              Obx(() => Text(
                    (controller.mediaItem.value.artist ?? '').fixAutoLines(),
                    style: TextStyle(fontSize: 28.sp, color: controller.bodyColor.value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        )),
        // //操控区域
        _buildPlayController(context),
        ClassWidget(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    OtherUtils.getTimeStamp(controller.duration.value.inMilliseconds),
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp, fontWeight: FontWeight.bold),
                  )),
              Obx(() => Text(
                    OtherUtils.getTimeStamp(controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        )),
        // //进度条
        _buildSlide(context),
        //功能按钮
        ClassWidget(
            child: SizedBox(
          height: 110.h + MediaQuery.of(context).padding.bottom,
        )),
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

extension FixAutoLines on String {
  String fixAutoLines() {
    return Characters(this).join('\u{200B}');
  }
}

class ClassWidget extends StatelessWidget {
  final Widget child;

  const ClassWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FrameSeparateWidget(child: child);
  }
}

class ClassStatelessWidget extends StatelessWidget {
  final Widget child;

  const ClassStatelessWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
