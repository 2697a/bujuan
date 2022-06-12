
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constants/colors.dart';
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
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
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

  //占位图
  Widget _buildPanel() {
    return Obx(() => WeSlide(
          controller: controller.weSlideController1,
          panelMaxSize: Get.height - controller.panelHeaderSize - MediaQuery.of(Get.context!).padding.top - 10.w,
          panelMinSize: controller.getSecondPanelMinSize(),
          hidePanelHeader: false,
          boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
              gradient: LinearGradient(
                  colors: [controller.rx.value.light?.color ?? Colors.white, controller.rx.value.dark?.color ?? Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          onPosition: (value) => controller.changeSlidePosition(1 - value, second: true),
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
                                  Text(
                                    p.audio.audio.metas.title ?? '',
                                    style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: controller.rx.value.dark?.bodyTextColor),
                                    maxLines: 1,
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                                  Text(
                                    p.audio.audio.metas.artist ?? '',
                                    style: TextStyle(fontSize: 28.sp, color: controller.rx.value.dark?.bodyTextColor),
                                    maxLines: 1,
                                  )
                                ],
                              )),
                            ],
                          ),
                          _buildSlide(p),
                          _buildPlayController(playing)
                        ],
                      ))),
          panel: _buildSecondPanel(),
          panelHeader: _buildSecondHead(),
        ));
  }

  Widget _buildSecondHead() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).padding.bottom),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)), color: controller.rx.value.dark?.color ?? Colors.white),
        width: Get.width,
        height: controller.getSecondPanelMinSize(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.w),
              decoration: BoxDecoration(color: controller.rx.value.dark?.bodyTextColor, borderRadius: BorderRadius.circular(5.w)),
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
                labelStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
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
      padding: EdgeInsets.only(top: 120.w),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), topRight: Radius.circular(25.w)), color: controller.rx.value.dark?.color ?? Colors.white),
      // child: PageView(
      //   children: [
      //     _buildPlayList(),
      //     Text(controller.lyric.value),
      //     Text(controller.lyric.value),
      //   ],
      // ),
    );
  }

  Widget _buildPlayList() {
    List<Audio> audios = controller.assetsAudioPlayer.playlist?.audios ?? [];
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => _buildPlayListItem(audios[index], index),
      itemCount: audios.length,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30.w),
    );
  }

  Widget _buildPlayListItem(Audio audio, int index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
        child: PlayerBuilder.current(
            player: controller.assetsAudioPlayer,
            builder: (context, playing) => Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audio.metas.title ?? '',
                          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor),
                        ),
                        Text(
                          audio.metas.artist ?? '',
                          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor),
                        )
                      ],
                    )),
                    Icon(playing.audio.audio.metas.id == audio.metas.id ? Icons.play_arrow : null, color: controller.rx.value.dark?.bodyTextColor),
                  ],
                )),
      ),
      onTap: () => controller.assetsAudioPlayer.playlistPlayAtIndex(index),
    );
  }

  Widget _buildSlide(Playing p) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: PlayerBuilder.currentPosition(
          player: controller.assetsAudioPlayer,
          builder: (context, position) => Column(
                children: [
                  SizedBox(
                    height: 80.w,
                    child: SliderTheme(
                        data: SliderThemeData(activeTrackColor: controller.rx.value.dark?.bodyTextColor, trackHeight: 10.w, thumbColor: Colors.transparent),
                        child: Slider(
                            value: position.inMilliseconds / p.audio.duration.inMilliseconds * 100,
                            max: 100,
                            onChanged: (value) {
                              controller.assetsAudioPlayer.seek(Duration(milliseconds: p.audio.duration.inMilliseconds * value ~/ 100));
                            })),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ImageUtils.getTimeStamp(position.inMilliseconds),
                          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
                        ),
                        Text(
                          ImageUtils.getTimeStamp(p.audio.duration.inMilliseconds),
                          style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
                        ),
                      ],
                    ),
                  )
                ],
              )),
    );
  }

  Widget _buildPlayController(bool isPlay) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => controller.assetsAudioPlayer.previous(),
              icon: Icon(
                Icons.skip_previous,
                size: 60.w,
                color: controller.rx.value.dark?.bodyTextColor,
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: InkWell(
              child: Icon(
                isPlay ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 140.w,
                color: controller.rx.value.dark?.bodyTextColor.withOpacity(.6),
              ),
              onTap: () => controller.playOrPause(),
            ),
          ),
          IconButton(
              onPressed: () => controller.assetsAudioPlayer.next(),
              icon: Icon(
                Icons.skip_next,
                size: 60.w,
                color: controller.rx.value.dark?.bodyTextColor,
              )),
        ],
      ),
    ));
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Obx(() => AnimatedContainer(
            color: controller.getHeaderColor(),
            padding: controller.getHeaderPadding(),
            width: Get.width,
            height: controller.getPanelMinSize()+controller.getPanelAdd(),
            duration: const Duration(milliseconds: 0),
            child: Column(
              children: [
                _buildTopHeader(),
                _buildPlayBar(),
                SizedBox(
                  height: (controller.isRoot.value ? 0 : MediaQuery.of(Get.context!).padding.bottom),
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
              child: Icon(Icons.keyboard_arrow_down, color: controller.rx.value.main?.titleTextColor),
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
                              borderRadius: BorderRadius.circular(10.w),
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
                                Text(playing.audio.audio.metas.title ?? '', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: controller.getLightTextColor())),
                                Text(playing.audio.audio.metas.artist ?? '', style: TextStyle(fontSize: 24.sp, color: controller.getLightTextColor()))
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
