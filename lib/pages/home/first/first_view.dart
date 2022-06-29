import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/pages/home/second/second_body_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/weslide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/mobile/flashy_navbar.dart';
import '../second/second_view.dart';

class FirstView extends GetView<HomeController> {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      body: WillPopScope(
          child: Stack(
            children: [
              GetBuilder(
                builder: (c) => AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  bottom:
                      controller.isRoot.value ? 0 : -controller.bottomBarHeight,
                  child: WeSlide(
                    controller: controller.weSlideController,
                    panelWidth: Get.width,
                    bodyWidth: Get.width,
                    panelMaxSize: Get.height +
                        (controller.isRoot1 ? 0 : controller.bottomBarHeight),
                    parallax: true,
                    body: const HomeMobileView(),
                    panel: const SecondBodyView(),
                    panelHeader: _buildPanelHeader(),
                    footer: _buildFooter(),
                    hidePanelHeader: false,
                    height: Get.height +
                        (controller.isRoot1 ? 0 : controller.bottomBarHeight),
                    footerHeight: controller.bottomBarHeight +
                        MediaQuery.of(context).padding.bottom,
                    panelMinSize: controller.panelMobileMinSize +
                        MediaQuery.of(context).padding.bottom,
                    onPosition: (value) =>
                        controller.changeSlidePosition(value),
                    isDownSlide: controller.firstSlideIsDownSlide,
                  ),
                ),
                id: controller.weSlideUpdate,
                init: controller,
              )
            ],
          ),
          onWillPop: () => controller.onWillPop()),
    );
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            decoration: BoxDecoration(
                color: controller.getHeaderColor()),
            padding: controller.getHeaderPadding(),
            width: Get.width,
            height: controller.getPanelMinSize() +controller.topBarHeight*controller.slidePosition.value+
                MediaQuery.of(controller.buildContext).padding.top * controller.slidePosition.value,
            duration: const Duration(milliseconds: 0),
            child: Stack(
              children: [_buildTopHeader(), _buildPlayBar()],
            ),
          )),
      onTap: () {
        if (controller.weSlideController1.isOpened) {
          controller.weSlideController1.hide();
        } else {
          controller.weSlideController.show();
        }
      },
    );
  }

  Widget _buildTopHeader() {
    return Container(
      padding: EdgeInsets.only(top: 10.w),
      height: controller.getTopHeight(),
      child: Visibility(
        visible: controller.slidePosition.value > .5,
        child: Row(
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
                    child: SimpleExtendedImage(
                      controller.mediaItem.value.artUri?.path ?? '',
                      height: controller.getImageSize(),
                      width: controller.getImageSize(),
                      borderRadius: BorderRadius.circular(
                          controller.getImageSize() /
                              2 *
                              (1 -
                                  (controller.slidePosition.value >=.8
                                      ? .92
                                      : controller.slidePosition.value))),
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
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: controller.getLightTextColor()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
                        Text(controller.mediaItem.value.artist ?? '',
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: controller.getLightTextColor()))
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
                controller.playing.value
                    ? const IconData(0xe638, fontFamily: 'iconfont')
                    : const IconData(0xe634, fontFamily: 'iconfont'),
                size: 44.w,
                color: controller.getLightTextColor(),
              )),
        ),
        Visibility(
          visible: controller.slidePosition.value == 0,
          child: IconButton(
              onPressed: () => controller.audioServeHandler.skipToNext(),
              icon: Icon(
                const IconData(0xe637, fontFamily: 'iconfont'),
                size: 42.w,
                color: controller.getLightTextColor(),
              )),
        )
      ],
    );
  }

  Widget _buildFooter() {
    return Obx(() => controller.isRoot.value
        ? FlashyNavbar(
            iconSize: 54.w,
            height: controller.bottomBarHeight,
            selectedIndex: controller.selectIndex.value,
            showElevation: false,
            onItemSelected: (index) {
              controller.changeSelectIndex(index);
            },
            items: [
              FlashyNavbarItem(
                icon: const Icon(IconData(0xe6a1, fontFamily: 'iconfont')),
                title: const Text('首页'),
              ),
              FlashyNavbarItem(
                icon: const Icon(IconData(0xe6b5, fontFamily: 'iconfont')),
                title: const Text('专辑'),
              ),
              FlashyNavbarItem(
                icon: const Icon(IconData(0xe692, fontFamily: 'iconfont')),
                title: const Text('单曲'),
              ),
              FlashyNavbarItem(
                icon: const Icon(IconData(0xe683, fontFamily: 'iconfont')),
                title: const Text('歌手'),
              ),
            ],
          )
        : Container(
            color: Theme.of(controller.buildContext).bottomAppBarColor,
          ));
  }
}
