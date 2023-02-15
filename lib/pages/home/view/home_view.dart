
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/body_view.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/pages/home/view/panel_view_l.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/slider_drawer/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:keframe/keframe.dart';

import '../../../widget/swipeable.dart';
import '../../../widget/weslide/panel.dart';
import '../../../widget/weslide/panel_play_view.dart';
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
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: OrientationBuilder(
          builder: (c, o) => Visibility(
                visible: o == Orientation.portrait,
                replacement: ZoomDrawer(
                  moveMenuScreen: false,
                  menuScreen: const MenuView(),
                  mainScreen: SlidingUpPanel(
                    color: Colors.transparent,
                    // controller: controller.panelControllerHome,
                    renderPanelSheet: false,
                    // onPanelSlide: (value) => controller.changeSlidePosition(value),
                    parallaxEnabled: true,
                    parallaxOffset: .05,
                    boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.15))],
                    panel: const FrameSeparateWidget(child: PanelViewL()),
                    body: const ClassStatelessWidget(child: BodyView()),
                    header: ClassStatelessWidget(child: _buildPanelHeaderL(bottomHeight / 2, context)),
                    minHeight: controller.panelMobileMinSize + bottomHeight,
                    maxHeight: Get.height,
                  ),
                  dragOffset: 500.w,
                  angle: -0,
                  menuBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  slideWidth: Get.width * .28,
                  mainScreenScale: .1,
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  showShadow: true,
                  mainScreenTapClose: true,
                  menuScreenTapClose: true,
                  drawerShadowsBackgroundColor: Colors.grey,
                ),
                child: ZoomDrawer(
                  moveMenuScreen: false,
                  menuScreen: const MenuView(),
                  mainScreen: SlidingUpPlayViewPanel(
                    color: Colors.transparent,
                    controller: controller.panelControllerHome,
                    onPanelSlide: (value) => controller.changeSlidePosition(value),
                    boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.05))],
                    panel: const PanelView(),
                    body: const BodyView(),
                    minHeight: controller.panelMobileMinSize + bottomHeight,
                    maxHeight: Get.height,
                  ),
                  dragOffset: 360.w,
                  angle: 0,
                  menuBackgroundColor: controller.leftImageNoObs?Theme.of(context).colorScheme.onSecondary:Theme.of(context).cardColor,
                  slideWidth: Get.width * .28,
                  mainScreenScale: 0,
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  showShadow: true,
                  mainScreenTapClose: true,
                  menuScreenTapClose: true,
                  drawerShadowsBackgroundColor: Colors.grey,
                  controller: controller.myDrawerController,
                ),
              )),
    );
  }

  Widget _buildPanelHeader(bottomHeight, context) {
    print('========_buildPanelHeader');
    return IgnorePointer(
      ignoring: controller.panelOpenPositionThan1.value && !controller.second.value,
      child: Visibility(
        replacement: GestureDetector(
          child: _buildPanelHeaderTo(bottomHeight, context),
          onHorizontalDragDown: (e) {},
          onTap: () {
            if (!controller.panelControllerHome.isPanelOpen) {
              controller.panelControllerHome.open();
            } else {
              if (controller.panelController.isPanelOpen) controller.panelController.close();
            }
          },
        ),
        visible: controller.panelOpenPositionThan8.value,
        child: GestureDetector(
          child: _buildPanelHeaderTo(bottomHeight, context),
          onHorizontalDragDown: (e) {},
          onVerticalDragDown: (e) {},
          onTap: () {
            if (!controller.panelControllerHome.isPanelOpen) {
              controller.panelControllerHome.open();
            } else {
              if (controller.panelController.isPanelOpen) controller.panelController.close();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPanelHeaderTo(bottomHeight, context) {
    return Stack(
      children: [
        Swipeable(
          onSwipeRight: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              controller.audioServeHandler.skipToPrevious();
            });
          },
          onSwipeLeft: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              controller.audioServeHandler.skipToNext();
            });
          },
          threshold: 120.w,
          background: const SizedBox.shrink(),
          child: Obx(() => Container(
                color: Colors.transparent,
                padding: controller.getHeaderPadding(context).copyWith(bottom: bottomHeight),
                width: Get.width,
                height: controller.getPanelMinSize() + controller.getHeaderPadding(context).top + bottomHeight,
                child: _buildPlayBar(context),
              )),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            child: Obx(() {
              print('底部高度');
              return Container(
                color: Colors.transparent,
                height: bottomHeight * (controller.panelOpenPositionThan1.value ? 0 : 1),
                width: Get.width,
              );
            }),
            onVerticalDragDown: (e) {},
          ),
        )
      ],
    );
  }

  Widget _buildPlayBar(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: controller.panelHeaderSize),
              child: Obx(
                () => RichText(
                  text: !controller.panelOpenPositionThan1.value || controller.second.value
                      ? TextSpan(
                          text: '${controller.mediaItem.value.title} - ',
                          children: [
                            TextSpan(
                              text: controller.mediaItem.value.artist ?? '',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                          style: TextStyle(
                              fontSize: 28.sp, color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context), fontWeight: FontWeight.w500))
                      : const TextSpan(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
            FrameSeparateWidget(
                child: Obx(() => Visibility(
                      visible: !controller.panelOpenPositionThan1.value || controller.second.value,
                      child: IconButton(
                          onPressed: () => controller.playOrPause(),
                          icon: Obx(() => Icon(
                                controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                                size: controller.playing.value ? 46.w : 42.w,
                                color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                              ))),
                    ))),
            // ClassWidget(
            //     child: Obx(() => Visibility(
            //       visible: !controller.panelOpenPositionThan1.value || controller.second.value,
            //       child: IconButton(
            //           onPressed: () => controller.likeSong(),
            //           icon: Obx(() => Icon(
            //             controller.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.heartbeat : TablerIcons.heart,
            //             size: 46.w,
            //             color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
            //           ))),
            //     )))
          ],
        ),
        Positioned(
          left: controller.getImageLeft(),
          child: SimpleExtendedImage(
            '${controller.mediaItem.value.extras?['image']}?param=500y500',
            fit: BoxFit.cover,
            height: controller.getImageSize(),
            width: controller.getImageSize(),
            borderRadius: BorderRadius.circular(controller.getImageSize() / 2 * (1 - controller.slidePosition.value * .88)),
          ),
        ),
      ],
    );
  }

  Widget _buildPanelHeaderL(bottomHeight, context) {
    return Obx(() => IgnorePointer(
          ignoring: controller.panelOpenPositionThan1.value && !controller.second.value,
          child: Visibility(
            replacement: GestureDetector(
              child: _buildPanelHeaderToL(bottomHeight, context),
              onHorizontalDragDown: (e) {},
              onTap: () {
                if (!controller.panelControllerHome.isPanelOpen) {
                  controller.panelControllerHome.open();
                } else {
                  if (controller.panelController.isPanelOpen) controller.panelController.close();
                }
              },
            ),
            visible: controller.second.value,
            child: GestureDetector(
              child: _buildPanelHeaderToL(bottomHeight, context),
              onHorizontalDragDown: (e) {},
              onVerticalDragDown: (e) {},
              onTap: () {
                if (!controller.panelControllerHome.isPanelOpen) {
                  controller.panelControllerHome.open();
                } else {
                  if (controller.panelController.isPanelOpen) controller.panelController.close();
                }
              },
            ),
          ),
        ));
  }

  Widget _buildPanelHeaderToL(bottomHeight, context) {
    return Stack(
      children: [
        Container(
          padding: controller.getHeaderPadding(context).copyWith(top: 0),
          width: Get.width,
          height: controller.getPanelMinSize() + bottomHeight,
          child: _buildPlayBarL(context),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            child: Obx(() => Container(
                  color: Colors.transparent,
                  height: bottomHeight * (controller.panelOpenPositionThan1.value ? 0 : 1),
                  width: Get.width,
                )),
            onVerticalDragDown: (e) {},
          ),
        )
      ],
    );
  }

  Widget _buildPlayBarL(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: controller.panelHeaderSize,
                child: Obx(() => RichText(
                      text: !controller.panelOpenPositionThan1.value || controller.second.value
                          ? TextSpan(
                              text: '${controller.mediaItem.value.title} - ',
                              children: [
                                TextSpan(
                                  text: controller.mediaItem.value.artist ?? '',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                                  fontWeight: FontWeight.w500))
                          : const TextSpan(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              Positioned(
                left: 0,
                child: Obx(() => SimpleExtendedImage(
                      '${controller.mediaItem.value.extras?['image']}?param=500y500',
                      fit: BoxFit.cover,
                      height: controller.getImageSizeL(),
                      width: controller.getImageSizeL(),
                      borderRadius: BorderRadius.circular(controller.getImageSizeL() / 2),
                    )),
              ),
            ],
          ),
        ),
        FrameSeparateWidget(
            child: Obx(() => Visibility(
                  visible: !controller.panelOpenPositionThan1.value || controller.second.value,
                  child: IconButton(
                      onPressed: () => controller.playOrPause(),
                      icon: Icon(
                        controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                        size: controller.playing.value ? 46.w : 42.w,
                        color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                      )),
                ))),
        FrameSeparateWidget(
            child: Obx(() => Visibility(
                  visible: !controller.panelOpenPositionThan1.value || controller.second.value,
                  child: IconButton(
                      onPressed: () {
                        if (controller.intervalClick(1)) controller.audioServeHandler.skipToNext();
                      },
                      icon: Icon(
                        TablerIcons.player_skip_forward,
                        size: 40.w,
                        color: controller.second.value ? controller.bodyColor.value : controller.getLightTextColor(context),
                      )),
                )))
      ],
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
