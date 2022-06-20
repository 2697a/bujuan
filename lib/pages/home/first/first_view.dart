import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/pages/home/home_controller.dart';
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
    return WillPopScope(
        child: WeSlide(
          appBar: AppBar(),
          hideAppBar: true,
          controller: controller.weSlideController,
          panelWidth: Get.width,
          bodyWidth: Get.width,
          panelMaxSize: Get.height,
          parallax: true,
          body: const FirstBodyView(),
          panel: const SecondView(),
          panelHeader: _buildPanelHeader(),
          footer: _buildFooter(),
          hidePanelHeader: false,
          footerHeight: controller.bottomBarHeight,
          panelMinSize: controller.panelMobileMinSize,
          onPosition: (value) => controller.changeSlidePosition(value),
          isDownSlide: controller.firstSlideIsDownSlide,
        ),
        onWillPop: () => controller.onWillPop());
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            decoration: BoxDecoration(
              color: controller.getHeaderColor(),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
            ),
            padding: controller.getHeaderPadding(),
            width: Get.width,
            height: controller.getPanelMinSize() + controller.getPanelAdd(),
            duration: const Duration(milliseconds: 0),
            child: Column(
              children: [
                _buildTopHeader(),
                _buildPlayBar(),
                SizedBox(
                  height: (controller.isRoot.value ? 0 : controller.paddingBottom),
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
        child: PlayerBuilder.current(
            player: controller.assetsAudioPlayer,
            builder: (context, playing) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedPositioned(
                            left: controller.getImageLeft(),
                            duration: const Duration(milliseconds: 0),
                            child: Image.file(
                              File(playing.audio.audio.metas.image?.path ?? ''),
                              height: controller.getImageSize(),
                              width: controller.getImageSize(),
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
                                  playing.audio.audio.metas.title ?? '',
                                  style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold, color: controller.getLightTextColor()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(playing.audio.audio.metas.artist ?? '', style: TextStyle(fontSize: 22.sp, color: controller.getLightTextColor()))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                    Visibility(
                      visible: controller.slidePosition.value == 0,
                      child: PlayerBuilder.isPlaying(
                          player: controller.assetsAudioPlayer,
                          builder: (c, isPlaying) => IconButton(
                              onPressed: () => controller.playOrPause(),
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: controller.getLightTextColor(),
                              ))),
                    ),
                    Visibility(
                      visible: controller.slidePosition.value == 0,
                      child: IconButton(
                          onPressed: () => controller.assetsAudioPlayer.next(),
                          icon: Icon(
                            Icons.skip_next_sharp,
                            color: controller.getLightTextColor(),
                          )),
                    )
                  ],
                )));
  }

  Widget _buildFooter() {
    return Obx(() => FlashyNavbar(
          height: controller.bottomBarHeight,
          selectedIndex: controller.selectIndex.value,
          showElevation: false,
          onItemSelected: (index) {
            controller.changeSelectIndex(index);
            if (!controller.isRoot.value) {
              // Get.offUntil(GetPageRoute(page: () => const HomeMobileView()), (r) => true);
              // Get.offNamedUntil('/', (route) => true);
              Get.back();
            }
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
        ));
  }
}
