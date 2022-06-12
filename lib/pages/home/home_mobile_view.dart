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
          onWillPop: () => controller.onWillPop()),
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
              10.w,
          panelMinSize: 120.w,
          hidePanelHeader: false,
          boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w)),
              gradient: LinearGradient(colors: [
                controller.rx.value.light?.color ?? Colors.white,
                controller.rx.value.main?.color ?? Colors.white
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          onPosition: (value) =>
              controller.changeSlidePosition(1 - value, second: true),
          body: PlayerBuilder.isPlaying(
              player: controller.assetsAudioPlayer,
              builder: (context, playing) => PlayerBuilder.current(
                  player: controller.assetsAudioPlayer,
                  builder: (c, p) => Column(
                        children: [
                          Offstage(
                            offstage: false,
                            child: _buildPanelHeader(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(p.audio.audio.metas.title ?? '',
                                      style: TextStyle(
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.bold,
                                          color: controller.textColor.value)),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                                  Text(p.audio.audio.metas.artist ?? '',
                                      style: TextStyle(
                                          fontSize: 28.sp,
                                          color: controller.textColor.value))
                                ],
                              )),
                            ],
                          ),
                          _buildPlayController(playing)
                        ],
                      ))),
          panel: _buildSecondPanel(),
          panelHeader: _buildSecondHead(),
        ));
  }

  Widget _buildSecondHead() {
    return InkWell(
      child: SizedBox(
        width: Get.width,
        height: 120.w,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.w),
              decoration: BoxDecoration(
                  color: controller.rx.value.dark?.bodyTextColor,
                  borderRadius: BorderRadius.circular(5.w)),
              width: 60.w,
              height: 8.w,
            ),
            Expanded(
                child: DefaultTabController(
              length: 3,
              child: TabBar(
                isScrollable: false,
                labelColor: controller.rx.value.dark?.bodyTextColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: controller.textColor.value,
                indicator: const BoxDecoration(),
                labelStyle:
                    TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 28.sp),
                onTap: (index) {
                  if (!controller.weSlideController1.isOpened) {
                    controller.weSlideController1.show();
                  }
                },
                tabs: const [
                  Tab(
                    text: '列表',
                  ),
                  Tab(
                    text: '歌词',
                  ),
                  Tab(
                    text: '相关',
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        if (!controller.weSlideController1.isOpened) {
          controller.weSlideController1.show();
        }
      },
    );
  }

  Widget _buildSecondPanel() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)),
          color: controller.rx.value.dark?.color ?? Colors.white),
    );
  }

  Widget _buildPlayController(bool isPlay) {
    return Container(
      child: Column(
        children: [
         Padding(padding: EdgeInsets.symmetric(vertical: 50.w),child:  Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             IconButton(
                 onPressed: () => controller.assetsAudioPlayer.previous(),
                 icon: Icon(
                   Icons.skip_previous,
                   size: 60.w,
                   color: controller.rx.value.light?.bodyTextColor,
                 )),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 40.w),
               child: InkWell(
                 child: Icon(
                   isPlay?Icons.pause_circle_filled:Icons.play_circle_fill,
                   size: 120.w,
                   color: controller.rx.value.light?.bodyTextColor,
                 ),
                 onTap: () => controller.playOrPause(),
               ),
             ),
             IconButton(
                 onPressed:  () => controller.assetsAudioPlayer.next(),
                 icon: Icon(
                   Icons.skip_next,
                   size: 60.w,
                   color: controller.rx.value.light?.bodyTextColor,
                 )),
           ],
         ),),
        ],
      ),
    );
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            color: controller.getHeaderColor(),
            padding: controller.getHeaderPadding(),
            width: Get.width,
            height: controller.getPanelMinSize() +
                MediaQuery.of(Get.context!).padding.top *
                    (controller.second.value
                        ? 1
                        : controller.slidePosition.value) +
                controller.getTopHeight(),
            duration: const Duration(milliseconds: 0),
            child: Column(
              children: [_buildTopHeader(), _buildPlayBar()],
            ),
          )),
      onTap: () => controller.weSlideController.show(),
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
              child: Icon(Icons.keyboard_arrow_down,
                  color: controller.rx.value.main?.titleTextColor),
              onTap: () => controller.weSlideController.hide(),
            ),
            Icon(Icons.more_horiz, color: controller.rx.value.main?.titleTextColor)
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
                            opacity: controller.slidePosition.value > 0 ? 0 : 1,
                            duration: const Duration(milliseconds: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(playing.audio.audio.metas.title ?? '',
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold,
                                        color: controller.getLightTextColor())),
                                Text(playing.audio.audio.metas.artist ?? '',
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        color: controller.getLightTextColor()))
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
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: controller.getLightTextColor(),
                              ))),
                    )
                  ],
                )));
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
