import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/pages/radio/radio_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/widget/state_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RadioView extends GetView<RadioController> {
  @override
  Widget build(BuildContext context) {
    return PlayWidgetView(
      _buildRadio(),
      appBar: AppBar(
        title: Text('我订阅的电台'),
      ),
    );
  }

  Widget _buildRadio() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: Obx(() => StateView(
          controller.loadState.value,
          SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: controller.openLoad.value,
            header:  WaterDropMaterialHeader(
              color: Theme.of(Get.context).accentColor,
              backgroundColor: Theme.of(Get.context).primaryColor,
            ),
            footer: ClassicFooter(),
            onRefresh: ()=>controller.getUserDjSubList(),
            onLoading: ()=>controller.getUserDjSubList(false),
            child: CustomScrollView(slivers: [
              SliverFixedExtentList(
                itemExtent: 60.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return controller.list.length > 0
                        ? InkWell(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 12.0),
                                    child: Hero(
                                      tag: '${controller.list[index].id}',
                                      child: Card(
                                        child: CachedNetworkImage(
                                          width: 42,
                                          height: 42,
                                          imageUrl:
                                              '${controller.list[index].picUrl}?param=100y100',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Container(
                                        height: 25,
                                        alignment: Alignment.centerLeft,
                                        child: Text(controller.list[index].name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16.0)),
                                      ),
                                      Container(
                                        height: 25,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            '${controller.list[index].programCount}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500])),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            onTap: () => Get.toNamed('/radio_detail',
                                arguments: {'radio': controller.list[index]}),
                          )
                        : LoadingView.buildGeneralLoadingView();
                  },
                  childCount:
                      controller.list.length > 0 ? controller.list.length : 20,
                ),
              )
            ]),
          ))),
    );
  }
}
