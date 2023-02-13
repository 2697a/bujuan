import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/pages/home/view/z_lyric_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/mobile/flashy_navbar.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keframe/keframe.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../common/constants/other.dart';
import '../../../common/constants/platform_utils.dart';
import '../../../routes/router.gr.dart';

class PanelViewL extends GetView<Home> {
  const PanelViewL({Key? key}) : super(key: key);

  //进度

  @override
  Widget build(BuildContext context) {
    double bottomHeight = MediaQuery.of(context).padding.bottom * (PlatformUtils.isIOS ? 0.4 : 0.8);
    if (bottomHeight == 0) bottomHeight = 20.w;
    return WillPopScope(
        child: GestureDetector(
          child: _buildDefaultBody(context),
          onHorizontalDragDown: (e) {
            return;
          },
        ),
        onWillPop: () => controller.onWillPop());
  }

  Widget _buildSlide(BuildContext context) {
    return Container(
      width: Get.width - 80.w * 7,
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
                  margin: EdgeInsets.symmetric(vertical: controller.mEffects[index]['size'] / 1.5, horizontal: 3.w),
                  decoration: BoxDecoration(color: controller.bodyColor.value, borderRadius: BorderRadius.circular(4)),
                  width: 1.8,
                )),
            itemCount: controller.mEffects.length,
          )),
          Obx(() => ProgressBar(
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
              ))
        ],
      ),
    );
  }

  // height:329.h-MediaQuery.of(context).padding.top,
  Widget _buildPlayController(BuildContext context) {
    return FrameSeparateWidget(
        child: Container(
          width: Get.width - 80.w * 7,
          padding: EdgeInsets.only(left: 40.w, right: 40.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => IconButton(
                  onPressed: () => controller.likeSong(),
                  icon: Icon(controller.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.hearts : TablerIcons.heart,
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
        ));
  }

  // Widget functionWidget({required Widget child}) {
  //   return Container(child: child);
  // }

  Widget _buildBottom(bottomHeight, context) {
    return SizedBox(
      width: Get.width - 80.w * 7,
      child: Stack(
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
      ),
    );
  }

  Widget _buildDefaultBody(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return Visibility(
            visible: !controller.leftImage.value,
            replacement: Container(
              color: Colors.transparent,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  !controller.panelOpenPositionThan1.value && !controller.second.value
                      ? Theme.of(context).bottomAppBarColor.withOpacity(controller.leftImage.value ? 0 : .6)
                      : !controller.gradientBackground.value
                          ? controller.rx.value.dominantColor?.color.withOpacity(.6) ?? Colors.transparent
                          : controller.rx.value.lightVibrantColor?.color.withOpacity(.6) ??
                              controller.rx.value.lightMutedColor?.color.withOpacity(.6) ??
                              controller.rx.value.dominantColor?.color.withOpacity(.6) ??
                              Colors.transparent,
                  controller.rx.value.dominantColor?.color.withOpacity(.5) ?? Colors.transparent,
                ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
              ),
            ),
          );
        }),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
          child: BackdropFilter(
            /// 过滤器
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),

            /// 必须设置一个空容器
            child: Container(),
          ),
        ),
        Obx(() => Offstage(offstage: !controller.panelOpenPositionThan1.value,child: _buildBodyContent(context),))
      ],
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
    return Container(
      width: Get.width - 80.w * 7,
      padding: EdgeInsets.only(top: 110.h + bottomHeight),
      // child: PreloadPageView.builder(
      //   itemBuilder: (context, index) => controller.pages[index],
      //   itemCount: controller.pages.length,
      //   controller: controller.pageController,
      //   physics: const NeverScrollableScrollPhysics(),
      //   preloadPagesCount: controller.pages.length,
      //   onPageChanged: (index) {
      //     controller.selectIndex.value = index;
      //   },
      // ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Row(
      children: [
        Container(
          width:  80.w * 7,
        ),
        Expanded(child: Column(
          children: [
            // 歌曲信息
            Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top)),
            // ClassWidget(
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 55.w),
            //       height: 110.h,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Obx(() => Text(
            //             controller.mediaItem.value.title.fixAutoLines(),
            //             style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold, color: controller.bodyColor.value),
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //           )),
            //           Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
            //           Obx(() => Text(
            //             (controller.mediaItem.value.artist ?? '').fixAutoLines(),
            //             style: TextStyle(fontSize: 28.sp, color: controller.bodyColor.value),
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //           ))
            //         ],
            //       ),
            //     )),
            // //操控区域
            // _buildPlayController(context),
            const Expanded(child: LyricView()),
            // //进度条
            _buildPlayController(context),

            Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.bottom)),
            _buildSlide(context),
            //功能按钮
            // ClassWidget(
            //     child: SizedBox(
            //   height: MediaQuery.of(context).padding.bottom,
            // )),
          ],
        ),)
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
