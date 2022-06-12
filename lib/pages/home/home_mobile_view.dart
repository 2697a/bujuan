import 'dart:ffi';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../widget/mobile/flashy_navbar.dart';
import '../../widget/weslide/weslide.dart';

class HomeMobileView extends GetView<HomeController> {
  const HomeMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          child: GetBuilder(
            builder: (_) => WeSlide(
              controller: controller.weSlideController,
              panelWidth: Get.width,
              bodyWidth: Get.width,
              panelMaxSize: Get.height,
              parallax: true,
              body: _buildBody(),
              panel: _buildPanel(),
              panelHeader: _buildPanelHeader(),
              footer: _buildFooter(),
              hidePanelHeader: false,
              footerHeight: controller.bottomBarHeight,
              panelMinSize: controller.panelMobileMinSize,
              onPosition: (value) => controller.changeSlidePosition(value),
              isDownSlide: controller.firstSlideIsDownSlide,
            ),
            init: controller,
            id: controller.weSlideUpdate,
          ),
          onWillPop: () async {
            if(controller.weSlideController1.isOpened){
              controller.weSlideController1.hide();
              return false;
            }
            if (controller.weSlideController.isOpened) {
              controller.weSlideController.hide();
              return false;
            }
            return true;
          }),
    );
  }

  Widget _buildBody() {
    return GetMaterialApp(
      color: Colors.lightBlue,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.circularReveal,
      routingCallback: (r) => controller.changeRoute(r?.current),
      home: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          IndexView(),
          UserView(),
          IndexView(),
          UserView(),
        ],
      ),
    );
  }

  Widget _buildPanel() {
    return Obx(() => WeSlide(
          controller: controller.weSlideController1,
          panelMaxSize: Get.height -
              controller.panelMinSize -
              MediaQuery.of(Get.context!).padding.top -
              20.w,
          panelMinSize: 152.w,
          hidePanelHeader: false,
          boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w)),
              gradient: LinearGradient(colors: [
                controller.rx.value.light?.color ?? Colors.white,
                controller.rx.value.light?.color ?? Colors.white
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          onPosition: (value) =>
              controller.changeSlidePosition(1 - value, second: true),
          body: PlayerBuilder.isPlaying(
              player: controller.assetsAudioPlayer,
              builder: (context, playing) => PlayerBuilder.current(
                  player: controller.assetsAudioPlayer,
                  builder: (c, p) => Container(
                        width: Get.width,
                        padding: EdgeInsets.only(
                            top: controller.getPanelMinSize() +
                                MediaQuery.of(Get.context!).padding.top),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 0),
                          opacity: controller.slidePosition.value <= 0
                              ? 0
                              : controller.slidePosition.value,
                        ),
                      ))),
          panel: Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.w),
                    topRight: Radius.circular(25.w)),
                gradient: LinearGradient(colors: [
                  controller.rx.value.dark?.color ?? Colors.white,
                  controller.rx.value.dark?.color ?? Colors.white
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
          ),
          panelHeader: InkWell(
            child: SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12.w),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.w)),
                    width: 80.w,
                    height: 10.w,
                  )
                ],
              ),
            ),
            onTap: () {
              if (!controller.weSlideController1.isOpened) {
                controller.weSlideController1.show();
              }
            },
          ),
        ));
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            color: Color.fromRGBO(
                255,
                255,
                255,
                (controller.second.value
                            ? (1 - controller.slidePosition.value)
                            : controller.slidePosition.value) >
                        0
                    ? 0
                    : 1),
            padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: MediaQuery.of(Get.context!).padding.top *
                    (controller.second.value
                        ? 1
                        : controller.slidePosition.value)),
            width: Get.width,
            height: controller.getPanelMinSize() +
                MediaQuery.of(Get.context!).padding.top *
                    (controller.second.value
                        ? 1
                        : controller.slidePosition.value),
            duration: const Duration(milliseconds: 0),
            child: PlayerBuilder.current(
                player: controller.assetsAudioPlayer,
                builder: (context, playing) => Row(
                      children: [
                        Expanded(
                            child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            AnimatedPositioned(
                                left: controller.getImageLeft(),
                                duration: const Duration(milliseconds: 0),
                                child: SimpleExtendedImage(
                                  playing.audio.audio.metas.image?.path ?? '',
                                  height: controller.getImageSize(),
                                  width: controller.getImageSize(),
                                  fit: BoxFit.fill,
                                  borderRadius: BorderRadius.circular(6.w),
                                )),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 0),
                              left: controller.getTitleLeft(),
                              child: AnimatedOpacity(
                                opacity:
                                    controller.slidePosition.value > 0 ? 0 : 1,
                                duration: const Duration(milliseconds: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(playing.audio.audio.metas.title ?? '',
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.bold)),
                                    Text(playing.audio.audio.metas.artist ?? '',
                                        style: TextStyle(fontSize: 24.sp))
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                        Visibility(
                          visible: controller.slidePosition.value == 0,
                          child: PlayerBuilder.isPlaying(
                              player: controller.assetsAudioPlayer,
                              builder: (c, isPlaying) => IconButton(
                                  onPressed: () => controller.playOrPause(),
                                  icon: Icon(isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow))),
                        )
                      ],
                    )),
          )),
      onTap: () => controller.weSlideController.show(),
    );
  }

  Widget _buildFooter() {
    return Obx(() => AnimatedContainer(
          height:
              controller.bottomBarHeight * (1 + controller.slidePosition.value),
          duration: const Duration(milliseconds: 1300),
          child: FlashyNavbar(
            height: controller.bottomBarHeight,
            selectedIndex: controller.selectIndex.value,
            showElevation: false,
            onItemSelected: (index) => controller.changeSelectIndex(index),
            items: [
              FlashyNavbarItem(
                icon: const Icon(Icons.event),
                title: const Text('Events'),
              ),
              FlashyNavbarItem(
                icon: const Icon(Icons.search),
                title: const Text('Search'),
              ),
              FlashyNavbarItem(
                icon: const Icon(Icons.highlight),
                title: const Text('Highlights'),
              ),
              FlashyNavbarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
            ],
          ),
        ));
  }
}
