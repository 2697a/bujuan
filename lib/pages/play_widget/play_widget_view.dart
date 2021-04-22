import 'dart:ui';

import 'package:bujuan/api/lyric/lyric_view.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_widget/protrait/circular_play_view.dart';
import 'package:bujuan/pages/play_widget/protrait/square_play_view.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  ///横屏播放页
  Widget _buildLandscape() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Obx(() => Visibility(
              //           child: IconButton(
              //               icon: Icon(
              //                 Icons.format_list_bulleted_outlined,
              //               ),
              //               onPressed: () {
              //                 Get.bottomSheet(
              //                   PlayListView(),
              //                   backgroundColor:
              //                       Theme.of(Get.context).primaryColor,
              //                   elevation: 6.0,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.only(
              //                         topLeft: Radius.circular(8.0),
              //                         topRight: Radius.circular(8.0)),
              //                   ),
              //                 );
              //               }),
              //           visible: controller.playListMode.value ==
              //                   PlayListMode.SONG ||
              //               controller.playListMode.value == PlayListMode.LOCAL,
              //         )),
              //     IconButton(
              //         icon: Icon(
              //           Icons.skip_previous,
              //           size: 32.0,
              //         ),
              //         onPressed: () => controller.skipToPrevious()),
              //     Container(
              //       decoration: BoxDecoration(
              //           color:
              //               Theme.of(Get.context).accentColor.withOpacity(.85),
              //           borderRadius: BorderRadius.all(Radius.circular(52.0))),
              //       width: 46.0,
              //       height: 46.0,
              //       child: Obx(() => IconButton(
              //           icon: Icon(
              //             controller.playState.value == PlayState.PLAYING
              //                 ? Icons.pause
              //                 : Icons.play_arrow,
              //             color: Colors.white,
              //             size: 26.0,
              //           ),
              //           onPressed: () => controller.playOrPause())),
              //     ),
              //     IconButton(
              //         icon: Icon(
              //           Icons.skip_next,
              //           size: 32.0,
              //         ),
              //         onPressed: () => controller.skipToNext()),
              //     Obx(() => IconButton(
              //         icon: Icon(
              //           controller.playListMode.value == PlayListMode.SONG ||
              //                   controller.playListMode.value ==
              //                       PlayListMode.LOCAL
              //               ? controller.playMode.value == 1
              //                   ? Icons.repeat
              //                   : controller.playMode.value == 2
              //                       ? Icons.repeat_one
              //                       : Icons.shuffle
              //               : Icons.sync_disabled_rounded,
              //         ),
              //         onPressed: () => controller.changePlayMode())),
              //   ],
              // ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            ],
          ),
          flex: 1,
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Get.statusBarHeight / 2),
              ),
              Obx(() => Text(controller.song.value.title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
              ),
              Obx(() => Text(
                    controller.song.value.artist,
                    style: TextStyle(color: Colors.grey[600]),
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
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
                              MediaQuery.of(Get.context).size.height / 1.6),
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
              Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
            ],
          ),
          flex: 1,
        )
      ],
    );
  }
}
