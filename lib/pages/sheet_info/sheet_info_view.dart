import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/pages/sheet_info/sheet_info_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SheetInfoView extends GetView<SheetInfoController> {
  @override
  Widget build(BuildContext context) {
    return _buildSheetView();
  }

  Widget _buildSheetView() {
    return PlayWidgetView(_buildContent());
  }

  Widget _buildContent() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Obx(() => ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: SmartRefresher(
                  header: WaterDropMaterialHeader(
                    color: Theme.of(context).accentColor,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onRefresh: () => controller.getSheetInfo(forcedRefresh: true),
                  controller: controller.refreshController,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        elevation: 0.0,
                        floating: true,
                        pinned: true,
                        title: Text('${Get.arguments['name']}'),
                        expandedHeight: 220.0,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 6.0),
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Row(
                                  children: [
                                    Hero(
                                        tag: '${Get.arguments['id']}',
                                        child: Card(
                                          child: CachedNetworkImage(
                                            width: 150.0,
                                            height: 150.0,
                                            fit: BoxFit.fitWidth,
                                            imageUrl:
                                                '${Get.arguments['imageUrl']}',
                                          ),
                                        )),
                                    Expanded(
                                        child: controller.result.value != null
                                            ? Container(
                                                child: ListTile(
                                                  title: Text(
                                                    '${controller.result.value.creator.nickname}',
                                                    style: TextStyle(
                                                        color: Theme.of(
                                                                Get.context)
                                                            .accentColor),
                                                  ),
                                                  subtitle: Text(
                                                    '${controller.result.value.creator.signature}',
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                child: PlaceholderLines(
                                                  count: 4,
                                                  lineHeight: 10.0,
                                                  maxWidth: 0.9,
                                                  minWidth: 0.6,
                                                  align: TextAlign.left,
                                                  color: Colors.grey[400],
                                                ),
                                              ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Obx(() => controller.result.value != null
                            ? Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      Text(controller.result.value != null
                                          ? '${controller.result.value.trackCount}首'
                                          : ''),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.0)),
                                      Text(controller.result.value != null
                                          ? '${controller.result.value.subscribedCount ~/ 1000}k收藏'
                                          : ''),
                                      Expanded(child: Container()),
                                      IconButton(
                                          icon: Obx(()=>Icon(
                                            Icons.favorite,
                                            color: controller.sub.value
                                                ? Colors.red
                                                : Colors.grey,
                                          )),
                                          onPressed: () =>
                                              controller.likeOrUnLikeSheet()),
                                      IconButton(
                                          icon: Icon(Icons.message_outlined),
                                          onPressed: () {
                                            Get.toNamed('/music_talk',
                                                arguments: {'music': controller.result.value.id,'type':2,'iconUrl':controller.result.value.coverImgUrl,'title':controller.result.value.name});
                                          }),
                                      IconButton(
                                          icon: Icon(Icons.play_arrow),
                                          onPressed: () =>
                                              controller.playSong(0))
                                    ],
                                  ),
                                ),
                              )
                            : Container()),
                      ),
                      _buildSheetListView()
                    ],
                  ),
                )))
            : Obx(() => Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Text('${Get.arguments['name']}'),
                  ),
                  body: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Hero(
                                tag: '${Get.arguments['id']}',
                                child: Card(
                                  child: CachedNetworkImage(
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.fitWidth,
                                    imageUrl: '${Get.arguments['imageUrl']}',
                                  ),
                                )),
                            Expanded(
                                child: controller.result.value != null
                                    ? Container(
                                        child: ListTile(
                                          title: Text(
                                            '${controller.result.value.creator.nickname}',
                                            style: TextStyle(
                                                color: Theme.of(Get.context)
                                                    .accentColor),
                                          ),
                                          subtitle: Text(
                                            '${controller.result.value.creator.signature}',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: PlaceholderLines(
                                          count: 4,
                                          lineHeight: 10.0,
                                          maxWidth: 0.9,
                                          minWidth: 0.6,
                                          align: TextAlign.left,
                                          color: Colors.grey[400],
                                        ),
                                      ))
                          ],
                        ),
                      )),
                      Expanded(
                          child: ScrollConfiguration(
                        behavior: OverScrollBehavior(),
                        child: CustomScrollView(
                          slivers: [_buildSheetListView()],
                        ),
                      ))
                    ],
                  ),
                ));
      },
    );
  }

  Widget _buildSheetListView() {
    return SliverFixedExtentList(
      itemExtent: 60.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return controller.result.value == null
              ? LoadingView.buildGeneralLoadingView()
              : InkWell(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          height: 50.0,
                          alignment: Alignment.center,
                          constraints:
                              BoxConstraints(maxWidth: 40, minHeight: 30.0),
                          child: Text(
                            '${index + 1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[500]),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 25,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  controller.result.value.tracks[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16.0)),
                            ),
                            Container(
                              height: 25,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  controller
                                      .result.value.tracks[index].ar[0].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey[500])),
                            )
                          ],
                        )),
                        IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey[500],
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  onTap: () => controller.playSong(index),
                );
        },
        childCount: controller.result.value == null
            ? 20
            : controller.result.value.tracks.length,
      ),
    );
  }
}
