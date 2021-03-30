import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/pages/top/top_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopView extends GetView<TopController> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child:Obx(()=> SmartRefresher(
          controller: controller.refreshController,
          header:  WaterDropMaterialHeader(
            color: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onRefresh: () => controller.getData(forcedRefresh: true),
          child: CustomScrollView(
            slivers: [
              controller.soaring.length > 0 ? buildBigTopItem('19723756', '飙升榜', controller.soaringImageUrl, controller.soaring) : buildLoadingBigTopItem('19723756', controller.soaringImageUrl),
              controller.newSong.length > 0 ? buildBigTopItem('3779629', '新歌榜', controller.newSongImageUrl, controller.newSong) : buildLoadingBigTopItem('3779629', controller.newSongImageUrl),
              controller.hotSong.length > 0 ?  buildBigTopItem('3778678', '热歌榜', controller.hotSongImageUrl, controller.hotSong) : buildLoadingBigTopItem('3778678', controller.hotSongImageUrl),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Text(
                    "其他榜单",
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return InkWell(
                          child: Wrap(
                            children: [
                              Hero(
                                tag: '${controller.otherTops[index].id}',
                                child: Center(
                                  child: Card(
                                    // margin: EdgeInsets.all(0),
                                    child: CachedNetworkImage(
                                      height: 110.0,
                                      width: 110.0,
                                      fit: BoxFit.fill,
                                      imageUrl: '${controller.otherTops[index].picUrl}',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                                child: Text(controller.otherTops[index].name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                              )
                            ],
                          ),
                          onTap: () {
                            Get.toNamed('/sheet', arguments: {'id': controller.otherTops[index].id, 'name': controller.otherTops[index].name, 'imageUrl': '${controller.otherTops[index].picUrl}'});
                          });
                    },
                    childCount: controller.otherTops.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: .8,
                  ))
            ],
          ))),
    );
  }

  Widget buildBigTopItem(id, name, imageUrl, data) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          child: InkWell(
              child: Container(
                height: 120.0,
                child: Row(
                  children: [
                    Hero(
                        tag: id,
                        child: CachedNetworkImage(
                          height: 120.0,
                          width: 120.0,
                          fit: BoxFit.cover,
                          imageUrl: imageUrl,
                        )),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                    Expanded(
                        child:ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 40.0,
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: '${data[index].name}',
                                      style: TextStyle(color: Theme.of(Get.context).bottomAppBarColor, fontSize: 14, height: 1.5, textBaseline: TextBaseline.alphabetic),
                                      // recognizer: _tapRecognizer
                                    ),
                                    TextSpan(
                                      text: ' - ${data[index].ar[0].name}',
                                      style: TextStyle(color: Colors.grey[500], fontSize: 12, height: 1.5, textBaseline: TextBaseline.alphabetic),
                                    ),
                                  ])),
                            );
                          },
                          itemCount: data.length,
                          padding: EdgeInsets.all(0),
                        ))
                  ],
                ),
              ),
              onTap: () => Get.toNamed('/sheet', arguments: {'id': id, 'name': name, 'imageUrl': imageUrl})),
        ),
      ),
    );
  }

  Widget buildLoadingBigTopItem(id, imageUrl) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          child: Container(
            height: 120.0,
            child: Row(
              children: [
                Hero(
                    tag: id,
                    child: CachedNetworkImage(
                      height: 120.0,
                      width: 120.0,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                    )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: const PlaceholderLines(
                    lineHeight: 10.0,
                    count: 3,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
