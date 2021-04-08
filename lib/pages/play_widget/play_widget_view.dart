import 'dart:ui';

import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_view/lyric_view.dart';
import 'package:bujuan/pages/play_view/play_list_view.dart';
import 'package:bujuan/widget/bottom_bar/bottom_navy_bar.dart';
import 'package:bujuan/widget/bottom_bar/custom_navigation_bar_item.dart';
import 'package:bujuan/widget/bottom_bar/custome_navigation_bar.dart';
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

  PlayWidgetView(this.widget, {this.isHome = false});

  @override
  Widget build(BuildContext context) {
    controller.addSliderListener(weSlideController);
    return Scaffold(
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
                      BorderRadiusDirectional.circular(30.0)),
                  clipBehavior: Clip.antiAlias,
                  child: HomeController.to.userProfileEntity.value != null
                      ? CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: HomeController.to.userProfileEntity.value
                        .profile.avatarUrl,
                    height: 34.0,
                    width: 34.0,
                  )
                      : Image.asset('assets/images/logo.png',
                      width: 34.0, height: 34.0),
                ))),
            onPressed: () => HomeController.to.goToProfile(),
          ),
          title: Text('Bujuan'),
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
        appBarHeight: 56.0 + MediaQueryData.fromWindow(window).padding.top,
        controller: weSlideController,
        panelMaxSize: MediaQuery.of(Get.context).size.height,
        panelMinSize: controller.scroller.value ? 62.0 : 118.0,
        overlayColor: Colors.transparent,
                body: widget,
                parallax: true,
                panel: _buildPlayView(),
                panelHeader: _buildBottomBar(),
                footer: controller.scroller.value
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
    );
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
            child: Obx(() => CachedNetworkImage(
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
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? _buildPortrait()
                  : _buildLandscape();
            },
          ),
        ),
        onWillPop: () async {
          if (weSlideController.isOpened) {
            weSlideController?.hide();
            return false;
          }
          return true;
        });
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
            Expanded(
                child: Column(
              children: [
                Obx(() => Text(controller.song.value.title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)),
                Obx(() => Text(
                      controller.song.value.artist,
                      style: TextStyle(color: Colors.grey[600]),
                    )),
              ],
            )),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
        _buildMusicCover(MediaQuery.of(Get.context).size.width / 1.45),
        Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
        controller.lyric.value == null || controller.lyric.value.lrc == null
            ? Expanded(child: Container())
            : Obx(() => LyricView(
                  lyric: controller.lyric.value.lrc.lyric,
                  pos: controller.playPos.value,
                )),
        Padding(padding: EdgeInsets.symmetric(vertical: 18.0)),
        // Text(定时
        //   '${BuJuanUtil.unix2Time(controller.playPos.value)} : ${BuJuanUtil.unix2Time(controller.song.value.duration ~/ 1000)}',
        //   style:
        //   TextStyle(color: Theme.of(Get.context).accentColor,fontWeight: FontWeight.bold,fontSize: 20.0),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.favorite_border,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  size: 32.0,
                ),
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
                  controller.playMode.value == 1
                      ? Icons.repeat
                      : controller.playMode.value == 2
                          ? Icons.repeat_one
                          : Icons.shuffle,
                ),
                onPressed: () => controller.changePlayMode())),
          ],
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                onPressed: () => weSlideController.hide()),
            Expanded(child: Container()),
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
            IconButton(
                icon: Icon(
                  Icons.sms_outlined,
                ),
                onPressed: () {
                  if (!Get.find<HomeController>().login.value) {
                    Get.find<HomeController>().goToLogin();
                  } else {
                    Get.toNamed('/music_talk',
                        arguments: {'music': controller.song.value});
                  }
                }),
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
              Expanded(
                  child: Center(
                child: _buildMusicCover(
                    MediaQuery.of(Get.context).size.height / 1.5),
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
                  IconButton(
                      icon: Icon(
                        Icons.shuffle,
                      ),
                      onPressed: () {}),
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
              Obx(() => Text(
                    controller.song.value.title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Obx(() => Text(
                    controller.song.value.artist,
                    style: TextStyle(color: Colors.grey[600]),
                  )),
              controller.lyric.value.lrc == null ||
                      controller.lyric.value == null
                  ? Expanded(child: Container())
                  : Obx(() => LyricView(
                        lyric: controller.lyric.value.lrc.lyric,
                        pos: controller.playPos.value,
                      )),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            ],
          ),
          flex: 1,
        )
      ],
    );
  }

  Widget _buildMusicCover(size) {
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
                      borderRadius: BorderRadiusDirectional.circular(230.0)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: controller.song.value.musicId != '-99'
                        ? '${controller.song.value.iconUri}?param=500y500'
                        : '${controller.song.value.iconUri}',
                  ),
                ),
              ],
            ),
          ),
          // onChange: (v) => controller.seekTo(v.toInt()),
          onChangeEnd: (v) => controller.seekTo(v.toInt()),
        ));
  }



  //底部导航栏

  Widget _buildBottomNavigationBar() {

    // return TitledBottomNavigationBar(
    //   enableShadow: false,
    //     currentIndex: HomeController.to.currentIndex.value, // Use this to update the Bar giving a position
    //     onTap: (index){
    //       HomeController.to.changeIndex(index);
    //     },
    //     items: [
    //       TitledNavigationBarItem(title: Text('Home'), icon: Icons.home,backgroundColor: Theme.of(Get.context).primaryColor),
    //       TitledNavigationBarItem(title: Text('Bag'), icon: Icons.card_travel,backgroundColor: Theme.of(Get.context).primaryColor),
    //       TitledNavigationBarItem(title: Text('Orders'), icon: Icons.shopping_cart,backgroundColor: Theme.of(Get.context).primaryColor),
    //       TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person_outline,backgroundColor: Theme.of(Get.context).primaryColor),
    //       TitledNavigationBarItem(title: Text('Profile'), icon: Icons.person_outline,backgroundColor: Theme.of(Get.context).primaryColor),
    //     ]
    // );
    // return BottomNavyBar(
    //   showElevation: false,
    //   backgroundColor: Theme.of(Get.context).primaryColor,
    //   selectedIndex: HomeController.to.currentIndex.value,
    //   onItemSelected: (index) => HomeController.to.changeIndex(index),
    //   items: [
    //     BottomNavyBarItem(
    //       textAlign: TextAlign.center,
    //       icon: Icon(Icons.apps),
    //       title: Text('Home'),
    //       activeColor: Colors.red,
    //     ),
    //     BottomNavyBarItem(
    //         icon: Icon(Icons.people),
    //         title: Text('Users'),
    //         activeColor: Colors.purpleAccent
    //     ),
    //     BottomNavyBarItem(
    //         icon: Icon(Icons.message),
    //         title: Text('Messages'),
    //         activeColor: Colors.pink
    //     ),
    //     BottomNavyBarItem(
    //         icon: Icon(Icons.settings),
    //         title: Text('Settings'),
    //         activeColor: Colors.blue
    //     ),
    //   ],
    // );
    return CustomNavigationBar(
      iconSize: 28.0,
      selectedColor: Theme.of(Get.context).accentColor,
      strokeColor: Theme.of(Get.context).accentColor.withOpacity(.3),
      unSelectedColor: Theme.of(Get.context).bottomAppBarColor,
      elevation: 0.0,
      backgroundColor: Theme.of(Get.context).canvasColor,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.person_pin),
          selectedIcon: Icon(Icons.person_pin_rounded),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          selectedIcon: Icon(Icons.lightbulb),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.whatshot_outlined),
          selectedIcon: Icon(Icons.whatshot),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.music_note_outlined),
          selectedIcon: Icon(Icons.music_note),
        ),
      ],
      currentIndex: HomeController.to.currentIndex.value,
      onTap: (index) {
        HomeController.to.changeIndex(index);
      },
    );
  }
}
