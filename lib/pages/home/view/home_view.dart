import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/body_view.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    if (bottomHeight == 0) bottomHeight = 32.w;
    return Material(
        child: Home.to.landscape
            ? SlidingUpPanel(
                color: Colors.transparent,
                controller: controller.panelControllerHome,
                onPanelSlide: (value) => controller.changeSlidePosition(value),
                boxShadow: const [BoxShadow(blurRadius: 0, color: Colors.transparent)],
                panel: const PanelViewL(),
                body: Row(
                  children: [
                    const MenuViewL(),
                    Expanded(
                        child: Column(
                      children: [
                        SafeArea(
                            child: Container(
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.2), width: .6.w))),
                          height: 85.h,
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 40.w)),
                              RichText(
                                  text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
                                TextSpan(text: 'BuJuan～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
                              ])),
                            ],
                          ),
                        )),
                        const Expanded(child: BodyView())
                      ],
                    )),
                  ],
                ),
                minHeight: controller.panelMobileMinSize + controller.panelAlbumPadding * 2,
                maxHeight: Get.height,
                header: _buildHeaderL(context, 0),
              )
            : ZoomDrawer(
                moveMenuScreen: false,
                menuScreen: const MenuView(),
                mainScreen: SlidingUpPanel(
                  color: Colors.transparent,
                  controller: controller.panelControllerHome,
                  onPanelSlide: (value) => controller.changeSlidePosition(value),
                  boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.05))],
                  panel: const PanelView(),
                  body: const BodyView(),
                  minHeight: controller.panelMobileMinSize + bottomHeight + controller.panelAlbumPadding * 2,
                  maxHeight: Get.height,
                  header: _buildHeader(context, bottomHeight),
                ),
                dragOffset: 360.w,
                angle: 0,
                menuBackgroundColor: Theme.of(context).cardColor,
                slideWidth: Get.width * .24,
                mainScreenScale: 0,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                showShadow: true,
                mainScreenTapClose: true,
                menuScreenTapClose: true,
                drawerShadowsBackgroundColor: Colors.grey,
                controller: controller.myDrawerController,
              ));
  }

  Widget _buildHeader(context, bottomHeight) {
    return Obx(() => IgnorePointer(
          ignoring: controller.panelOpenPositionThan8.value || controller.second.value,
          child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top * controller.slideSecondPosition.value),
                child: child,
              );
            },
            child: InkWell(
              child: Container(
                width: Get.width,
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
                controller.panelControllerHome.open();
              },
            ),
          ),
        ));
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
                                  fontSize: 32.sp, color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context), fontWeight: FontWeight.w500)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))),
              IconButton(
                  onPressed: () => controller.playOrPause(),
                  icon: Obx(() => Icon(
                        controller.playing.value ? Icons.pause : Icons.play_arrow,
                    color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                      )))
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
              left: (Get.width - 680.w) / 2 * controller.animationController.value,
              top: (controller.panelTopSize + MediaQuery.of(context).padding.top - controller.panelAlbumPadding) * controller.animationController.value),
          width: controller.panelMobileMinSize + 560.w * controller.animationController.value,
          height: controller.panelMobileMinSize + 560.w * controller.animationController.value,
          child: index,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(controller.panelMobileMinSize / 2),
        child: Obx(() => SimpleExtendedImage(
              '${Home.to.mediaItem.value.extras?['image'] ?? ''}?param=500y500',
              width: 640.w,
              height: 640.w,
            )),
      ),
    );
  }

  Widget _buildHeaderL(context, bottomHeight) {
    return Obx(() => IgnorePointer(
          ignoring: controller.panelOpenPositionThan8.value,
          child: AnimatedBuilder(
            animation: controller.animationController,
            builder: (context, child) {
              return Container(
                height: controller.panelMobileMinSize +
                    controller.panelAlbumPadding * 2 +
                    (750.w - controller.panelMobileMinSize + controller.panelAlbumPadding * 2) * controller.animationController.value,
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
    double albumWidth = 750.w;
    double leftWidth = Get.width / 2;
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
