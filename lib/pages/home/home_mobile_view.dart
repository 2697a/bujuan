import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
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
              backgroundColor: Colors.transparent,
              body: _buildBody(),
              panel: _buildPanel(),
              panelHeader: _buildPanelHeader(),
              footer: _buildFooter(),
              footerHeight: controller.bottomBarHeight,
              panelMinSize: controller.panelMobileMinSize,
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
    return PlayerBuilder.currentPosition(
        player: controller.assetsAudioPlayer,
        builder: (context, position) => PlayerBuilder.isPlaying(
            player: controller.assetsAudioPlayer,
            builder: (context, playing) => Container(
                  width: Get.width,
                  color: Colors.grey,
                  child: Center(
                    child: Obx(() => LyricsReader(
                      size: Size(Get.width, Get.height),
                          position: position.inMilliseconds,
                          playing: playing,
                          model: LyricsModelBuilder.create().bindLyricToMain(controller.lyric.value).getModel(),
                          lyricUi: UINetease(
                            highlight: false,
                          ),
                          selectLineBuilder: (p, c) {
                            return Row(
                              children: [IconButton(onPressed: () {
                                controller.assetsAudioPlayer.seek(Duration(milliseconds: p));
                                c.call();
                              }, icon: const Icon(Icons.play_arrow)),
                              Expanded(child: Container(height: 1.w,color: Colors.black,)),
                              Text(position.inMilliseconds.toString())],
                            );
                          },
                        )),
                  ),
                )));
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(color: Get.theme.bottomAppBarColor, boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          )
        ]),
        height: controller.panelMinSize,
        child: PlayerBuilder.current(
            player: controller.assetsAudioPlayer,
            builder: (context, playing) => Row(
                  children: [
                    SimpleExtendedImage(
                      playing.audio.audio.metas.image?.path ?? '',
                      width: 80.w,
                      height: 80.w,
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            playing.audio.audio.metas.title ?? '',
                            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                    PlayerBuilder.isPlaying(
                        player: controller.assetsAudioPlayer,
                        builder: (context, playing) => IconButton(
                              onPressed: () => controller.playOrPause(),
                              icon: playing ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                            ))
                  ],
                )),
      ),
      onTap: () => controller.weSlideController.show(),
    );
  }

  Widget _buildFooter() {
    return Obx(() => FlashyNavbar(
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
        ));
  }
}
