import 'dart:ui';

import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/body_view.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/widget/swipeable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../widget/simple_extended_image.dart';
import '../../../widget/weslide/panel.dart';
import 'menu_view.dart';

class HomeView extends GetView<Home> {
  final Widget? body;

  const HomeView({
    Key? key,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.6 : .85);
    if (bottomHeight == 0 && PlatformUtils.isAndroid || PlatformUtils.isIOS) bottomHeight = 32.w;
    return Material(
        child: Home.to.landscape
            ? Stack(
                children: [
                  Obx(() => SimpleExtendedImage(
                        Home.to.mediaItem.value.extras?['image'] ?? '',
                        fit: BoxFit.cover,
                        width: Get.width,
                        height: Get.height,
                      )),
                  Container(
                    width: Get.width,
                    height: Get.height,
                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.7),
                  ),
                  Obx(() => AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            controller.rx.value.lightVibrantColor?.color.withOpacity(.4) ??
                                controller.rx.value.lightVibrantColor?.color.withOpacity(.4) ??
                                controller.rx.value.lightMutedColor?.color.withOpacity(.4) ??
                                Colors.transparent,
                            controller.rx.value.darkVibrantColor?.color.withOpacity(.4) ??
                                controller.rx.value.darkMutedColor?.color.withOpacity(.4) ??
                                controller.rx.value.lightVibrantColor?.color.withOpacity(.4) ??
                                Colors.transparent,
                          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          // borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
                        ),
                      )),
                  BackdropFilter(filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), child: Container()),
                  Row(
                    children: [
                      const MenuViewL(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: controller.landscape ? controller.panelAlbumPadding * 2 : 0),
                          child: const SafeArea(child: BodyView()),
                        ),
                      ),
                      SizedBox(
                        width: 750.w,
                        child: const TestView(),
                      ),
                    ],
                  )
                ],
              )
            : ZoomDrawer(
                moveMenuScreen: false,
                menuScreen: const MenuView(),
                mainScreen: SlidingUpPanel(
                  color: Colors.transparent,
                  parallaxEnabled: true,
                  parallaxOffset: .03,
                  controller: controller.panelControllerHome,
                  onPanelSlide: (value) => controller.changeSlidePosition(value),
                  boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.05))],
                  panel: const PanelView(),
                  body: const BodyView(),
                  minHeight: controller.panelMobileMinSize + bottomHeight + controller.panelAlbumPadding * 2,
                  maxHeight: Get.height,
                  header: _buildHeader(context, bottomHeight),
                ),
                dragOffset: 260.w,
                // angle: -11,
                menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.1),
                slideWidth: Get.width * .6,
                menuScreenWidth: Get.width * .6,
                mainScreenScale: 0.2,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                showShadow: true,
                mainScreenTapClose: true,
                menuScreenTapClose: true,
                androidCloseOnBackTap: true,
                drawerShadowsBackgroundColor: const Color(0xFFBEBBBB),
                controller: controller.myDrawerController,
              ));
  }

  Widget _buildHeader(context, bottomHeight) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top * controller.slideSecondPosition.value),
              child: child,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: controller.panelAlbumPadding),
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: controller.panelTopSize*controller.animationController.value,
              width: 750.w ,
              child:  Obx(() => Visibility(
                visible: !controller.second.value&&controller.panelOpenPositionThan1.value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => controller.panelControllerHome.close(),
                      icon: Obx(() => Icon(Icons.keyboard_arrow_down_sharp, color: controller.bodyColor.value)),
                    ),
                     Text('Now Playing',style: TextStyle(color: controller.bodyColor.value,fontSize: 28.sp),),
                    IconButton(onPressed: () {}, icon: Obx(() => Icon(Icons.more_horiz, color: controller.bodyColor.value))),
                  ],
                ),
              )),
            ),
          ],
        );
      },
      child: Obx(() => GestureDetector(
        onVerticalDragEnd: (controller.second.value) ? (e) {} : null,
        child: Swipeable(
            background: const SizedBox.shrink(),
            child: InkWell(
              child: Container(
                width: 750.w,
                padding: EdgeInsets.all(controller.panelAlbumPadding),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    _buildMediaTitle(context),
                    _buildAlbum(),
                  ],
                ),
              ),
              onTap: () {
                if (controller.panelControllerHome.isPanelClosed) {
                  controller.panelControllerHome.open();
                } else {
                  if (controller.panelController.isPanelOpen) controller.panelController.close();
                }
              },
            ),
            onSwipeLeft: () => controller.audioServeHandler.skipToPrevious(),
            onSwipeRight: () => controller.audioServeHandler.skipToNext()),
      )),
    );
  }

  //构建歌曲标题和播放按钮
  Widget _buildMediaTitle(context) {
    return Obx(() => Visibility(
          visible: !controller.panelOpenPositionThan1.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: controller.panelMobileMinSize + controller.panelAlbumPadding),
                      alignment: Alignment.centerLeft,
                      height: controller.panelMobileMinSize,
                      child: Obx(
                        () => RichText(
                          text: TextSpan(
                              text: '${Home.to.mediaItem.value.title} - ',
                              children: [TextSpan(text: Home.to.mediaItem.value.artist ?? '', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500))],
                              style: TextStyle(
                                  fontSize: 32.sp,
                                  color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                                  fontWeight: FontWeight.w500)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))),
              IconButton(
                  onPressed: () => controller.playOrPause(),
                  icon: Obx(() => Icon(
                        controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                        color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                        size: 44.sp,
                      ))),
            ],
          ),
        ));
  }

  //构建歌曲专辑
  Widget _buildAlbum() {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              left: (750.w - 630.w - controller.panelAlbumPadding * 2) / 2 * controller.animationController.value,
              top: (controller.panelTopSize + MediaQuery.of(context).padding.top - controller.panelAlbumPadding) * controller.animationController.value),
          width: controller.panelMobileMinSize + 550.w * controller.animationController.value,
          height: controller.panelMobileMinSize + 550.w * controller.animationController.value,
          child: index,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(controller.panelMobileMinSize / 2),
        child: Obx(() => SimpleExtendedImage(
              '${Home.to.mediaItem.value.extras?['image'] ?? ''}?param=500y500',
              width: 630.w,
              height: 630.w,
            )),
      ),
    );
  }

  Widget _buildHeaderL(context, bottomHeight) {
    // return Obx(() => IgnorePointer(
    //       ignoring: controller.panelOpenPositionThan8.value,
    //       child: AnimatedBuilder(
    //         animation: controller.animationController,
    //         builder: (context, child) {
    //           return Container(
    //             height: controller.panelMobileMinSize +
    //                 controller.panelAlbumPadding * 2 +
    //                 (Get.width/8*3*.86 - controller.panelMobileMinSize + controller.panelAlbumPadding * 2) * controller.animationController.value,
    //             alignment: Alignment.centerLeft,
    //             child: child,
    //           );
    //         },
    //         child: InkWell(
    //           child: Container(
    //             width: Get.width,
    //             padding: EdgeInsets.symmetric(horizontal: controller.panelAlbumPadding),
    //             child: Stack(
    //               alignment: Alignment.centerLeft,
    //               children: [
    //                 _buildMediaTitleL(context),
    //                 _buildAlbumL(),
    //               ],
    //             ),
    //           ),
    //           onTap: () {
    //             controller.panelControllerHome.open();
    //           },
    //         ),
    //       ),
    //     ));
    return Obx(() => IgnorePointer(
          ignoring: controller.panelOpenPositionThan8.value,
          child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Container(
                height: controller.panelMobileMinSize +
                    controller.panelAlbumPadding * 2 +
                    (Get.width / 8 * 3 * .86 - controller.panelMobileMinSize + controller.panelAlbumPadding * 2) * controller.animationController.value,
                alignment: Alignment.centerLeft,
                child: child,
              );
            },
            child: InkWell(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: controller.panelAlbumPadding),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    _buildMediaTitleL(context),
                    _buildAlbumL(),
                  ],
                ),
              ),
              onTap: () {
                controller.panelControllerHome.open();
              },
            ),
          ),
        ));
  }

  //构建歌曲标题和播放按钮
  Widget _buildMediaTitleL(context) {
    return Obx(() => Visibility(
          visible: !controller.panelOpenPositionThan1.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: controller.panelMobileMinSize + controller.panelAlbumPadding),
                      alignment: Alignment.centerLeft,
                      height: controller.panelMobileMinSize,
                      child: Obx(
                        () => RichText(
                          textScaleFactor: 1.0,
                          text: TextSpan(
                              text: '${Home.to.mediaItem.value.title} - ',
                              children: [TextSpan(text: Home.to.mediaItem.value.artist ?? '', style: const TextStyle(fontWeight: FontWeight.w500))],
                              style: TextStyle(color: Home.to.second.value ? Home.to.bodyColor.value : Home.to.getLightTextColor(context), fontWeight: FontWeight.bold)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))),
              IconButton(
                  onPressed: () => controller.audioServeHandler.skipToPrevious(),
                  icon: const Icon(
                    Icons.skip_previous,
                  )),
              IconButton(
                  onPressed: () => controller.playOrPause(),
                  icon: Obx(() => Icon(
                        controller.playing.value ? Icons.pause : Icons.play_arrow,
                      ))),
              IconButton(
                  onPressed: () => controller.audioServeHandler.skipToNext(),
                  icon: const Icon(
                    Icons.skip_next_rounded,
                  ))
            ],
          ),
        ));
  }

  //构建歌曲专辑
  Widget _buildAlbumL() {
    double albumWidth = Get.width / 8 * 3 * .86;
    double leftWidth = Get.width / 8 * 3;
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              left: (leftWidth - albumWidth - controller.panelAlbumPadding * 2) / 2 * controller.animationController.value,
              top: controller.panelMobileMinSize * controller.animationController.value),
          width: controller.panelMobileMinSize + (albumWidth - controller.panelMobileMinSize) * controller.animationController.value,
          height: controller.panelMobileMinSize + (albumWidth - controller.panelMobileMinSize) * controller.animationController.value,
          child: index,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(controller.panelMobileMinSize / 2),
        child: Obx(() => SimpleExtendedImage(
              '${Home.to.mediaItem.value.extras?['image'] ?? ''}?param=800y800',
              width: albumWidth,
              height: albumWidth,
            )),
      ),
    );
  }
}

class LeftMenu {
  String title;
  IconData icon;
  String path;
  String pathUrl;

  LeftMenu(this.title, this.icon, this.path, this.pathUrl);
}
