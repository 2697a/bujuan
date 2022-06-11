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
              backgroundColor: Colors.white,
              body: _buildBody(),
              panel: _buildPanel(),
              panelHeader: _buildPanelHeader(),
              footer: _buildFooter(),
              hidePanelHeader: false,
              footerHeight: controller.bottomBarHeight*(1+controller.slidePosition.value),
              panelMinSize: controller.panelMobileMinSize,
              onPosition: (value) => controller.changeSlidePosition(value),
            ),
            init: controller,
            id: controller.weSlideUpdate,
          ),
          onWillPop: () async {
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
    return PlayerBuilder.isPlaying(
        player: controller.assetsAudioPlayer,
        builder: (context, playing) => PlayerBuilder.current(
            player: controller.assetsAudioPlayer,
            builder: (c, p) => Container(
                  color: Colors.white,
                  width: Get.width,
                  child: Text(
                    p.audio.audio.metas.title ?? '',
                    style: TextStyle(fontSize: 32.sp),
                  ),
                )));
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(Get.context!).padding.top * controller.slidePosition.value),
            width: Get.width,
            height: controller.getPanelMinSize(),
            duration: const Duration(milliseconds: 0),
            child: PlayerBuilder.current(
                player: controller.assetsAudioPlayer,
                builder: (context, playing) => Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedPositioned(
                            left: controller.getImageLeft() / (controller.scaleImage / 2),
                            duration: const Duration(milliseconds: 0),
                            child: SimpleExtendedImage(
                              playing.audio.audio.metas.image?.path ?? '',
                              height: controller.getPanelMinSize() * controller.scaleImage,
                              width: controller.getPanelMinSize() * controller.scaleImage,
                              borderRadius: BorderRadius.circular(6.w),
                            )),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 0),
                          top:controller.getPanelMinSize(),
                          left: controller.getTitleLeft(),
                          child: AnimatedOpacity(
                            opacity: 1 - controller.slidePosition.value * 2 < 0 ? 0 : 1 - controller.slidePosition.value * 2,
                            duration: const Duration(milliseconds: 10),
                            child:
                                Text(playing.audio.audio.metas.title ?? '', style: TextStyle(fontSize: 28.sp * (1 + controller.slidePosition.value), fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    )),
          )),
      onTap: () => controller.weSlideController.show(),
    );
  }

  Widget _buildFooter() {
    return Obx(() => AnimatedContainer(
          height: controller.bottomBarHeight*(1+controller.slidePosition.value),
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
