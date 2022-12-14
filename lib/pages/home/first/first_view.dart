import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/first/first_controller.dart';
import 'package:bujuan/pages/home/first/menu_view.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/pages/home/second/second_body_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/weslide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../../routes/router.dart';
import '../../../widget/mobile/flashy_navbar.dart';

class FirstView extends GetView<FirstController> {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
          child: GetBuilder(
            builder: (c) => ZoomDrawer(
              // mainScreenScale:.1,
              dragOffset: Get.width / 4,
              // openCurve: Curves.fastOutSlowIn,
              openCurve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 200),
              menuScreenTapClose: true,
              showShadow: true,
              mainScreenTapClose: true,
              menuScreen: const MenuView(),
              moveMenuScreen: true,
              menuBackgroundColor: Theme.of(context).primaryColor.withOpacity(.9),
              mainScreen: WeSlide(
                controller: controller.weSlideController,
                panelWidth: Get.width,
                bodyWidth: Get.width,
                panelMaxSize: Get.height,
                parallax: true,
                body: const HomeMobileView(),
                panel: const SecondBodyView(),
                panelHeader: _buildPanelHeader(),
                hidePanelHeader: false,
                isDownSlide: controller.isDownSlide,
                height: Get.height,
                panelMinSize: controller.panelMobileMinSize + MediaQuery.of(controller.buildContext).padding.bottom * .5,
                onPosition: (value) => controller.changeSlidePosition(value),
              ),
              controller: controller.myDrawerController,
            ),
            id: controller.weSlideUpdate,
            init: controller,
          ),
          onWillPop: () => controller.onWillPop()),
    );
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            decoration: BoxDecoration(color: controller.getHeaderColor(), border: Border(bottom: BorderSide(color: controller.getHeaderColor(), width: 1.w))),
            padding: controller.getHeaderPadding(),
            width: Get.width,
            height: controller.getPanelMinSize() +
                controller.getHeaderPadding().top +
                (controller.slidePosition.value == 0 ? MediaQuery.of(controller.buildContext).padding.bottom * .5 : 0),
            duration: const Duration(milliseconds: 0),
            child: _buildPlayBar(),
          )),
      onTap: () {
        if (!controller.weSlideController.isOpened) {
          controller.weSlideController.show();
        } else {
          if (controller.panelController.isPanelOpen) controller.panelController.close();
        }
      },
    );
  }

  Widget _buildTopHeader() {
    return Container(
      padding: EdgeInsets.only(top: 20.w),
      height: controller.getTopHeight(),
      child: Visibility(
        visible: controller.slidePosition.value > .5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: const Icon(Icons.keyboard_arrow_down),
              onTap: () => controller.weSlideController.hide(),
            ),
            const Icon(Icons.more_horiz)
          ],
        ),
      ),
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
                duration: const Duration(milliseconds: 0),
                child: AnimatedScale(
                  scale: 1 + (controller.slidePosition.value / 10),
                  duration: Duration.zero,
                  child: SimpleExtendedImage(
                    '${controller.mediaItem.value.extras?['image']}?param=500y500',
                    height: controller.getImageSize(),
                    width: controller.getImageSize(),
                    borderRadius: BorderRadius.circular(controller.getImageSize() / 2 * (1 - (controller.slidePosition.value >= .8 ? .95 : controller.slidePosition.value))),
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
                      style: TextStyle(fontSize: 28.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 1.w)),
                    Text(controller.mediaItem.value.artist ?? '', style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor(), fontWeight: FontWeight.bold))
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
              onPressed: () => controller.audioServeHandler.skipToNext(),
              icon: Icon(
                TablerIcons.playerSkipForward,
                size: 40.w,
                color: controller.getLightTextColor(),
              )),
        )
      ],
    );
  }

// Widget _buildFooter() {
//   return Obx(() => controller.isRoot.value
//       ? FlashyNavbar(
//           iconSize: 46.w,
//           height: controller.bottomBarHeight,
//           selectedIndex: controller.selectIndex.value,
//           showElevation: false,
//           onItemSelected: (index) {
//             controller.changeSelectIndex(index);
//           },
//           items: [
//             FlashyNavbarItem(
//               icon: const Icon(TablerIcons.smartHome),
//               title: const Text('首页'),
//             ),
//             FlashyNavbarItem(
//               icon: const Icon(TablerIcons.disc),
//               title: const Text('专辑'),
//             ),
//             FlashyNavbarItem(
//               icon: const Icon(TablerIcons.brandTiktok),
//               title: const Text('单曲'),
//             ),
//             FlashyNavbarItem(
//               icon: const Icon(TablerIcons.user),
//               title: const Text('歌手'),
//             ),
//           ],
//         )
//       : Container(
//           color: Theme.of(controller.buildContext).bottomAppBarColor,
//         ));
// }
}

class LeftMenu {
  String title;
  IconData icon;
  String path;

  LeftMenu(this.title, this.icon, this.path);
}
