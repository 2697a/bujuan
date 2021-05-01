import 'package:bujuan/api/lyric/lyric_view.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_view/music_talk/music_talk_controller.dart';
import 'package:bujuan/pages/play_view/play_list_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class SquarePlayView extends GetView<GlobalController> {
  final WeSlideController weSlideController;
  final PreloadPageController pageController;

  SquarePlayView(this.weSlideController, this.pageController);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 2.5),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        ),
        shadowColor: Theme.of(context).accentColor.withOpacity(.6),
        elevation: 8,
        child: Container(
          width: 375.w,
          child: Column(
            children: [
              Visibility(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(Get.context).padding.top.h + 10.h),
                ),
                visible: !HomeController.to.miniPlayView,
              ),
              Visibility(
                child: Container(
                  margin: EdgeInsets.only(top: 6.h, bottom: 4.h),
                  width: 30.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                visible: HomeController.to.miniPlayView,
              ),
              Expanded(
                  child: PreloadPageView(
                controller: pageController,
                preloadPagesCount: 1,
                children: [playView(), lyricView()],
              )),
              Obx(
                () {
                  return Container(
                    height: 70.h,
                    child: Wrap(
                      children: [
                        SliderTheme(
                            data: SliderThemeData(
                                trackHeight: 3.0,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 6.0,
                                    pressedElevation: 8.0)),
                            child: Slider(
                              activeColor: Theme.of(Get.context).accentColor,
                              inactiveColor: Theme.of(Get.context)
                                  .accentColor
                                  .withOpacity(.3),
                              value: controller.playPos /
                                  (controller.song.value.duration ~/ 1000),
                              max: 1,
                              onChanged: (value) {
                                controller.onSliderChanged(value);
                              },
                              onChangeStart: (value) =>
                                  controller.onSliderChangeStart(value),
                              onChangeEnd: (value) =>
                                  controller.onSliderChangeEnd(value),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${BuJuanUtil.unix2TimeTo(controller.playPos.value * 1000)}'),
                              Text(
                                  '${BuJuanUtil.unix2TimeTo(controller.song.value.duration)}')
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Container(
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12.0)),
                    IconButton(
                        icon: Icon(
                            const IconData(0xe8ae, fontFamily: 'iconfont')),
                        onPressed: () =>
                            HomeController.to.showSleepBottomSheet()),
                    Expanded(child: Center()),
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
                              controller.playListMode.value ==
                                  PlayListMode.LOCAL,
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
                                    controller.playListMode.value ==
                                            PlayListMode.RADIO
                                        ? 4
                                        : 0,
                                    controller.song.value.musicId,
                                    controller.song.value.iconUri,
                                    controller.song.value.title)
                              });
                            }),
                        visible: controller.playListMode.value !=
                            PlayListMode.LOCAL),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playView() {
    return GetBuilder<HomeController>(
      builder: (_) => ListView(
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: Card(
              child: Obx(() => SizedBox(
                    height: 330.h,
                    child: controller.playListMode.value == PlayListMode.LOCAL
                        ? controller.getLocalImage(330.h, 12.0)
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 330.h,
                            imageUrl: controller.song.value.musicId != '-99'
                                ? '${controller.song.value.iconUri}'
                                : '${controller.song.value.iconUri}',
                          ),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: HomeController.to.miniPlayView ? 0.h : 10.h),
            height: HomeController.to.miniPlayView ? 70.h : 80.h,
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.song.value.title}',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.h)),
                    Text(
                      '${controller.song.value.artist}',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
          ),
          Visibility(
            child: Container(
                height: 100.h,
                child: Center(
                  child: HomeController.to.miniPlayView
                      ? Text('')
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Obx(() => Text(
                      controller.lyric.value.size > 0 &&
                          controller.playListMode.value !=
                              PlayListMode.LOCAL &&
                          controller.playListMode.value !=
                              PlayListMode.RADIO
                          ? '${controller.lyric.value.getLineByTimeStamp(controller.playPos.value * 1000, 0).line}'
                          : '暂无歌词',
                      style: TextStyle(
                          color: Theme.of(Get.context).accentColor,
                          fontSize: 20.sp,
                          height: 2.0),
                      textAlign: TextAlign.center,
                    )),
                  ),
                )),
            visible: !HomeController.to.miniPlayView,
          ),
          Container(
            height: HomeController.to.miniPlayView ? 90.h : 110.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(
                  () => InkWell(
                    child: Container(
                      padding: EdgeInsets.all(6.h),
                      child: Icon(
                        Icons.favorite,
                        size: 26.sp,
                        color: HomeController.to.likeSongs
                                .contains(controller.song.value.musicId)
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                    onTap: () => controller.likeOrUnLike(),
                    onLongPress: () => controller.showAddSongToPlayListSheet(),
                  ),
                ),
                IconButton(
                    icon: Obx(() => Icon(
                          controller.playListMode.value != PlayListMode.FM
                              ? Icons.skip_previous
                              : Icons.report_off,
                          size: controller.playListMode.value != PlayListMode.FM
                              ? 34.sp
                              : 26.sp,
                        )),
                    onPressed: () => controller.skipToPrevious()),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(Get.context).accentColor.withOpacity(.85),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  width: 60.h,
                  height: 60.h,
                  child: Obx(() => IconButton(
                      icon: Icon(
                        controller.playState.value == PlayState.PLAYING
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 38.sp,
                      ),
                      onPressed: () => controller.playOrPause())),
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 34.sp,
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
                      size: 26.sp,
                    ),
                    onPressed: () => controller.changePlayMode())),
              ],
            ),
          ),
        ],
      ),
      init: HomeController(),
      id: 'view_type',
    );
  }

  Widget lyricView() {
    return Column(
      children: [
        Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${controller.song.value.title}',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 2.h)),
                Text(
                  '${controller.song.value.artist}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  textAlign: TextAlign.center,
                )
              ],
            )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(() {
            return controller.lyric.value.size > 0 &&
                    controller.playListMode.value != PlayListMode.LOCAL &&
                    controller.playListMode.value != PlayListMode.RADIO
                ? LyricView(
                    textAlign: TextAlign.center,
                    lyric: controller.lyric.value,
                    size: Size(MediaQuery.of(Get.context).size.width,
                        MediaQuery.of(Get.context).size.height * .8),
                    playing: controller.playState.value == PlayState.PLAYING,
                    highlight: Theme.of(Get.context).accentColor,
                    position: controller.playPos.value * 1000,
                    lyricLineStyle: TextStyle(
                        color: Colors.grey, fontSize: 18.sp, height: 2.2),
                    onTap: () {
                      print('object${controller.playPos.value}');
                    },
                  )
                : Center(
                    child: Text('暂无歌词'),
                  );
          }),
        )),
      ],
    );
  }
}
