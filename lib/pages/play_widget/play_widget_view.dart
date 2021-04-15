import 'dart:ui';

import 'package:bujuan/api/lyric/lyric_controller.dart';
import 'package:bujuan/api/lyric/lyric_util.dart';
import 'package:bujuan/api/lyric/lyric_widget.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_view/play_list_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:bujuan/widget/timer/timer_count_down.dart';
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
  final LyricController lyricController =
      LyricController(vsync: NavigatorState());

  PlayWidgetView(this.widget, {this.isHome = false});

  @override
  Widget build(BuildContext context) {
    controller.addSliderListener(weSlideController);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: isHome
              ? Obx(() => WeSlide(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Hero(
                            tag: 'avatar',
                            child: Obx(() => Card(
                                  margin: EdgeInsets.all(0.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              30.0)),
                                  clipBehavior: Clip.antiAlias,
                                  child: HomeController
                                              .to.userProfileEntity.value !=
                                          null
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: HomeController
                                              .to
                                              .userProfileEntity
                                              .value
                                              .profile
                                              .avatarUrl,
                                          height: 34.0,
                                          width: 34.0,
                                        )
                                      : Image.asset('assets/images/logo.png',
                                          width: 34.0, height: 34.0),
                                ))),
                        onPressed: () => HomeController.to.goToProfile(),
                      ),
                      title: _buildSleepClock(),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => Get.toNamed('/search'),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () => Get.toNamed('/setting'),
                        )
                      ],
                    ),
                    appBarHeight:
                        56.0 + MediaQueryData.fromWindow(window).padding.top,
                    controller: weSlideController,
                    panelMaxSize: MediaQuery.of(Get.context).size.height,
                    panelMinSize:
                        HomeController.to.scroller.value ? 62.0 : 118.0,
                    overlayColor: Colors.transparent,
                    body: widget,
                    parallax: true,
                    panel: _buildPlayView(),
                    panelHeader: _buildBottomBar(),
                    footer: HomeController.to.scroller.value
                        ? null
                        : _buildBottomNavigationBar(),
                  ))
              : WeSlide(
                  backgroundColor: Colors.transparent,
                  controller: weSlideController,
                  panelMaxSize: MediaQuery.of(Get.context).size.height,
                  panelMinSize: 62.0,
                  overlayColor: Colors.transparent,
                  body: widget,
                  parallax: true,
                  panel: _buildPlayView(),
                  panelHeader: _buildBottomBar(),
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

  Widget _buildBottomBar() {
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
                  Icons.assignment_sharp,
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
                          GetUtils.isNullOrBlank(controller.lyric.lrc.lyric)
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
                        controller.playListMode.value == PlayListMode.SONG ||
                                controller.playListMode.value ==
                                    PlayListMode.LOCAL
                            ? Icons.skip_previous
                            : Icons.report_off,
                        size: controller.playListMode.value == PlayListMode.SONG
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
        // Text(定时
        //   '${BuJuanUtil.unix2Time(controller.playPos.value)} : ${BuJuanUtil.unix2Time(controller.song.value.duration ~/ 1000)}',
        //   style:
        //   TextStyle(color: Theme.of(Get.context).accentColor,fontWeight: FontWeight.bold,fontSize: 20.0),
        // ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 12.0)),
            IconButton(
                icon: Icon(Icons.snooze),
                onPressed: () {
                  Get.bottomSheet(
                    _buildSleepBottomSheet(),
                    backgroundColor: Theme.of(Get.context).primaryColor,
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                  );
                }),
            Expanded(
                child: Center(
                    // child: Obx(() => Text(
                    //     '当前播放：${BuJuanUtil.getPlayListModeStr(controller.playListMode.value)}',
                    //     style: TextStyle(
                    //         fontSize: 14.0,
                    //         fontWeight: FontWeight.bold,
                    //         color: Theme.of(Get.context).accentColor),
                    //     maxLines: 1,
                    //     overflow: TextOverflow.ellipsis)),
                    )),
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
                      Icons.sms_outlined,
                    ),
                    onPressed: () {
                      if (!Get.find<HomeController>().login.value) {
                        Get.find<HomeController>().goToLogin();
                      } else {
                        Get.toNamed('/music_talk', arguments: {
                          'music': controller.song.value.musicId,
                          'type': 0,
                          'iconUrl': controller.song.value.iconUri,
                          'title': controller.song.value.title
                        });
                      }
                    }),
                visible: controller.playListMode.value != PlayListMode.LOCAL),
            Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 8.0),
        // ),
      ],
    );
  }

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
                                    controller.lyric.lrc.lyric)
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

  //底部导航栏

  Widget _buildBottomNavigationBar() {
    return GetBuilder(
        init: controller,
        builder: (_) {
          return TitledBottomNavigationBar(
              reverse: true,
              enableShadow: false,
              currentIndex: HomeController.to.currentIndex,
              // Use this to update the Bar giving a position
              onTap: (index) {
                HomeController.to.changeIndex(index);
              },
              items: [
                TitledNavigationBarItem(
                    title: Text('我的'),
                    icon: Icons.nature_people_rounded,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('首页'),
                    icon: Icons.lightbulb,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('排行'),
                    icon: Icons.format_list_numbered_rounded,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('本地'),
                    icon: Icons.album,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                // TitledNavigationBarItem(
                //     title: Text('搜索'), icon: Icons.search,backgroundColor: Theme.of(Get.context).primaryColor),
              ]);
        });
    // return CustomNavigationBar(
    //   iconSize: 28.0,
    //   selectedColor: Theme.of(Get.context).accentColor,
    //   strokeColor: Theme.of(Get.context).accentColor.withOpacity(.3),
    //   unSelectedColor: Theme.of(Get.context).bottomAppBarColor,
    //   elevation: 0.0,
    //   backgroundColor: Theme.of(Get.context).canvasColor,
    //   items: [
    //     CustomNavigationBarItem(
    //       icon: Icon(Icons.person_pin),
    //       selectedIcon: Icon(Icons.person_pin_rounded),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(Icons.lightbulb_outline),
    //       selectedIcon: Icon(Icons.lightbulb),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(Icons.whatshot_outlined),
    //       selectedIcon: Icon(Icons.whatshot),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(Icons.music_note_outlined),
    //       selectedIcon: Icon(Icons.music_note),
    //     ),
    //   ],
    //   currentIndex: HomeController.to.currentIndex.value,
    //   onTap: (index) {
    //     HomeController.to.changeIndex(index);
    //   },
    // );
  }

  ///睡眠按钮
  Widget _buildSleepClock() {
    return GetBuilder(
      builder: (_) {
        return controller.sleepTime > 0
            ? InkWell(
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.snooze,
                          size: 24.0,
                        )),
                    Countdown(
                      controller: HomeController.to.countdownController,
                      seconds: controller.sleepTime ~/ 1000,
                      build: (BuildContext context, double time) {
                        return Text(
                          '${BuJuanUtil.unix2Time(time.toInt())}',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        );
                      },
                      interval: Duration(milliseconds: 1000),
                      onFinished: () {
                        print('两分钟后停止');
                      },
                    )
                  ],
                ),
                onTap: () {
                  Get.bottomSheet(
                    _buildSleepBottomSheet(),
                    backgroundColor: Theme.of(Get.context).primaryColor,
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                  );
                },
              )
            : Text('Bujuan');
      },
      init: HomeController.to,
      id: 'sleep',
    );
  }

  Widget _buildSleepBottomSheet() {
    return SizedBox(
      height: MediaQuery.of(Get.context).size.width / 5 * 2.15 + 60,
      child: GetBuilder(
        builder: (_) {
          return Column(
            children: [
              SwitchListTile(
                value: controller.sleepTime > 0,
                onChanged: (value) => controller.closeSleep(),
                title: Row(
                  children: [Text("定时停止播放")],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: MediaQuery.of(Get.context).size.width / 5 * 2.15,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      crossAxisCount: 5, //每行三列
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                        child: Container(
                          color: controller.selectIndex == index &&
                                  controller.sleepTime > 0
                              ? Theme.of(context).accentColor
                              : CardTheme.of(context).color,
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Center(
                                child: Text("${controller.data[index].name}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              )),
                              Text(
                                "${controller.data[index].format}",
                                style: TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        HomeController.to.countdownController
                            .setTimer(controller.data[index].value.toInt());
                        controller.changeSleepIndex(index, true);
                        Get.back();
                      },
                    );
                  },
                  itemCount: controller.data.length,
                ),
              )
            ],
          );
        },
        init: HomeController.to,
        id: 'sleep_index',
      ),
    );
  }
}
