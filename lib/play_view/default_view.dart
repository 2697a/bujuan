import 'package:bujuan/bottom_bar/lyric_view.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/play_list/play_list_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class DefaultView extends GetView<GlobalController> {
  final WeSlideController weSlideController;

  DefaultView({this.weSlideController});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortrait()
              : _buildLandscape();
        },
      ),
    ), onWillPop: () async {
      if (weSlideController.isOpened) {
        weSlideController?.hide();
        return false;
      }
      return true;
    });
  }

  Widget _buildPortrait() {
    return Obx(() => Column(
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
                    Text(controller.song.value.title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text(
                      controller.song.value.artist,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                )),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            _buildMusicCover(MediaQuery.of(Get.context).size.width / 1.4),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            LyricView(
              lyric: controller.lyric.value.lrc.lyric,
              pos: controller.playPos.value,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            // Text(
            //   "${BuJuanUtil.unix2Time(controller.playPos.value)} : ${BuJuanUtil.unix2Time(controller.song.value.duration ~/ 1000)}",
            //   style:
            //   TextStyle(color: Theme.of(Get.context).accentColor,fontWeight: FontWeight.bold,fontSize: 20.0),
            // ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
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
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      size: 32.0,
                    ),
                    onPressed: () => controller.skipToPrevious()),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context).accentColor.withOpacity(.85),
                      borderRadius: BorderRadius.all(Radius.circular(52.0))),
                  width: 54.0,
                  height: 54.0,
                  child: IconButton(
                      icon: Icon(
                        controller.playState.value == PlayState.PLAYING
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 34.0,
                      ),
                      onPressed: () => controller.playOrPause()),
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 32.0,
                    ),
                    onPressed: () => controller.skipToNext()),
                IconButton(
                    icon: Icon(
                      Icons.shuffle,
                    ),
                    onPressed: () {}),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          ],
        ));
  }

  Widget _buildLandscape() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: Center(
                    child: _buildMusicCover(MediaQuery.of(Get.context).size.height / 1.5),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
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
                      IconButton(
                          icon: Icon(
                            Icons.skip_previous,
                            size: 32.0,
                          ),
                          onPressed: () => controller.skipToPrevious()),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(Get.context).accentColor.withOpacity(.85),
                            borderRadius: BorderRadius.all(Radius.circular(52.0))),
                        width: 46.0,
                        height: 46.0,
                        child: IconButton(
                            icon: Icon(
                              controller.playState.value == PlayState.PLAYING
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 26.0,
                            ),
                            onPressed: () => controller.playOrPause()),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            size: 32.0,
                          ),
                          onPressed: () => controller.skipToNext()),
                      IconButton(
                          icon: Icon(
                            Icons.shuffle,
                          ),
                          onPressed: () {
                          }),
                    ],
                  ),
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
                  Text(
                    controller.song.value.title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Text(
                    controller.song.value.artist,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  LyricView(
                    lyric: controller.lyric.value.lrc.lyric,
                    pos: controller.playPos.value,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                ],
              ),
              flex: 1,
            )
          ],
        ));
  }


  Widget _buildMusicCover(size){
    return SleekCircularSlider(
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
          customWidths:
          CustomSliderWidths(trackWidth: 1, progressBarWidth: 4)),
      min: 0,
      max: controller.song.value.duration.toDouble(),
      initialValue: controller.playPos.value.toDouble() * 1000,
      innerWidget: (value) => Container(
        margin: EdgeInsets.all(3.0),
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadiusDirectional.circular(230.0)),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl:
                "${controller.song.value.iconUri}?param=500y500",
              ),
            ),
          ],
        ),
      ),
      // onChange: (v) => controller.seekTo(v.toInt()),
      onChangeEnd: (v) => controller.seekTo(v.toInt()),
    );
  }
}
