import 'package:bujuan/entity/user_dj.dart';
import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/pages/radio/radio_controller.dart';
import 'package:bujuan/pages/sheet_info/head.dart';
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
            header: WaterDropMaterialHeader(
              color: Theme.of(Get.context).accentColor,
              backgroundColor: Theme.of(Get.context).primaryColor,
            ),
            footer: ClassicFooter(),
            onRefresh: () => controller.getUserDjSubList(),
            onLoading: () => controller.getUserDjSubList(false),
            child: CustomScrollView(slivers: [
               const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Text(
                    "电台推荐",
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                      minHeight: 180.0,
                      maxHeight: 180.0,
                      child: Obx(() => ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemExtent:
                              (MediaQuery.of(Get.context).size.width - 10) / 3,
                          itemCount: controller.recommend.length > 0
                              ? controller.recommend.length
                              : 6,
                          itemBuilder: (context, index) {
                            return controller.recommend.length > 0
                                ? _sheetItem(controller.recommend[index])
                                : LoadingView.buildGridViewSheetLoadingView();
                          })))),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 10.0),
                  child: Text(
                    "我订阅的电台",
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                                    child:Card(
                                      child: CachedNetworkImage(
                                        width: 42,
                                        height: 42,
                                        imageUrl:
                                        '${controller.list[index].picUrl}?param=100y100',
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

  ///歌单itemView15556333717
  Widget _sheetItem(DjRadios djRadios) {
    return Container(
      width:(MediaQuery.of(Get.context).size.width - 10) / 3,
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
            child: Container(
              width: 120,
              height: 170.0,
              child: Column(
                children: [
                  CachedNetworkImage(
                    height: 120.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                    imageUrl: '${djRadios.picUrl}?param=300y300',
                  ),
                  Container(
                    height: 45.0,
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 110.0),
                    child: Text(djRadios.rcmdtext,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0)),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.toNamed('/radio_detail',
                  arguments: {'radio': djRadios});
            }),
      ),
    );
  }
}
