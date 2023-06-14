import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/z_lyric_view.dart';
import 'package:bujuan/pages/home/view/z_playlist_view.dart';
import 'package:bujuan/widget/mobile/flashy_navbar.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../common/constants/other.dart';
import '../../../common/constants/platform_utils.dart';
import '../../../widget/swipeable.dart';

class PanelView extends GetView<Home> {
  const PanelView({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.8);
    if (bottomHeight == 0) bottomHeight = 30.w;
    return SlidingUpPanel(
      controller: controller.panelController,
      onPanelSlide: (value) {
        controller.changeSlidePosition(1 - value, status: false);
        controller.slideSecondPosition.value = value;
        if (value >= 0.001) {
          controller.second.value = value >= 0.001;
        }
      },
      color: Colors.transparent,
      body: _buildDefaultBody(context),
      panel: Padding(
        padding: EdgeInsets.only(top: 110.w + bottomHeight),
        child: const ZPlayListView(),
      ),
      boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.05))],
      maxHeight: Get.height - (controller.panelMobileMinSize + MediaQuery.of(context).padding.top + controller.panelAlbumPadding * 2),
      minHeight: 110.w + bottomHeight,
    );
  }

  Widget _buildSlide(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60.w, right: 60.w, bottom: 50.w),
      height: 100.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            addAutomaticKeepAlives: false,
            cacheExtent: 1.3,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            itemBuilder: (context, index) => Obx(() => Container(
                  margin: EdgeInsets.symmetric(vertical: controller.mEffects[index]['size'] / 2, horizontal: 5.w),
                  decoration: BoxDecoration(color: controller.bodyColor.value, borderRadius: BorderRadius.circular(4)),
                  width: 1.8,
                )),
            itemCount: controller.mEffects.length,
          ),
          Obx(() => ProgressBar(
                progress: controller.duration.value,
                buffered: controller.duration.value,
                total: controller.mediaItem.value.duration ?? const Duration(seconds: 10),
                progressBarColor: Colors.transparent,
                baseBarColor: Colors.transparent,
                bufferedBarColor: Colors.transparent,
                thumbColor: controller.bodyColor.value.withOpacity(.18),
                barHeight: 0.w,
                thumbRadius: 20.w,
                barCapShape: BarCapShape.square,
                timeLabelType: TimeLabelType.remainingTime,
                timeLabelLocation: TimeLabelLocation.none,
                timeLabelTextStyle: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                onSeek: (duration) {
                  controller.audioServeHandler.seek(duration);
                },
              ))
        ],
      ),
    );
  }

  // height:329.h-MediaQuery.of(context).padding.top,
  Widget _buildPlayController(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => controller.likeSong(),
              icon: Obx(() => Icon(controller.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.heartbeat : TablerIcons.heart,
                  size: 46.w, color: controller.bodyColor.value))),
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
                        height: 105.h,
                        width: 105.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.w),
                          border: Border.all(color: controller.bodyColor.value.withOpacity(.04), width: 5.w),
                          color: controller.bodyColor.value.withOpacity(0.06),
                        ),
                        child: Icon(
                          controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                          size: 54.w,
                          color: controller.bodyColor.value,
                        ),
                      )),
                  onTap: () => controller.playOrPause(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (controller.intervalClick(1)) {
                      controller.audioServeHandler.skipToNext();
                    }
                  },
                  icon: Obx(() => Icon(
                        TablerIcons.player_skip_forward,
                        size: 46.w,
                        color: controller.bodyColor.value,
                      ))),
            ],
          )),
          IconButton(
              onPressed: () {
                if (controller.fm.value) {
                  return;
                }
                controller.changeRepeatMode();
              },
              icon: Obx(() => Icon(
                    controller.getRepeatIcon(),
                    size: 43.w,
                    color: controller.bodyColor.value,
                  ))),
        ],
      ),
    ));
  }

  // Widget functionWidget({required Widget child}) {
  //   return Container(child: child);
  // }

  Widget _buildBottom(bottomHeight, context) {
    return SizedBox(
      height: 120.w + bottomHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(() => Container(
                width: 70.w,
                height: 8.w,
                margin: EdgeInsets.only(top: 12.w),
                decoration: BoxDecoration(color: controller.bodyColor.value.withOpacity(.3), borderRadius: BorderRadius.circular(4.w)),
              )),
          FlashyNavbar(
            height: 120.w,
            selectedIndex: 0,
            items: [
              FlashyNavbarItem(icon: const Icon(TablerIcons.atom_2)),
              FlashyNavbarItem(icon: const Icon(TablerIcons.playlist)),
              FlashyNavbarItem(icon: const Icon(TablerIcons.quote)),
              FlashyNavbarItem(icon: const Icon(TablerIcons.message_2)),
            ],
            onItemSelected: (index) {
              controller.selectIndex.value = index;
              if (!controller.panelController.isPanelOpen) controller.panelController.open();
            },
            backgroundColor: controller.bodyColor.value,
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              child: Container(
                height: MediaQuery.of(context).padding.bottom,
                width: Get.width,
                color: Colors.transparent,
              ),
              onVerticalDragEnd: (e) {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDefaultBody(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Stack(
        children: [
          Obx(() => Visibility(
                visible: controller.background.value.isEmpty,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
                  ),
                ),
              )),
          Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    !controller.panelOpenPositionThan1.value
                        ? Theme.of(context).scaffoldBackgroundColor.withOpacity(controller.background.value.isNotEmpty ? 0.2 : .85)
                        : !controller.gradientBackground.value
                            ? controller.rx.value.darkVibrantColor?.color.withOpacity(.85) ?? controller.rx.value.darkMutedColor?.color.withOpacity(.85) ?? Colors.transparent
                            : controller.rx.value.lightVibrantColor?.color.withOpacity(.85) ??
                                controller.rx.value.lightVibrantColor?.color.withOpacity(.85) ??
                                controller.rx.value.lightMutedColor?.color.withOpacity(.85) ??
                                Colors.transparent,
                    controller.rx.value.darkVibrantColor?.color.withOpacity(.85) ??
                        controller.rx.value.darkMutedColor?.color.withOpacity(.85) ??
                        controller.rx.value.lightVibrantColor?.color.withOpacity(.85) ??
                        Colors.transparent,
                  ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
                ),
              )),
          Obx(() => Visibility(
                visible: controller.background.value.isNotEmpty,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
                    child: BackdropFilter(

                        /// 过滤器
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),

                        /// 必须设置一个空容器
                        child: Container())),
              )),
          FadeTransition(
            opacity: controller.animationPanel,
            child: _buildBodyContent(context),
          )
        ],
      ),
    );
  }

  Widget _buildDefaultBody1(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Visibility(
            visible: controller.panelOpenPositionThan1.value,
            child: SimpleExtendedImage(
              controller.mediaItem.value.extras!['image'] + '?param=500y500',
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
            ),
          );
        }),

        // Container(
        //   color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
        // ),
        // ClipRRect(
        //   borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //   child: BackdropFilter(
        //     /// 过滤器
        //     filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        //
        //     /// 必须设置一个空容器
        //     child: _buildBodyContent(context),
        //   ),
        // ),
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
        //         duration: const Duration(milliseconds: 300),
        //         decoration: BoxDecoration(
        //           color: controller.rx.value.dominantColor?.color ?? Colors.transparent,
        //           borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //         ),
        //       ),
        //       visible: controller.gradientBackground.value,
        //       child: AnimatedContainer(
        //           duration: const Duration(milliseconds: 300),
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
        // ClipRRect(
        //   borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //   child: BackdropFilter(
        //     /// 过滤器
        //     filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        //
        //     /// 必须设置一个空容器
        //     child: _buildPanelContent(context, bottomHeight),
        //   ),
        // ),
        // BackdropFilter(
        //   /// 过滤器
        //   filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        //
        //   /// 必须设置一个空容器
        //   child: _buildPanelContent(context, bottomHeight),
        // ),
        // FrameSeparateWidget(child:  Obx(() {
        //   return Visibility(
        //     visible: !controller.leftImage.value,
        //     replacement: Container(
        //       color: Colors.transparent,
        //     ),
        //     child: AnimatedContainer(
        //       duration: const Duration(milliseconds: 300),
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(colors: [
        //           !controller.panelOpenPositionThan1.value && !controller.second.value
        //               ? Theme.of(context).bottomAppBarColor.withOpacity(controller.leftImage.value ? 0 : .7)
        //               : !controller.gradientBackground.value
        //               ? controller.rx.value.dominantColor?.color.withOpacity(.7) ?? Colors.transparent
        //               : controller.rx.value.lightVibrantColor?.color.withOpacity(.7) ??
        //               controller.rx.value.lightMutedColor?.color.withOpacity(.7) ??
        //               controller.rx.value.dominantColor?.color.withOpacity(.7) ??
        //               Colors.transparent,
        //           controller.rx.value.dominantColor?.color.withOpacity(.7) ?? Colors.transparent,
        //         ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        //         borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //       ),
        //     ),
        //   );
        // })),
        _buildPanelContent(context, bottomHeight),
      ],
    );
  }

  Widget _buildPanelContent(BuildContext context, bottomHeight) {
    return Container();
    // return Padding(
    //   padding: EdgeInsets.only(top: 120.w + bottomHeight),
    //   child: Obx(() => IndexedStack(
    //   index: controller.selectIndex.value,
    // children: controller.pages,
    // ),),
    // child: PageView.builder(
    //   itemBuilder: (context, index) => controller.pages[index],
    //   itemCount: controller.pages.length,
    //   controller: controller.pageController,
    //   physics: const NeverScrollableScrollPhysics(),
    //   // preloadPagesCount: controller.pages.length,
    //   onPageChanged: (index) {
    //     controller.selectIndex.value = index;
    //   },
    // ),
    // );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: controller.panelTopSize,
          width: Get.width - controller.panelAlbumPadding * 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    controller.panelControllerHome.close();
                  },
                  icon: Obx(() => Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: controller.bodyColor.value,
                      ))),
              Expanded(
                  child: Obx(
                () => RichText(
                  text: TextSpan(
                      text: '${Home.to.mediaItem.value.title} - ',
                      children: [TextSpan(text: Home.to.mediaItem.value.artist ?? '', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500))],
                      style: TextStyle(fontSize: 32.sp, color: controller.bodyColor.value, fontWeight: FontWeight.w500)),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
              IconButton(
                  onPressed: () {},
                  icon: Obx(() => Icon(
                        Icons.more_horiz,
                        color: controller.bodyColor.value,
                      ))),
            ],
          ),
        ),
        SizedBox(
          height: 640.w,
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 55.w),
        //   height: 110.w,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Obx(() => Text(
        //             controller.mediaItem.value.title.fixAutoLines(),
        //             style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.bold, color: controller.bodyColor.value),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           )),
        //       Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
        //       Obx(() => Text(
        //             (controller.mediaItem.value.artist ?? '').fixAutoLines(),
        //             style: TextStyle(fontSize: 28.sp, color: controller.bodyColor.value),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           ))
        //     ],
        //   ),
        // ),
        // //操控区域
        _buildPlayController(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    OtherUtils.getTimeStamp(controller.duration.value.inMilliseconds),
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                  )),
              Obx(() => (controller.mediaItem.value.extras?['cache'] ?? false)
                  ? Icon(
                      TablerIcons.circle_check,
                      color: controller.bodyColor.value.withOpacity(.6),
                      size: 30.sp,
                    )
                  : const SizedBox.shrink()),
              Obx(() => Text(
                    OtherUtils.getTimeStamp(controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                  )),
            ],
          ),
        ),
        //进度条
        _buildSlide(context),
        // 功能按钮
        SizedBox(
          height: 130.w + MediaQuery.of(context).padding.bottom,
        ),
      ],
    );
  }



}

class PanelViewL extends GetView<Home> {
  const PanelViewL({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    return _buildDefaultBody(context);
  }

  Widget _buildSlide(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: controller.panelAlbumPadding*4),
      height: 50.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            addAutomaticKeepAlives: false,
            cacheExtent: 1.3,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            itemBuilder: (context, index) => Obx(() => Container(
                  margin: EdgeInsets.symmetric(vertical: controller.mEffects[index]['size'] / 2, horizontal: 5.w),
                  decoration: BoxDecoration(color: controller.bodyColor.value, borderRadius: BorderRadius.circular(4)),
                  width: 1.8,
                )),
            itemCount: controller.mEffects.length,
          ),
          Obx(() => ProgressBar(
                progress: controller.duration.value,
                buffered: controller.duration.value,
                total: controller.mediaItem.value.duration ?? const Duration(seconds: 10),
                progressBarColor: Colors.transparent,
                baseBarColor: Colors.transparent,
                bufferedBarColor: Colors.transparent,
                thumbColor: controller.bodyColor.value.withOpacity(.18),
                barHeight: 0.w,
                thumbRadius: 20.w,
                barCapShape: BarCapShape.square,
                timeLabelType: TimeLabelType.remainingTime,
                timeLabelLocation: TimeLabelLocation.none,
                timeLabelTextStyle: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                onSeek: (duration) {
                  controller.audioServeHandler.seek(duration);
                },
              ))
        ],
      ),
    );
  }

  Widget _buildPlayController(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: controller.panelAlbumPadding*4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => controller.likeSong(),
              icon: Obx(() => Icon(controller.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.heartbeat : TablerIcons.heart,
                  size: 46.w, color: controller.bodyColor.value))),
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
                        height: 105.h,
                        width: 105.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.w),
                          border: Border.all(color: controller.bodyColor.value.withOpacity(.04), width: 5.w),
                          color: controller.bodyColor.value.withOpacity(0.06),
                        ),
                        child: Icon(
                          controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                          size: 54.w,
                          color: controller.bodyColor.value,
                        ),
                      )),
                  onTap: () => controller.playOrPause(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (controller.intervalClick(1)) {
                      controller.audioServeHandler.skipToNext();
                    }
                  },
                  icon: Obx(() => Icon(
                        TablerIcons.player_skip_forward,
                        size: 46.w,
                        color: controller.bodyColor.value,
                      ))),
            ],
          )),
          IconButton(
              onPressed: () {
                if (controller.fm.value) {
                  return;
                }
                controller.changeRepeatMode();
              },
              icon: Obx(() => Icon(
                    controller.getRepeatIcon(),
                    size: 43.w,
                    color: controller.bodyColor.value,
                  ))),
        ],
      ),
    ));
  }

  // Widget functionWidget({required Widget child}) {
  //   return Container(child: child);
  // }

  Widget _buildBottom(bottomHeight, context) {
    return SizedBox(
      height: 120.w + bottomHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(() => Container(
                width: 70.w,
                height: 8.w,
                margin: EdgeInsets.only(top: 12.w),
                decoration: BoxDecoration(color: controller.bodyColor.value.withOpacity(.3), borderRadius: BorderRadius.circular(4.w)),
              )),
          FlashyNavbar(
            height: 120.w,
            selectedIndex: 0,
            items: [
              FlashyNavbarItem(icon: const Icon(TablerIcons.atom_2)),
              FlashyNavbarItem(icon: const Icon(TablerIcons.playlist)),
              FlashyNavbarItem(icon: const Icon(TablerIcons.quote)),
              FlashyNavbarItem(icon: const Icon(TablerIcons.message_2)),
            ],
            onItemSelected: (index) {
              controller.selectIndex.value = index;
              if (!controller.panelController.isPanelOpen) controller.panelController.open();
            },
            backgroundColor: controller.bodyColor.value,
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              child: Container(
                height: MediaQuery.of(context).padding.bottom,
                width: Get.width,
                color: Colors.transparent,
              ),
              onVerticalDragEnd: (e) {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDefaultBody(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Stack(
        children: [
          // Obx(() => Visibility(
          //       visible: controller.background.value.isEmpty,
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Theme.of(context).scaffoldBackgroundColor,
          //           // borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
          //         ),
          //       ),
          //     )),
          Obx(() => Visibility(visible: controller.panelOpenPositionThan1.value,child: SimpleExtendedImage(
            Home.to.mediaItem.value.extras?['image'] ?? '',
            fit: BoxFit.cover,
            width: Get.width,
            height: Get.height,
          ),)),
          Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    !controller.panelOpenPositionThan1.value
                        ? Theme.of(context).scaffoldBackgroundColor.withOpacity(.25)
                        : !controller.gradientBackground.value
                            ? controller.rx.value.darkVibrantColor?.color.withOpacity(.6) ?? controller.rx.value.darkMutedColor?.color.withOpacity(.6) ?? Colors.transparent
                            : controller.rx.value.lightVibrantColor?.color.withOpacity(.6) ??
                                controller.rx.value.lightVibrantColor?.color.withOpacity(.6) ??
                                controller.rx.value.lightMutedColor?.color.withOpacity(.6) ??
                                Colors.transparent,
                    !controller.panelOpenPositionThan1.value
                        ? Theme.of(context).scaffoldBackgroundColor.withOpacity(.6)
                        :controller.rx.value.darkVibrantColor?.color.withOpacity(.6) ??
                        controller.rx.value.darkMutedColor?.color.withOpacity(.6) ??
                        controller.rx.value.lightVibrantColor?.color.withOpacity(.6) ??
                        Colors.transparent,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
                ),
              )),
          Obx(() => Visibility(
                visible: !controller.background.value.isNotEmpty,
                child: ClipRRect(
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
                    child: BackdropFilter(

                        /// 过滤器
                        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),

                        /// 必须设置一个空容器
                        child: Container(
                        ))),
              )),
          FadeTransition(
            opacity: controller.animationPanel,
            child: Row(
              children: [
                Expanded(
                    child:Column(
                      children: [
                        SizedBox(height: 750.w + controller.panelMobileMinSize),
                        _buildPlayController(context),
                        _buildSlide(context),
                        Padding(padding: EdgeInsets.symmetric(vertical: controller.panelMobileMinSize/2))
                      ],
                    )),
                 Expanded( child: Padding(padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 40.w),child: const LyricView(),))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDefaultBody1(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Visibility(
            visible: controller.panelOpenPositionThan1.value,
            child: SimpleExtendedImage(
              controller.mediaItem.value.extras!['image'] + '?param=500y500',
              fit: BoxFit.cover,
              height: Get.height,
              width: Get.width,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
            ),
          );
        }),

        // Container(
        //   color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.2),
        // ),
        // ClipRRect(
        //   borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //   child: BackdropFilter(
        //     /// 过滤器
        //     filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        //
        //     /// 必须设置一个空容器
        //     child: _buildBodyContent(context),
        //   ),
        // ),
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
        //         duration: const Duration(milliseconds: 300),
        //         decoration: BoxDecoration(
        //           color: controller.rx.value.dominantColor?.color ?? Colors.transparent,
        //           borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //         ),
        //       ),
        //       visible: controller.gradientBackground.value,
        //       child: AnimatedContainer(
        //           duration: const Duration(milliseconds: 300),
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
        // ClipRRect(
        //   borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //   child: BackdropFilter(
        //     /// 过滤器
        //     filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        //
        //     /// 必须设置一个空容器
        //     child: _buildPanelContent(context, bottomHeight),
        //   ),
        // ),
        // BackdropFilter(
        //   /// 过滤器
        //   filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        //
        //   /// 必须设置一个空容器
        //   child: _buildPanelContent(context, bottomHeight),
        // ),
        // FrameSeparateWidget(child:  Obx(() {
        //   return Visibility(
        //     visible: !controller.leftImage.value,
        //     replacement: Container(
        //       color: Colors.transparent,
        //     ),
        //     child: AnimatedContainer(
        //       duration: const Duration(milliseconds: 300),
        //       decoration: BoxDecoration(
        //         gradient: LinearGradient(colors: [
        //           !controller.panelOpenPositionThan1.value && !controller.second.value
        //               ? Theme.of(context).bottomAppBarColor.withOpacity(controller.leftImage.value ? 0 : .7)
        //               : !controller.gradientBackground.value
        //               ? controller.rx.value.dominantColor?.color.withOpacity(.7) ?? Colors.transparent
        //               : controller.rx.value.lightVibrantColor?.color.withOpacity(.7) ??
        //               controller.rx.value.lightMutedColor?.color.withOpacity(.7) ??
        //               controller.rx.value.dominantColor?.color.withOpacity(.7) ??
        //               Colors.transparent,
        //           controller.rx.value.dominantColor?.color.withOpacity(.7) ?? Colors.transparent,
        //         ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
        //         borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
        //       ),
        //     ),
        //   );
        // })),
        _buildPanelContent(context, bottomHeight),
      ],
    );
  }

  Widget _buildPanelContent(BuildContext context, bottomHeight) {
    return Container();
    // return Padding(
    //   padding: EdgeInsets.only(top: 120.w + bottomHeight),
    //   child: Obx(() => IndexedStack(
    //   index: controller.selectIndex.value,
    // children: controller.pages,
    // ),),
    // child: PageView.builder(
    //   itemBuilder: (context, index) => controller.pages[index],
    //   itemCount: controller.pages.length,
    //   controller: controller.pageController,
    //   physics: const NeverScrollableScrollPhysics(),
    //   // preloadPagesCount: controller.pages.length,
    //   onPageChanged: (index) {
    //     controller.selectIndex.value = index;
    //   },
    // ),
    // );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: controller.panelTopSize,
          width: Get.width - controller.panelAlbumPadding * 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    controller.panelControllerHome.close();
                  },
                  icon: Obx(() => Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: controller.bodyColor.value,
                      ))),
              Expanded(
                  child: Obx(
                () => RichText(
                  text: TextSpan(
                      text: '${Home.to.mediaItem.value.title} - ',
                      children: [TextSpan(text: Home.to.mediaItem.value.artist ?? '', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500))],
                      style: TextStyle(fontSize: 32.sp, color: controller.bodyColor.value, fontWeight: FontWeight.w500)),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
              IconButton(
                  onPressed: () {},
                  icon: Obx(() => Icon(
                        Icons.more_horiz,
                        color: controller.bodyColor.value,
                      ))),
            ],
          ),
        ),
        SizedBox(
          height: 640.w,
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 55.w),
        //   height: 110.w,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Obx(() => Text(
        //             controller.mediaItem.value.title.fixAutoLines(),
        //             style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.bold, color: controller.bodyColor.value),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           )),
        //       Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
        //       Obx(() => Text(
        //             (controller.mediaItem.value.artist ?? '').fixAutoLines(),
        //             style: TextStyle(fontSize: 28.sp, color: controller.bodyColor.value),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           ))
        //     ],
        //   ),
        // ),
        // //操控区域
        _buildPlayController(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    OtherUtils.getTimeStamp(controller.duration.value.inMilliseconds),
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                  )),
              Obx(() => (controller.mediaItem.value.extras?['cache'] ?? false)
                  ? Icon(
                      TablerIcons.circle_check,
                      color: controller.bodyColor.value.withOpacity(.6),
                      size: 30.sp,
                    )
                  : const SizedBox.shrink()),
              Obx(() => Text(
                    OtherUtils.getTimeStamp(controller.mediaItem.value.duration?.inMilliseconds ?? 0),
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                  )),
            ],
          ),
        ),
        //进度条
        _buildSlide(context),
        // 功能按钮
        SizedBox(
          height: 130.w + MediaQuery.of(context).padding.bottom,
        ),
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

// class ClassWidget extends StatelessWidget {
//   final Widget child;
//
//   const ClassWidget({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     return FrameSeparateWidget(child: child);
//   }
// }

class ClassStatelessWidget extends StatelessWidget {
  final Widget child;

  const ClassStatelessWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
