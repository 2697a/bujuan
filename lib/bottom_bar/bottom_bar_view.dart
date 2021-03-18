import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:bujuan/bottom_bar/lyric_view.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

typedef CallBack = void Function(double selectIndex);

class BottomBarView extends GetView<BottomBarController> {
  final Widget body;
  final WeSlideController panelController;
  final bool isShowBottom;

  BottomBarView(
      {Key key,
      @required this.panelController,
      @required this.body,
      this.isShowBottom = true});

  Widget _buildPlayView() {
    return controller.isPlay.value
        ? Scaffold(
            body: OrientationBuilder(
              builder: (context, orientation) {
                return orientation == Orientation.portrait
                    ? _buildPortraitPlayView(context)
                    : _buildLandscapePlayView(context);
              },
            ),
          )
        : Scaffold(
            body: Center(
              child: Text('aa bb aa'),
            ),
          );
  }

  ///竖屏播放界面
  Widget _buildPortraitPlayView(context) {
    return Obx(() => Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Get.statusBarHeight / 2),
            ),
            Text(
              controller.song.value.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Text(
              controller.song.value.artist,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(230.0)),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                width: 230.0,
                height: 230.0,
                imageUrl: '${controller.song.value.iconUri}?param=500y500',
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            LyricView(
              lyric: controller.lyric.value.lrc.lyric,
              pos: controller.playPos.value,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            Text('${controller.playPos}'),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.format_list_bulleted_outlined,
                    ),
                    onPressed: () {}),
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

  ///横屏播放界面
  Widget _buildLandscapePlayView(context) {
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
                          '${controller.song.value.iconUri}?param=500y500',
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
                  Obx(() => LyricView(
                        lyric: controller.lyric.value.lrc.lyric,
                        pos: controller.playPos.value,
                      )),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                ],
              ),
              flex: 1,
            )
          ],
        ));
  }

  //底部导航栏
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(Get.context).accentColor,
      unselectedItemColor: Theme.of(Get.context).bottomAppBarColor,
      backgroundColor: Theme.of(Get.context).primaryColor,
      type: BottomNavigationBarType.fixed,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      elevation: 0.0,
      iconSize: 26.0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'top'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'user'),
      ],
      onTap: (index) => controller.changeIndex(index),
      currentIndex: controller.currentIndex.value,
    );
  }

  Widget _buildPlayBarView() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(Get.context).primaryColor,
          border: Border(
              top: BorderSide(
                  color: Theme.of(Get.context).bottomAppBarColor.withAlpha(50),
                  width: .1))),
      height: 65.0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        leading: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(46.0)),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            width: 46.0,
            height: 46.0,
            imageUrl: controller.isPlay.value
                ? '${controller.song.value.iconUri}?param=100y100'
                : 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffront%2F342%2Fw700h442%2F20190321%2FxqrY-huqrnan7527352.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,'
                    '10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1617447095&t=49ad10b2c81c151cfa993b98ace7f6f1',
          ),
        ),
        title: Text(
          controller.isPlay.value ? '${controller.song.value.title}' : '七里香',
          style: TextStyle(fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
            controller.isPlay.value ? '${controller.song.value.artist}' : '周杰伦',
            style: TextStyle(fontSize: 14.0, color: Colors.grey[400])),
        trailing: Wrap(
          children: [
            IconButton(
                icon: Icon(controller.playState.value == PlayState.PLAYING
                    ? Icons.pause
                    : Icons.play_arrow),
                onPressed: () => controller.playOrPause(),
                color: Theme.of(Get.context).bottomAppBarColor),
            IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () => controller.skipToNext(),
                color: Theme.of(Get.context).bottomAppBarColor),
          ],
        ),
        onTap: () => panelController.show(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: AnnotatedRegion(
            child: WeSlide(
              controller: panelController,
              panelMaxSize: MediaQuery.of(context).size.height,
              panelMinSize: isShowBottom ? 120.0 : 65.0,
              body: body,
              parallax: true,
              panel: _buildPlayView(),
              panelHeader: _buildPlayBarView(),
              footer: isShowBottom ? _buildBottomNavigationBar() : Container(),
            ),
            value: !Get.isDarkMode
                ? SystemUiOverlayStyle.light.copyWith(
                    systemNavigationBarColor: lightTheme.primaryColor,
                  )
                : SystemUiOverlayStyle.dark.copyWith(
                    systemNavigationBarColor: darkTheme.primaryColor,
                  ),
          ),
        ));
  }
}
