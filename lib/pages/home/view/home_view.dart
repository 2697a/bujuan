import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/body_view.dart';
import 'package:bujuan/pages/home/view/menu_view.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../widget/weslide/panel.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.6 : 0.8);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: WillPopScope(
          child: ZoomDrawer(
            dragOffset: Get.width / 2,
            menuScreenTapClose: true,
            showShadow: true,
            mainScreenTapClose: true,
            menuScreen: const MenuView(),
            moveMenuScreen: true,
            drawerShadowsBackgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
            menuBackgroundColor: Theme.of(context).cardColor,
            clipMainScreen: true,
            mainScreen: Obx(() => SlidingUpPanel(
                  controller: controller.panelControllerHome,
                  onPanelSlide: (value) => controller.changeSlidePosition(value),
                  onPanelClosed: () {
                    controller.changeStatusIconColor(false);
                  },
                  onPanelOpened: () {
                    controller.changeStatusIconColor(true);
                  },
                  parallaxEnabled: true,
                  parallaxOffset: .05,
                  boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.15))],
                  color: Colors.transparent,
                  panel: const PanelView(),
                  body: const BodyView(),
                  isDraggable: !controller.second.value,
                  header: controller.mediaItem.value.id.isNotEmpty ? _buildPanelHeader(bottomHeight,context) : const SizedBox.shrink(),
                  minHeight: controller.mediaItem.value.id.isNotEmpty ? controller.panelMobileMinSize + bottomHeight : 0,
                  maxHeight: Get.height,
                )),
            controller: controller.myDrawerController,
          ),
          onWillPop: () => controller.onWillPop()),
    );
  }

  // Container(
  // color: Colors.red,
  // height: bottomHeight,
  // )

  Widget _buildPanelHeader(bottomHeight,context) {
    return IgnorePointer(
      ignoring: controller.slidePosition.value == 1,
      child: GestureDetector(
        child: Obx(() => Stack(
              children: [
                AnimatedContainer(
                  color: Colors.transparent,
                  padding: controller.getHeaderPadding().copyWith(bottom: bottomHeight),
                  width: Get.width,
                  height: controller.getPanelMinSize() + controller.getHeaderPadding().top + bottomHeight,
                  duration: const Duration(milliseconds: 0),
                  child: _buildPlayBar(context),
                ),
                Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      height: bottomHeight * (1 - controller.slidePosition.value),
                      width: Get.width,
                    ),
                    onVerticalDragDown: (e) {
                      return;
                    },
                  ),
                )
              ],
            )),
        onHorizontalDragDown: (e) {
          return;
        },
        onTap: () {
          if (!controller.panelControllerHome.isPanelOpen) {
            controller.panelControllerHome.open();
          } else {
            if (controller.panelController.isPanelOpen) controller.panelController.close();
          }
        },
      ),
    );
  }

  Widget _buildPlayBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedPositioned(
                left: controller.getImageLeft(),
                duration: const Duration(milliseconds: 0),
                child: AnimatedScale(
                  scale: 1 + (controller.slidePosition.value / (controller.playing.value ? 6 : 7)),
                  duration: const Duration(milliseconds: 100),
                  child: SimpleExtendedImage(
                    '${controller.mediaItem.value.extras?['image']}?param=500y500',
                    fit: BoxFit.cover,
                    height: controller.getImageSize(),
                    width: controller.getImageSize(),
                    borderRadius: BorderRadius.circular(controller.getImageSize() / 2 * (1 - (controller.slidePosition.value >= .8 ? .92 : controller.slidePosition.value))),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: controller.slidePosition.value > 0 ? 0 : 1,
                duration: const Duration(milliseconds: 10),
                child: Padding(
                  padding: EdgeInsets.only(left: controller.panelHeaderSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '${controller.mediaItem.value.title} - ',
                            children: [
                              TextSpan(
                                text: controller.mediaItem.value.artist ?? '',
                                style: TextStyle(fontSize: 24.sp, color: controller.second.value?controller.getPlayPageTheme(context).withOpacity(.6):controller.getLightTextColor().withOpacity(.6), fontWeight: FontWeight.w500),
                              )
                            ],
                            style: TextStyle(fontSize: 30.sp, color: controller.second.value?controller.getPlayPageTheme(context):controller.getLightTextColor(), fontWeight: FontWeight.w500)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // Text(
                      //   controller.mediaItem.value.title,
                      //   style: TextStyle(fontSize: 32.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // )
                      // Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                      // Text(
                      //   controller.mediaItem.value.artist ?? '',
                      //   style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
                      //   maxLines: 1,
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // child: PageView.builder(
          //   controller: controller.pageController1,
          //   physics: !controller.second.value && controller.slidePosition.value == 0 ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
          //   onPageChanged: (index) {
          //     controller.audioServeHandler.playIndex(index);
          //   },
          //   itemBuilder: (context, index) => Stack(
          //     alignment: Alignment.centerLeft,
          //     children: [
          //       AnimatedPositioned(
          //           left: controller.getImageLeft(),
          //           duration: const Duration(milliseconds: 0),
          //           child: AnimatedScale(
          //             scale: 1 + (controller.slidePosition.value / (PlatformUtils.isIOS ? 7.6 : 7)),
          //             duration: const Duration(milliseconds: 100),
          //             child: SimpleExtendedImage(
          //               '${controller.mediaItems[index].extras?['image']}?param=500y500',
          //               fit: BoxFit.cover,
          //               height: controller.getImageSize(),
          //               width: controller.getImageSize(),
          //               borderRadius: BorderRadius.circular(controller.getImageSize() / 2 * (1 - (controller.slidePosition.value >= .8 ? .97 : controller.slidePosition.value))),
          //             ),
          //           )),
          //       AnimatedOpacity(
          //         opacity: controller.slidePosition.value > 0 ? 0 : 1,
          //         duration: const Duration(milliseconds: 10),
          //         child: Padding(
          //           padding: EdgeInsets.only(left: controller.panelHeaderSize),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 controller.mediaItems[index].title,
          //                 style: TextStyle(fontSize: 28.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //               Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
          //               Text(
          //                 controller.mediaItems[index].artist ?? '',
          //                 style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
          //                 maxLines: 1,
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          //   itemCount: controller.mediaItems.length,
          // ),
        ),
        Visibility(
          visible: controller.slidePosition.value == 0,
          child: IconButton(
              onPressed: () => controller.playOrPause(),
              icon: Icon(
                controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                size: controller.playing.value ? 46.w : 42.w,
                color: controller.second.value?controller.getPlayPageTheme(context).withOpacity(.6):controller.getLightTextColor().withOpacity(.6),
              )),
        ),
        Visibility(
          visible: controller.slidePosition.value == 0,
          child: IconButton(
              onPressed: () {
                if (controller.intervalClick(1)) controller.audioServeHandler.skipToNext();
              },
              icon: Icon(
                TablerIcons.player_skip_forward,
                size: 40.w,
                color: controller.second.value?controller.getPlayPageTheme(context).withOpacity(.6):controller.getLightTextColor().withOpacity(.6),
              )),
        )
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
