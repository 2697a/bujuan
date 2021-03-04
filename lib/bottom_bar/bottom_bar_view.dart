import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
typedef CallBack = void Function(int selectIndex);
class BottomBarView extends GetView<BottomBarController> {
  final Widget body;
  final CallBack callBack;
  final PanelController panelController;

  BottomBarView({Key key, @required this.panelController, @required this.body,this.callBack});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SlidingUpPanel(
          controller: panelController,
          onPanelClosed: (){
            if(callBack!=null) callBack(1);
          },
          onPanelOpened: (){
            if(callBack!=null) callBack(0);
          },
          body: body,
          minHeight: 68.0,
          maxHeight: Get.height,
          color: Theme.of(context).primaryColor,
          panel: _buildPlayView(),
          collapsed: _buildPlayBarView(),
        ));
  }

  Widget _buildPlayView() {
    return Center(
      child: controller.isPlay.value
          ? CachedNetworkImage(
              imageUrl: "${controller.song.value.al.picUrl}?param=500y500",
            )
          : Text("暂无"),
    );
  }

  Widget _buildPlayBarView() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 68.0,
        child: Row(
          children: [
            CachedNetworkImage(
              width: 46.0,
              height: 46.0,
              imageUrl: controller.isPlay.value?"${controller.song.value.al.picUrl}?param=200y200":"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffront%2F342%2Fw700h442%2F20190321%2FxqrY-huqrnan7527352.jpg&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,"
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
                      child: Text(controller.isPlay.value?"${controller.song.value.name}":"七里香",style: TextStyle(fontSize: 16.0),overflow: TextOverflow.ellipsis,),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 25.0,
                      child: Text(controller.isPlay.value?"${controller.song.value.ar[0].name}":"周杰伦",style: TextStyle(fontSize: 14.0)),
                    )
                  ],
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.play_arrow), onPressed: (){}),
            IconButton(icon: Icon(Icons.skip_next), onPressed: (){}),
          ],
        ),
      ),
      onTap: ()=>panelController?.open(),
    );
  }
}
