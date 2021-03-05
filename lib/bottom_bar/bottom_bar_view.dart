import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

typedef CallBack = void Function(double selectIndex);

class BottomBarView extends GetView<BottomBarController> {
  final Widget body;
  final CallBack callBack;
  final PanelController panelController;
  final bool isShowBottom;

  BottomBarView({Key key, @required this.panelController, @required this.body, this.callBack, this.isShowBottom = true}) {
    controller.setPanelController(panelController);
  }

  @override
  Widget build(BuildContext context) {
    var a = 1.0;
    return Obx(() => SlidingUpPanel(
          controller: panelController,
          // onPanelSlide: (value) {
          //   if (value < 0.1) value = 0.0;
          //   var parse = double.parse(value.toStringAsFixed(1));
          //   if(parse!=a){
          //     if (callBack != null) callBack(value);
          //   }
          //   a = parse;
          // },
          body: Padding(
            padding: EdgeInsets.only(bottom: isShowBottom ? 126.0 : 68.0),
            child: body,
          ),
          minHeight: isShowBottom ? 126.0 : 68.0,
          maxHeight: Get.height,
          color: Theme.of(context).primaryColor,
          panel: _buildPlayView(),
          collapsed: _buildPlayBarView(context),
        ));
  }

  Widget _buildPlayView() {
    return controller.isPlay.value
        ? Scaffold(
            body: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 15.0),),
                Center(
                  child: CachedNetworkImage(
                    width: 200.0,
                    height: 200.0,
                    imageUrl: "${controller.song.value.al.picUrl}?param=500y500",
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Widget _buildBottomNavigationBar(context) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).bottomAppBarColor,
      backgroundColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      elevation: 0.0,
      iconSize: 26.0,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "top"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "user"),
      ],
      onTap: (index) => controller.changeIndex(index),
      currentIndex: controller.currentIndex.value,
    );
  }

  Widget _buildPlayBarView(context) {
    return Container(
      color:Theme.of(context).primaryColor,
      child: Column(
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 68.0,
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: 46.0,
                    height: 46.0,
                    imageUrl: controller.isPlay.value
                        ? "${controller.song.value.al.picUrl}?param=300y300"
                        : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffront%2F342%2Fw700h442%2F20190321%2FxqrY-huqrnan7527352.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,"
                        "10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1617447095&t=49ad10b2c81c151cfa993b98ace7f6f1",
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 25.0,
                            child: Text(
                              controller.isPlay.value ? "${controller.song.value.name}" : "七里香",
                              style: TextStyle(fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 25.0,
                            child: Text(controller.isPlay.value ? "${controller.song.value.ar[0].name}" : "周杰伦", style: TextStyle(fontSize: 14.0,color: Colors.grey[400])),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.play_arrow), onPressed: () {}),
                  IconButton(icon: Icon(Icons.skip_next), onPressed: () {}),
                ],
              ),
            ),
            onTap: () => panelController?.open(),
          ),
          Offstage(
            offstage: !isShowBottom,
            child: _buildBottomNavigationBar(context),
          )
        ],
      ),
    );
  }
}
