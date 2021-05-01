import 'dart:ui';

import 'package:bujuan/api/lyric/lyric_view.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_view/music_talk/music_talk_controller.dart';
import 'package:bujuan/pages/play_view/play_list_view.dart';
import 'package:bujuan/pages/play_widget/protrait/circular_play_view.dart';
import 'package:bujuan/pages/play_widget/protrait/square_play_view.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class PlayWidgetView extends GetView<GlobalController> {
  final isHome;
  final Widget widget;
  final WeSlideController weSlideController = WeSlideController();
  final PreloadPageController pageController = PreloadPageController();
  final Widget appBar;
  final Widget bottomBar;

  PlayWidgetView(this.widget,
      {this.isHome = false, this.appBar, this.bottomBar});

  ///方形
  @override
  Widget build(BuildContext context) {
    controller.addSliderListener(weSlideController, pageController);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: OrientationBuilder(
            builder: (context, orientation) => GetBuilder<HomeController>(
              builder: (HomeController homeController) => WeSlide(
                appBar: appBar,
                overlay: true,
                overlayOpacity: homeController.miniPlayView ? 0.4 : 0,
                appBarHeight: !GetUtils.isNullOrBlank(appBar)
                    ? 56.0 + MediaQueryData.fromWindow(window).padding.top
                    : 0,
                backgroundColor: Colors.transparent,
                controller: weSlideController,
                panelMaxSize: !homeController.miniPlayView ||
                        orientation == Orientation.landscape
                    ? ScreenUtil().setHeight(812)
                    : ScreenUtil().setHeight(650),
                panelMinSize: GetUtils.isNullOrBlank(bottomBar) ? 62 : 118.0,
                body: widget,
                parallax: true,
                panel: _buildPlayView(orientation),
                panelHeader: _buildPlayBottomBar(),
                footer: bottomBar,
              ),
              id: 'view_type',
              init: HomeController(),
            ),
          ),
        ),
        onWillPop: () async {
          if (weSlideController.isOpened) {
            weSlideController?.hide();
            return false;
          } else {
            if (isHome) {
              await Starry.moveToBack();
              return false;
            } else {
              return true;
            }
          }
        });
  }

  Widget _buildPlayBottomBar() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 3),
      height: 59.0,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        ),
        elevation: 8,
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 18, right: 8),
          leading: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(44)),
            clipBehavior: Clip.antiAlias,
            child: Obx(() => controller.playListMode.value == PlayListMode.LOCAL
                ? controller.getLocalImage(50, 50)
                : CachedNetworkImage(
              width: 44,
              height: 44,
              imageUrl: controller.song.value.musicId != '-99'
                  ? '${controller.song.value.iconUri}?param=80y80'
                  : '${controller.song.value.iconUri}',
            )),
          ),
          title: Obx(() => Text(
            '${controller.song.value.title}',
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          )),
          subtitle: Obx(() => Text('${controller.song.value.artist}',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]))),
          trailing: Wrap(
            children: [
              Obx(() => IconButton(
                  icon: Icon(controller.playState.value == PlayState.PLAYING
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () => controller.playOrPause(),
                  color: Theme.of(Get.context).bottomAppBarColor)),
              IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () => controller.skipToNext(),
                  color: Theme.of(Get.context).bottomAppBarColor),
            ],
          ),
          onTap: () => weSlideController?.show(),
        ),
      ),
    );
  }

  Widget _buildPlayView(orientation) {
    return orientation == Orientation.portrait
        ? GetBuilder<HomeController>(
            builder: (_) => _.secondPlayView
                ? SquarePlayView(weSlideController, pageController)
                : CircularPlayView(weSlideController, pageController),
            id: 'second_view',
            init: HomeController(),
          )
        : Material(
            child: _buildLandscape(),
          );
  }
  ///歌曲封面
  Widget _buildMusicCover(size) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          child: RotationTransition(
            turns: controller.animationController,
            child: Card(
              margin: EdgeInsets.all(6.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(300.r)),
              clipBehavior: Clip.antiAlias,
              child: controller.playListMode.value == PlayListMode.LOCAL
                  ? controller.getLocalImage(size, 300.h)
                  : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: controller.song.value.musicId != '-99' ? '${controller.song.value.iconUri}' : '${controller.song.value.iconUri}',
              ),
            ),
          ),
        ),
        Container(
          width: size,
          height: size,
          child: Card(
            color: Colors.grey.withOpacity(.6),
            margin: EdgeInsets.all(6.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(300.r)),
            clipBehavior: Clip.antiAlias,
          ),
        ),
        SleekCircularSlider(
          appearance: CircularSliderAppearance(
              size: size,
              animationEnabled: false,
              startAngle: 45,
              angleRange: 320,
              customColors: CustomSliderColors(
                trackColor: Colors.grey[500].withOpacity(.6),
                progressBarColors: [
                  Theme.of(Get.context).accentColor,
                  Theme.of(Get.context).accentColor,
                ],
              ),
              customWidths: CustomSliderWidths(trackWidth: 1, progressBarWidth: 4.5, handlerSize: 1.5)),
          min: 0,
          max: 1,
          innerWidget: (v) => Text(''),
          initialValue: controller.playPos.value / (controller.song.value.duration ~/ 1000),
          onChange: (value) {
            controller.onSliderChanged(value);
          },
          onChangeStart: (value) => controller.onSliderChangeStart(value),
          onChangeEnd: (value) => controller.onSliderChangeEnd(value),
        ),
        Container(
          width: size,
          height: size,
          child:  Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      size: 32.0,
                      color: Theme.of(Get.context).accentColor.withOpacity(.85),
                    ),
                    onPressed: () => controller.skipToPrevious()),
                Container(
                  decoration: BoxDecoration(
                      color:
                      Theme.of(Get.context).accentColor.withOpacity(.85),
                      borderRadius: BorderRadius.all(Radius.circular(52.0))),
                  width: 56.0,
                  height: 56.0,
                  child: Obx(() => IconButton(
                      icon: Icon(
                        controller.playState.value == PlayState.PLAYING
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 26.0,
                      ),
                      onPressed: () => controller.playOrPause())),
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 32.0,
                      color: Theme.of(Get.context).accentColor.withOpacity(.85),
                    ),
                    onPressed: () => controller.skipToNext()),
              ],
            ),
          ),
        ),
      ],
    );
  }
  ///横屏播放页
  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Obx(()=>_buildMusicCover(300.0)),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Get.statusBarHeight / 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(() {
                  return controller.lyric.value.size > 0 &&
                          controller.playListMode.value != PlayListMode.LOCAL &&
                          controller.playListMode.value != PlayListMode.RADIO
                      ? LyricView(
                          textAlign: TextAlign.center,
                          lyric: controller.lyric.value,
                          size: Size(MediaQuery.of(Get.context).size.width / 2,
                              135.w),
                          playing:
                              controller.playState.value == PlayState.PLAYING,
                          highlight: Theme.of(Get.context).accentColor,
                          position: controller.playPos.value * 1000,
                          lyricLineStyle: TextStyle(
                              color: Colors.grey, fontSize: 20.0, height: 2.2),
                          onTap: () {},
                        )
                      : Center(
                          child: Text('暂无歌词'),
                        );
                }),
              ),

            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => Visibility(
              child: IconButton(
                  icon: Icon(
                    Icons.format_list_bulleted_outlined,
                  ),
                  onPressed: () {
                    Get.bottomSheet(
                      PlayListView(),
                      backgroundColor:
                      Theme.of(Get.context).primaryColor,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                    );
                  }),
              visible: controller.playListMode.value ==
                  PlayListMode.SONG ||
                  controller.playListMode.value == PlayListMode.LOCAL,
            )),
            Obx(() => IconButton(
                icon: Icon(
                  controller.playListMode.value == PlayListMode.SONG ||
                      controller.playListMode.value ==
                          PlayListMode.LOCAL
                      ? controller.playMode.value == 1
                      ? Icons.repeat
                      : controller.playMode.value == 2
                      ? Icons.repeat_one
                      : Icons.shuffle
                      : Icons.sync_disabled_rounded,
                ),
                onPressed: () => controller.changePlayMode())),
            Visibility(
                child: IconButton(
                    icon: Icon(
                      const IconData(0xe619, fontFamily: 'iconfont'),
                    ),
                    onPressed: () {
                      Get.toNamed('/music_talk', arguments: {
                        'talk_info': TalkInfo(controller.playListMode.value == PlayListMode.RADIO ? 4 : 0, controller.song.value.musicId,
                            controller.song.value.iconUri, controller.song.value.title)
                      });
                    }),
                visible: controller.playListMode.value != PlayListMode.LOCAL),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
      ],
    );
  }
}
