import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/home/first/menu_view.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/pages/home/home_provider.dart';
import 'package:bujuan/pages/home/second/second_body_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/weslide.dart';
import 'package:bujuan/widget/weslide/weslide_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

class FirstView extends GetView<HomeController> {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = PlatformUtils.isIOS ? 0 : MediaQuery.of(controller.buildContext).padding.bottom * .6;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
          child: ZoomDrawer(
            dragOffset: Get.width / 2,
            // openCurve: Curves.fastOutSlowIn,
            // disableDragGesture: true,
            // openCurve: Curves.fastLinearToSlowEaseIn,
            // duration: const Duration(milliseconds: 200),
            menuScreenTapClose: true,
            showShadow: true,
            mainScreenTapClose: true,
            menuScreen: const MenuView(),
            moveMenuScreen: true,
            drawerShadowsBackgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
            menuBackgroundColor: Theme.of(context).cardColor,
            clipMainScreen: true,
            mainScreen: Obx(() {
              //TODO 熱更新时 会重构obx下的组件，WeSlide会走dispose方法，controller被dispose了，会出现问题，暂时没法判断是否被dispose，每次重构是重新实例化一下
              controller.weSlideController = WeSlideController();
              return WeSlide(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                controller: controller.weSlideController,
                panelWidth: Get.width,
                bodyWidth: Get.width,
                panelMaxSize: Get.height,
                panelBorderRadiusBegin: 30.w,
                panelBorderRadiusEnd: 30.w,
                parallax: true,
                body: const HomeMobileView(),
                panel: const SecondBodyView(),
                panelHeader: controller.mediaItem.value.id.isNotEmpty ? _buildPanelHeader() : const SizedBox.shrink(),
                hidePanelHeader: false,
                isDownSlide: controller.isDownSlide.value,
                footer: controller.mediaItem.value.id.isNotEmpty ? Container(color: Theme.of(context).bottomAppBarColor, height: bottomHeight) : const SizedBox.shrink(),
                footerHeight: controller.mediaItem.value.id.isNotEmpty ? bottomHeight : 0,
                // height: Get.height,
                panelMinSize: controller.mediaItem.value.id.isNotEmpty
                    ? controller.panelMobileMinSize + (PlatformUtils.isIOS ? MediaQuery.of(controller.buildContext).padding.bottom * .5 : bottomHeight)
                    : 0,
                onPosition: (value) => controller.changeSlidePosition(value),
              );
            }),
            controller: controller.myDrawerController,
          ),
          onWillPop: () => controller.onWillPop()),
    );
  }

  Widget _buildPanelHeader() {
    return GestureDetector(
      child: Obx(() => AnimatedContainer(
            decoration: BoxDecoration(color: controller.getHeaderColor(), border: Border(bottom: BorderSide(color: controller.getHeaderColor(), width: 1.w))),
            padding: controller.getHeaderPadding().copyWith(bottom: PlatformUtils.isIOS ? MediaQuery.of(controller.buildContext).padding.bottom * .5 : 0),
            width: Get.width,
            height: controller.getPanelMinSize() + controller.getHeaderPadding().top + (PlatformUtils.isIOS ? MediaQuery.of(controller.buildContext).padding.bottom * .5 : 0),
            duration: const Duration(milliseconds: 0),
            child: _buildPlayBar(),
          )),
      onHorizontalDragDown: (e){
        return;
      },
      onTap: () {
        if (!controller.weSlideController.isOpened) {
          controller.weSlideController.show();
        } else {
          if (controller.panelController.isPanelOpen) controller.panelController.close();
        }
      },
    );
  }

  Widget _buildPlayBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedPositioned(
                left: controller.getImageLeft(),
                // top: controller.getTopHeight(),
                duration: const Duration(milliseconds: 0),
                child: AnimatedScale(
                  scale: 1 + (controller.slidePosition.value / 6.5),
                  duration: const Duration(milliseconds: 90),
                  child: SimpleExtendedImage(
                    '${controller.mediaItem.value.extras?['image']}?param=500y500',
                    fit: BoxFit.cover,
                    height: controller.getImageSize(),
                    width: controller.getImageSize(),borderRadius: BorderRadius.circular(controller.getImageSize() / 2 * (1 - (controller.slidePosition.value >= .8 ? .95 : controller.slidePosition.value))),
                  ),
                )),
            AnimatedOpacity(
              opacity: controller.slidePosition.value > 0 ? 0 : 1,
              duration: const Duration(milliseconds: 10),
              child: Padding(
                padding: EdgeInsets.only(left: controller.panelHeaderSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.mediaItem.value.title,
                      style: TextStyle(fontSize: 28.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                    Text(
                      controller.mediaItem.value.artist ?? '',
                      style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
        Visibility(
          visible: controller.slidePosition.value == 0,
          child: IconButton(
              onPressed: () => controller.playOrPause(),
              icon: Icon(
                controller.playing.value ? TablerIcons.playerPause : TablerIcons.playerPlay,
                size: controller.playing.value ? 46.w : 42.w,
                color: controller.getLightTextColor(),
              )),
        ),
        Visibility(
          visible: controller.slidePosition.value == 0,
          child: IconButton(
              onPressed: () {
                if (controller.intervalClick(1)) controller.audioServeHandler.skipToNext();
              },
              icon: Icon(
                TablerIcons.playerSkipForward,
                size: 40.w,
                color: controller.getLightTextColor(),
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

// class FirstWidget extends ConsumerWidget {
//   FirstWidget({super.key});
//
//   final double panelHeaderSize = 90.h;
//   final double secondPanelHeaderSize = 120.w;
//   final double panelMobileMinSize = 90.h;
//   final double topBarHeight = 110.h;
//   final WeSlideController weSlideController = WeSlideController();
//   final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     double bottomHeight = PlatformUtils.isIOS ? 0 : MediaQuery.of(context).padding.bottom * .6;
//     return Scaffold(
//       body: WillPopScope(
//           child: ZoomDrawer(
//             dragOffset: Get.width / 2,
//             openCurve: Curves.fastOutSlowIn,
//             // openCurve: Curves.fastLinearToSlowEaseIn,
//             duration: const Duration(milliseconds: 200),
//             menuScreenTapClose: true,
//             showShadow: true,
//             mainScreenTapClose: true,
//             menuScreen: const MenuView(),
//             moveMenuScreen: true,
//             drawerShadowsBackgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(.6),
//             menuBackgroundColor: Theme.of(context).cardColor,
//             clipMainScreen: true,
//             mainScreen: Obx(() {
//               //TODO 熱更新时 会重构obx下的组件，WeSlide会走dispose方法，controller被dispose了，会出现问题，暂时没法判断是否被dispose，每次重构是重新实例化一下
//               return WeSlide(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                 controller: weSlideController,
//                 panelWidth: Get.width,
//                 bodyWidth: Get.width,
//                 panelMaxSize: Get.height,
//                 panelBorderRadiusBegin: 30.w,
//                 panelBorderRadiusEnd: 30.w,
//                 parallax: true,
//                 body: const HomeMobileView(),
//                 panel: const SecondBodyView(),
//                 panelHeader: (ref.watch(mediaItemProvider.notifier).state.mediaItem.id).isNotEmpty ? _buildPanelHeader() : const SizedBox.shrink(),
//                 hidePanelHeader: false,
//                 isDownSlide: (ref.watch(mediaItemProvider.notifier).state.isDownSlide),
//                 footer: (ref.watch(mediaItemProvider.notifier).state.mediaItem.id).isNotEmpty ? Container(color: Theme.of(context).bottomAppBarColor, height: bottomHeight) : const SizedBox.shrink(),
//                 footerHeight: (ref.watch(mediaItemProvider.notifier).state.mediaItem.id).isNotEmpty ? bottomHeight : 0,
//                 // height: Get.height,
//                 panelMinSize: (ref.watch(mediaItemProvider.notifier).state.mediaItem.id).isNotEmpty
//                     ? panelMobileMinSize + (PlatformUtils.isIOS ? MediaQuery.of(context).padding.bottom * .5 : bottomHeight)
//                     : 0,
//                 onPosition: (value) => ref.read(mediaItemProvider.notifier).state.weSlidePosition = value,
//               );
//             }),
//             controller: zoomDrawerController,
//           ),
//           onWillPop: () async{
//             return false;
//           }),
//     );
//   }
//
//   Widget _buildPanelHeader() {
//     return InkWell(
//       child: AnimatedContainer(
//         decoration: BoxDecoration(color: controller.getHeaderColor(), border: Border(bottom: BorderSide(color: controller.getHeaderColor(), width: 1.w))),
//         padding: controller.getHeaderPadding().copyWith(bottom: PlatformUtils.isIOS ? MediaQuery.of(controller.buildContext).padding.bottom * .5 : 0),
//         width: Get.width,
//         height: controller.getPanelMinSize() + controller.getHeaderPadding().top + (PlatformUtils.isIOS ? MediaQuery.of(controller.buildContext).padding.bottom * .5 : 0),
//         duration: const Duration(milliseconds: 0),
//         child: _buildPlayBar(),
//       ),
//       onTap: () {
//         if (weSlideController.isOpened) {
//          weSlideController.show();
//         } else {
//           // if (panelController.isPanelOpen) controller.panelController.close();
//         }
//       },
//     );
//   }
//
//   Widget _buildPlayBar() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//             child: Stack(
//           alignment: Alignment.centerLeft,
//           children: [
//             AnimatedPositioned(
//                 left: controller.getImageLeft(),
//                 // top: controller.getTopHeight(),
//                 duration: const Duration(milliseconds: 0),
//                 child: AnimatedScale(
//                   scale: 1 + (controller.slidePosition.value / 8),
//                   duration: Duration.zero,
//                   child: SimpleExtendedImage(
//                     '${controller.mediaItem.value.extras?['image']}?param=500y500',
//                     fit: BoxFit.cover,
//                     height: controller.getImageSize(),
//                     width: controller.getImageSize(),
//                     borderRadius: BorderRadius.circular(controller.getImageSize() / 2 * (1 - (controller.slidePosition.value >= .8 ? .95 : controller.slidePosition.value))),
//                   ),
//                 )),
//             AnimatedOpacity(
//               opacity: controller.slidePosition.value > 0 ? 0 : 1,
//               duration: const Duration(milliseconds: 10),
//               child: Padding(
//                 padding: EdgeInsets.only(left: controller.panelHeaderSize),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.mediaItem.value.title,
//                       style: TextStyle(fontSize: 28.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
//                     Text(
//                       controller.mediaItem.value.artist ?? '',
//                       style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.w500),
//                       maxLines: 1,
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )),
//         Visibility(
//           visible: controller.slidePosition.value == 0,
//           child: IconButton(
//               onPressed: () => controller.playOrPause(),
//               icon: Icon(
//                 controller.playing.value ? TablerIcons.playerPause : TablerIcons.playerPlay,
//                 size: controller.playing.value ? 46.w : 42.w,
//                 color: controller.getLightTextColor(),
//               )),
//         ),
//         Visibility(
//           visible: controller.slidePosition.value == 0,
//           child: IconButton(
//               onPressed: () {
//                 if (controller.intervalClick(1)) controller.audioServeHandler.skipToNext();
//               },
//               icon: Icon(
//                 TablerIcons.playerSkipForward,
//                 size: 40.w,
//                 color: controller.getLightTextColor(),
//               )),
//         )
//       ],
//     );
//   }
// }
