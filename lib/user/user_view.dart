import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/user/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildLoginView());
  }

  ///展示我的歌单
  Widget _buildLoginView() {
    return Obx(() => ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: SmartRefresher(
            enablePullUp: false,
            controller: controller.refreshController,
            onRefresh: () => controller.onReady(),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return controller.playList.length > 0 ? _buildUserSheetItem(index) : _loadUserSheetView();
                    },
                    childCount: controller.playList.length > 0 ? controller.playList.length : 15,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  ///歌单itemView
  Widget _buildUserSheetItem(index) {
    return Slidable(
      key: Key("${controller.playList[index].id}"),
      controller: controller.slidableController,
      actionExtentRatio: .25,
      child: InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 12.0),
                child: Hero(
                  tag: "${controller.playList[index].id}",
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(4.0)),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      width: 48,
                      height: 48,
                      imageUrl: "${controller.playList[index].coverImgUrl}?param=200y200",
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
                    child: Text(controller.playList[index].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0)),
                  ),
                  Container(
                    height: 25,
                    alignment: Alignment.centerLeft,
                    child: Text("${controller.playList[index].trackCount}首单曲", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                  )
                ],
              )),
            ],
          ),
        ),
        onTap: () {
          Get.toNamed("/sheet", arguments: {"id": controller.playList[index].id, "name": controller.playList[index].name, "imageUrl": "${controller.playList[index].coverImgUrl}?param=300y300"});
        },
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: '修改',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => {},
        ),
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {},
        ),
      ],
    );
  }

  ///歌单加载中View
  Widget _loadUserSheetView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 12.0),
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(.6), borderRadius: BorderRadius.circular(6.0)),
            child: Center(
              child: Icon(
                Icons.photo_size_select_actual,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Expanded(
              child: PlaceholderLines(
            lineHeight: 10.0,
            count: 2,
          )),
        ],
      ),
    );
  }
}
