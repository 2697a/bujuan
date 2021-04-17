import 'dart:ui';

import 'package:bujuan/api/lyric/lyric_controller.dart';
import 'package:bujuan/api/lyric/lyric_util.dart';
import 'package:bujuan/api/lyric/lyric_widget.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_view/music_talk/music_talk_controller.dart';
import 'package:bujuan/pages/play_view/play_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class PlayWidgetView extends GetView<GlobalController> {
  final isHome;
  final Widget widget;
  final WeSlideController weSlideController = WeSlideController();
  final LyricController lyricController = LyricController();
  final Widget appBar;
  final Widget bottomBar;

  PlayWidgetView(this.widget,
      {this.isHome = false, this.appBar, this.bottomBar});

  @override
  Widget build(BuildContext context) {
    controller.addSliderListener(weSlideController);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: WeSlide(
            appBar: appBar,
            appBarHeight: !GetUtils.isNullOrBlank(appBar)
                ? 56.0 + MediaQueryData.fromWindow(window).padding.top
                : 0,
            backgroundColor: Colors.transparent,
            controller: weSlideController,
            panelMaxSize: MediaQuery.of(Get.context).size.height,
            panelMinSize: GetUtils.isNullOrBlank(bottomBar) ? 62.0 : 118.0,
            overlayColor: Colors.transparent,
            body: widget,
            parallax: true,
            panel: _buildPlayView(),
            panelHeader: _buildPlayBottomBar(),
            footer: bottomBar,
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
          contentPadding: EdgeInsets.only(left: 18.0, right: 8.0),
          leading: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(44.0)),
            clipBehavior: Clip.antiAlias,
            child: Obx(() => controller.playListMode.value == PlayListMode.LOCAL
                ? controller.getLocalImage()
                : CachedNetworkImage(
                    width: 44.0,
                    height: 44.0,
                    imageUrl: controller.song.value.musicId != '-99'
                        ? '${controller.song.value.iconUri}?param=80y80'
                        : '${controller.song.value.iconUri}',
                  )),
          ),
          title: Obx(() => Text(
                '${controller.song.value.title}',
                style: TextStyle(fontSize: 16.0),
                overflow: TextOverflow.ellipsis,
              )),
          subtitle: Obx(() => Text('${controller.song.value.artist}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[500]))),
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

  Widget _buildPlayView() {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortrait()
              : _buildLandscape();
        },
      ),
    );
  }

  ///竖屏播放页
  Widget _buildPortrait() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.statusBarHeight / 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                onPressed: () => weSlideController.hide()),
            Expanded(
                child: Column(
              children: [
                Obx(() => Text('${controller.song.value.title}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
                Obx(() => Text(
                      '${controller.song.value.artist}',
                      style: TextStyle(color: Colors.grey[600]),
                    )),
              ],
            )),
            IconButton(
                icon: Icon(
                  const IconData(0xf28e, fontFamily: 'iconfont'),
                  size: 22.0,
                ),
                onPressed: () => controller.scrobble()),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        _buildMusicCover(MediaQuery.of(Get.context).size.width / 1.45),
        Expanded(
            child: GetBuilder(
                builder: (_) {
                  return GetUtils.isNullOrBlank(controller.lyric) ||
                          GetUtils.isNullOrBlank(controller.lyric.lrc) ||
                          GetUtils.isNullOrBlank(controller.lyric.lrc.lyric) ||
                          GetUtils.isNullOrBlank(LyricUtil.formatLyric(
                              controller.lyric.lrc.lyric)) ||
                          controller.playListMode.value == PlayListMode.RADIO
                      ? Center(
                          child: Text('暂无歌词'),
                        )
                      : LyricWidget(
                          lyricMaxWidth:
                              MediaQuery.of(Get.context).size.width / 1.4,
                          enableDrag: false,
                          controller: lyricController,
                          lyrics:
                              LyricUtil.formatLyric(controller.lyric.lrc.lyric),
                          size: Size(
                              MediaQuery.of(Get.context).size.width / 1.4,
                              100));
                },
                id: 'play_pos',
                init: HomeController.to)),
        Container(
          color: Theme.of(Get.context).primaryColor,
          padding: EdgeInsets.only(top: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: HomeController.to.likeSongs
                            .contains(controller.song.value.musicId)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () => controller.likeOrUnLike())),
              IconButton(
                  icon: Obx(() => Icon(
                        controller.playListMode.value != PlayListMode.FM
                            ? Icons.skip_previous
                            : Icons.report_off,
                        size: controller.playListMode.value != PlayListMode.FM
                            ? 32.0
                            : 26.0,
                      )),
                  onPressed: () => controller.skipToPrevious()),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(Get.context).accentColor.withOpacity(.85),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                width: 50.0,
                height: 50.0,
                child: Obx(() => IconButton(
                    icon: Icon(
                      controller.playState.value == PlayState.PLAYING
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 34.0,
                    ),
                    onPressed: () => controller.playOrPause())),
              ),
              IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    size: 32.0,
                  ),
                  onPressed: () => controller.skipToNext()),
              Obx(() => IconButton(
                  icon: Icon(
                    controller.playListMode.value == PlayListMode.SONG ||
                            controller.playListMode.value == PlayListMode.LOCAL
                        ? controller.playMode.value == 1
                            ? Icons.repeat
                            : controller.playMode.value == 2
                                ? Icons.repeat_one
                                : Icons.shuffle
                        : Icons.sync_disabled_rounded,
                  ),
                  onPressed: () => controller.changePlayMode())),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 12.0)),
            IconButton(
                icon: Icon( const IconData(0xe8ae, fontFamily: 'iconfont')),
                onPressed: () => HomeController.to.showSleepBottomSheet()),
            Expanded(child: Center()),
            Obx(() => Visibility(
                  child: IconButton(
                      icon: Icon(
                        Icons.format_list_bulleted_outlined,
                      ),
                      onPressed: () {
                        Get.bottomSheet(
                          PlayListView(),
                          backgroundColor: Theme.of(Get.context).primaryColor,
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)),
                          ),
                        );
                      }),
                  visible: controller.playListMode.value == PlayListMode.SONG ||
                      controller.playListMode.value == PlayListMode.LOCAL,
                )),
            Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
            Visibility(
                child: IconButton(
                    icon: Icon(
                      const IconData(0xe619, fontFamily: 'iconfont'),
                    ),
                    onPressed: () {
                      Get.toNamed('/music_talk', arguments: {
                        'talk_info': TalkInfo(
                            controller.playListMode.value == PlayListMode.RADIO
                                ? 4
                                : 0,
                            controller.song.value.musicId,
                            controller.song.value.iconUri,
                            controller.song.value.title)
                      });
                    }),
                visible: controller.playListMode.value != PlayListMode.LOCAL),
            Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
          ],
        ),
      ],
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
              Expanded(
                  child: Center(
                child: _buildMusicCover(
                    MediaQuery.of(Get.context).size.height / 1.55),
              )),
              Row(
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
                  IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 32.0,
                      ),
                      onPressed: () => controller.skipToPrevious()),
                  Container(
                    decoration: BoxDecoration(
                        color:
                            Theme.of(Get.context).accentColor.withOpacity(.85),
                        borderRadius: BorderRadius.all(Radius.circular(52.0))),
                    width: 46.0,
                    height: 46.0,
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
                      ),
                      onPressed: () => controller.skipToNext()),
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
                ],
              ),
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
              GetBuilder(
                  builder: (_) {
                    return Expanded(
                        child: GetUtils.isNullOrBlank(controller.lyric) ||
                                GetUtils.isNullOrBlank(controller.lyric.lrc) ||
                                GetUtils.isNullOrBlank(
                                    controller.lyric.lrc.lyric) ||
                                GetUtils.isNullOrBlank(LyricUtil.formatLyric(
                                    controller.lyric.lrc.lyric))||
                            controller.playListMode.value == PlayListMode.RADIO
                            ? Center(
                                child: Text('暂无歌词'),
                              )
                            : LyricWidget(
                                lyricMaxWidth:
                                    MediaQuery.of(Get.context).size.width / 2.6,
                                enableDrag: false,
                                controller: lyricController,
                                lyrics: LyricUtil.formatLyric(
                                    controller.lyric.lrc.lyric),
                                size: Size(
                                    MediaQuery.of(Get.context).size.width / 2.6,
                                    100)));
                  },
                  id: 'play_pos',
                  init: HomeController.to),
              Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
            ],
          ),
          flex: 1,
        )
      ],
    );
  }

  ///歌曲咋换及组件
  Widget _buildMusicCover(size) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          child: Card(
            margin: EdgeInsets.all(6.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(230.0)),
            clipBehavior: Clip.antiAlias,
            child: Obx(() => controller.playListMode.value == PlayListMode.LOCAL
                ? controller.getLocalImage()
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: controller.song.value.musicId != '-99'
                        ? '${controller.song.value.iconUri}?param=500y500'
                        : '${controller.song.value.iconUri}',
                  )),
          ),
        ),
        GetBuilder(
          builder: (_) {
            return Obx(() => SleekCircularSlider(
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
                      customWidths: CustomSliderWidths(
                          trackWidth: 1, progressBarWidth: 4)),
                  min: 0,
                  max: controller.song.value.duration.toDouble(),
                  initialValue: controller.playPos.toDouble() * 1000,
                  innerWidget: (v) => Text(''),
                  onChange: (v) {
                    lyricController.progress =
                        Duration(milliseconds: v.toInt() + 800);
                  },
                  onChangeEnd: (v) => controller.seekTo(v.toInt()),
                ));
          },
          init: HomeController.to,
          id: 'play_pos',
        )
      ],
    );
  }

  ///歌词组件
  Widget _buildLyric() {}
}
