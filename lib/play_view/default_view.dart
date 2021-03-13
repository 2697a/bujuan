import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/play_list/play_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(230.0)),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                width: 230.0,
                height: 230.0,
                imageUrl: "${controller.song.value.iconUri}?param=500y500",
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            Expanded(child: Text("data")),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            Text("${controller.playPos}"),
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
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(8.0) ,topRight: Radius.circular(8.0)),
                        ),
                      );
                    }),
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      size: 32.0,
                    ),
                    onPressed: () => controller.skipToPrevious()),
                IconButton(
                    icon: Icon(
                      controller.playState.value == PlayState.PLAYING
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 36.0,
                    ),
                    onPressed: () => controller.playOrPause()),
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
                  Padding(
                    padding: EdgeInsets.only(top: Get.statusBarHeight / 2),
                  ),
                  Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(200.0)),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      width: 200.0,
                      height: 200.0,
                      imageUrl:
                          "${controller.song.value.iconUri}?param=500y500",
                    ),
                  ),
                  Expanded(child: Container()),
                  // LyricView(lyric: controller.lyric.value.lrc.lyric,pos: controller.playPos.value,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.skip_previous,
                            size: 32.0,
                          ),
                          onPressed: () => controller.skipToPrevious()),
                      IconButton(
                          icon: Icon(
                            controller.playState.value == PlayState.PLAYING
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 36.0,
                          ),
                          onPressed: () => controller.playOrPause()),
                      IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            size: 32.0,
                          ),
                          onPressed: () => controller.skipToNext()),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
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
                  Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                ],
              ),
              flex: 1,
            )
          ],
        ));
  }
}
