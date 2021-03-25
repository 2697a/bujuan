import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return _buildLoginView();
  }

  ///展示我的歌单
  Widget _buildLoginView() {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: Obx(()=>SmartRefresher(
        enablePullUp: false,
        controller: controller.refreshController,
        onRefresh: () => controller.onReady(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ListTile(
                title: Text('云盘'),
                subtitle: Text('data'),
                onTap: ()=>Get.toNamed('/cloud'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return controller.lovePlayList.length > 0 ? _buildUserSheetItem(controller.lovePlayList[index]) : _loadUserSheetView();
                },
                childCount: controller.lovePlayList.length > 0 ? controller.lovePlayList.length : 1,
              ),
            ),
            SliverToBoxAdapter(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 6.0),
              child: Text('我创建的'),
            ),),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return controller.createPlayList.length > 0 ? _buildUserSheetItem(controller.createPlayList[index]) : _loadUserSheetView();
                },
                childCount: controller.createPlayList.length > 0 ? controller.createPlayList.length : 5,
              ),
            ),
            SliverToBoxAdapter(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 6.0),
              child: Text('我收藏的'),
            ),),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return controller.collectPlayList.length > 0 ? _buildUserSheetItem(controller.collectPlayList[index]) : _loadUserSheetView();
                },
                childCount: controller.collectPlayList.length > 0 ? controller.collectPlayList.length : 5,
              ),
            ),
          ],
        ),
      )),
    );
  }

  ///歌单itemView
  Widget _buildUserSheetItem(UserOrderPlaylist userOrderPlaylist) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 12.0),
              child: Hero(
                tag: '${userOrderPlaylist.id}',
                child: Card(
                  child: CachedNetworkImage(
                    width: 48,
                    height: 48,
                    imageUrl: '${userOrderPlaylist.coverImgUrl}?param=200y200',
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
                      child: Text(userOrderPlaylist.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0)),
                    ),
                    Container(
                      height: 25,
                      alignment: Alignment.centerLeft,
                      child: Text('${userOrderPlaylist.trackCount}首', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                    )
                  ],
                )),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed('/sheet', arguments: {'id': userOrderPlaylist.id, 'name': userOrderPlaylist.name, 'imageUrl': '${userOrderPlaylist.coverImgUrl}?param=300y300'});
      },
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
