import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/weslide/weslide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widget/mobile/flashy_navbar.dart';
import '../second/second_view.dart';
import 'first_body_view.dart';

class FirstView extends GetView<HomeController> {

  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('object===first');
    controller.buildContext = context;
    return Scaffold(
      body: WillPopScope(
          child: Stack(
            children: [
              GetBuilder(builder: (c) =>AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                bottom: controller.isRoot.value ? 0 : -controller.bottomBarHeight,
                child: WeSlide(
                  controller: controller.weSlideController,
                  panelWidth: Get.width,
                  bodyWidth: Get.width,
                  panelMaxSize: Get.height + (controller.isRoot1 ? 0 : controller.bottomBarHeight),
                  parallax: true,
                  body: const HomeMobileView(),
                  panel: const SecondView(),
                  panelHeader: _buildPanelHeader(),
                  footer: _buildFooter(),
                  hidePanelHeader: false,
                  height: Get.height + (controller.isRoot1 ? 0 : controller.bottomBarHeight),
                  footerHeight: controller.bottomBarHeight + MediaQuery.of(context).padding.bottom,
                  panelMinSize: controller.panelMobileMinSize + MediaQuery.of(context).padding.bottom,
                  onPosition: (value) => controller.changeSlidePosition(value),
                  isDownSlide: controller.firstSlideIsDownSlide,
                ),
              ),id: controller.weSlideUpdate,init: controller,)
            ],
          ),
          onWillPop: () => controller.onWillPop()),
    );
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            color: controller.getHeaderColor(),
            padding: controller.getHeaderPadding(),
            width: Get.width,
            height: controller.getPanelMinSize() + controller.getPanelAdd(),
            duration: const Duration(milliseconds: 0),
            child: Column(
              children: [
                _buildTopHeader(),
                _buildPlayBar(),
                SizedBox(
                  height: (controller.isRoot.value ? 0 : MediaQuery.of(controller.buildContext).padding.bottom),
                )
              ],
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
    return SizedBox(
      height: controller.getTopHeight(),
      child: Visibility(
        visible: controller.slidePosition.value > .5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Icon(Icons.keyboard_arrow_down, color: controller.rx.value.light?.titleTextColor),
              onTap: () => controller.weSlideController.hide(),
            ),
            Icon(Icons.more_horiz, color: controller.rx.value.light?.titleTextColor)
          ],
        ),
      ),
    );
  }

  Widget _buildPlayBar() {
    return Expanded(
        child: Row(
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
                          controller.mediaItem.value.artUri?.path??'',
                          height: controller.getImageSize(),
                          width: controller.getImageSize(),
                          borderRadius: BorderRadius.circular(15.w),
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
                              style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold, color: controller.getLightTextColor()),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(controller.mediaItem.value.artist??'', style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor()))
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
                   controller.playing.value?Icons.pause:Icons.play_arrow,
                    color: controller.getLightTextColor(),
                  )),
            ),
            Visibility(
              visible: controller.slidePosition.value == 0,
              child: IconButton(
                  onPressed: () => controller.audioServeHandler.skipToNext(),
                  icon: Icon(
                    Icons.skip_next_sharp,
                    color: controller.getLightTextColor(),
                  )),
            )
          ],
        ));
  }

  Widget _buildFooter() {
    return Obx(() => controller.isRoot.value?FlashyNavbar(
      height: controller.bottomBarHeight,
      selectedIndex: controller.selectIndex.value,
      showElevation: false,
      onItemSelected: (index) {
        controller.changeSelectIndex(index);
      },
      items: [
        FlashyNavbarItem(
          icon: const Icon(Icons.event),
          title: const Text('首页'),
        ),
        FlashyNavbarItem(
          icon: const Icon(Icons.search),
          title: const Text('搜索'),
        ),
        FlashyNavbarItem(
          icon: const Icon(Icons.highlight),
          title: const Text('我的'),
        ),
        FlashyNavbarItem(
          icon: const Icon(Icons.settings),
          title: const Text('设置'),
        ),
      ],
    ):Container(
      color: Theme.of(controller.buildContext).bottomAppBarColor,
    ));
  }
}
