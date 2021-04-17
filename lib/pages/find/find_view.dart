import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'find_controller.dart';

class FindView extends GetView<FindController> {
  @override
  Widget build(BuildContext context) {
    return _buildFindView();
  }

  Widget _buildFindView() {
    return OrientationBuilder(builder: (context, orientation) {
      return ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return SmartRefresher(
                header: WaterDropMaterialHeader(
                  color: Theme.of(context).accentColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                controller: controller.refreshController,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _today(),
                    ),
                    SliverPadding(padding: EdgeInsets.only(top: 12.0,left: 4.0,right: 4.0),sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      const IconData(0xe607,
                                          fontFamily: 'iconfont'),
                                      size: 32.0,
                                      color: Colors.red.withOpacity(.8),
                                    ),
                                    onPressed: () =>controller.goToFm()),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    'FM',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      const IconData(0xe680,
                                          fontFamily: 'iconfont'),
                                      size: 28.0,
                                      color: Colors.red.withOpacity(.8),
                                    ),
                                    onPressed: () => Get.toNamed('/sheet_classify')),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    '歌单',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      const  IconData(0xe684,
                                          fontFamily: 'iconfont'),
                                      size: 26.0,
                                      color: Colors.red.withOpacity(.8),
                                    ),
                                    onPressed: () =>Get.toNamed('/top')),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    '排行',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      const  IconData(0xe61f,
                                          fontFamily: 'iconfont'),
                                      size: 28.0,
                                      color: Colors.red.withOpacity(.8),
                                    ),
                                    onPressed: () => Get.toNamed('/history')),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    '歌手',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                    )),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: Text(
                          "推荐歌单",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Obx(() => DotsIndicator(
                                        dotsCount: 2,
                                        position: controller
                                            .currentIndexPage.value
                                            .toDouble(),
                                        decorator: DotsDecorator(
                                            size: const Size.square(6.0),
                                            activeSize: const Size(12.0, 6.0),
                                            activeShape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0)),
                                            color: Colors.grey[500],
                                            // Inactive color
                                            activeColor: Theme.of(Get.context)
                                                .accentColor),
                                      ))),
                              InkWell(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text('更多',
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12.0)),
                                      Icon(Icons.keyboard_arrow_right,
                                          size: 18.0, color: Colors.grey[500])
                                    ],
                                  ),
                                ),
                                onTap: () => Get.toNamed('/sheet_classify'),
                              )
                            ],
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: orientation == Orientation.portrait
                          ? Container(
                              height: 180.0,
                              child: PreloadPageView.builder(
                                controller: controller.pageController,
                                onPageChanged: (index) =>
                                    controller.currentIndexPage.value = index,
                                itemBuilder: (context, index) {
                                  return Obx(() => ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemExtent: (MediaQuery.of(Get.context)
                                                  .size
                                                  .width -
                                              10) /
                                          3,
                                      itemCount: controller.sheet.length > 0
                                          ? controller.sheet[index].length
                                          : 3,
                                      itemBuilder: (context, index1) {
                                        return controller.sheet.length > 0
                                            ? _sheetItem(
                                                controller.sheet[index][index1],
                                                orientation)
                                            : LoadingView
                                                .buildGridViewSheetLoadingView();
                                      }));
                                },
                                itemCount: controller.sheet.length > 0
                                    ? controller.sheet.length
                                    : 2,
                              ))
                          : Container(
                              height: 180.0,
                              child: GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0.0),
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6, //每行2个
                                  mainAxisSpacing: 10.0, //主轴方向间距
                                  crossAxisSpacing: 5.0, //水平方向间距
                                  childAspectRatio: .6, //纵轴缩放比例
                                ),
                                itemBuilder: (context, index) {
                                  return controller.sheet.length > 0
                                      ? _sheetItem(controller.allSheet[index],
                                          orientation)
                                      : LoadingView
                                          .buildGridViewSheetLoadingView();
                                },
                                itemCount: controller.sheet.length > 0
                                    ? controller.allSheet.length
                                    : 6,
                              )),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: Text(
                          "新歌推荐",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Obx(() => ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return controller.newSong.length == 0
                                  ? LoadingView.buildNewSongLoadingView()
                                  : _newSongItem(
                                      controller.newSong[index], index);
                            },
                            itemExtent: 110.0,
                            itemCount: controller.newSong.length == 0
                                ? 10
                                : controller.newSong.length,
                          )),
                    ),
                  ],
                ),
                onRefresh: () async =>
                    controller.loadTodaySheet(forcedRefresh: true),
              );
            },
          ));
    });
  }

  Widget _today() {
    return Hero(
        tag: 'today',
        child: Card(
          child: InkWell(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  height: 120.0,
                  child: Image.asset('assets/images/today.png'),
                ),
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: const Text(
                        '每日推荐',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      height: 120,
                      alignment: Alignment.bottomRight,
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Text(
                            BuJuanUtil.dateToString(DateTime.now(), 2),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Theme.of(Get.context).accentColor),
                          ),
                          Text(
                            BuJuanUtil.dateToString(DateTime.now(), 1),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Theme.of(Get.context).accentColor),
                          )
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
            onTap: () => controller.goToTodayMusic(),
          ),
        ));
  }

  ///歌单itemView15556333717
  Widget _sheetItem(PersonalResult personalResult, Orientation orientation) {
    return Container(
      width: orientation == Orientation.portrait
          ? (MediaQuery.of(Get.context).size.width - 10) / 3
          : (MediaQuery.of(Get.context).size.width - 10) / 6,
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
            child: Container(
              width: 120,
              height: 170.0,
              child: Column(
                children: [
                  Hero(
                      tag: '${personalResult.id}',
                      child: CachedNetworkImage(
                        height: 120.0,
                        width: 120.0,
                        fit: BoxFit.cover,
                        imageUrl: '${personalResult.picUrl}?param=300y300',
                      )),
                  Container(
                    height: 45.0,
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 110.0),
                    child: Text(personalResult.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.0)),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.toNamed('/sheet', arguments: {
                'sheet': personalResult,
              });
            }),
      ),
    );
  }

  ///新歌itemView
  Widget _newSongItem(NewSongResult newSongResult, index) {
    return InkWell(
      child: Container(
        height: 110.0,
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 6.0),
              height: 100.0,
              width: 110.0,
              child: Card(
                child: CachedNetworkImage(
                  height: 100.0,
                  width: 110.0,
                  fit: BoxFit.cover,
                  imageUrl: '${newSongResult.picUrl}?param=300y300',
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 38,
                    alignment: Alignment.centerLeft,
                    child: Text('${newSongResult.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.0)),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(newSongResult.song.artists[0].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                  ),
                  Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "时长：${BuJuanUtil.unix2TimeTo(newSongResult.song.duration)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                  )
                ],
              ),
            )),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
      ),
      onTap: () => controller.playSong(index),
    );
  }
}
