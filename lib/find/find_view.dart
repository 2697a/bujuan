import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/global/global_state_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../over_scroll.dart';

class FindView extends GetView<FindController> {
  @override
  Widget build(BuildContext context) {
    return _buildFindView();
  }

  Widget _buildFindView() {
    return OrientationBuilder(builder: (context, orientation) {
      return Obx(() => ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: SmartRefresher(
            enablePullUp: false,
            controller: controller.refreshController,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: InkWell(
                    child: Hero(
                        tag: 'today',
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                          clipBehavior: Clip.antiAlias,
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
                                    child: Text(
                                      '每日推荐',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                    height: 120,
                                    alignment: Alignment.bottomRight,
                                    width: double.infinity,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          BuJuanUtil.dateToString(DateTime.now(), 2),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Theme.of(context).accentColor),
                                        ),
                                        Text(
                                          BuJuanUtil.dateToString(DateTime.now(), 1),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Theme.of(context).accentColor),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        )),
                    onTap: () => controller.goToTodayMusic(),
                  ),
                ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),

                SliverToBoxAdapter(
                  child: Container(
                    height: 200.0,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 4.0, left: 3.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),child: DotsIndicator(
                              dotsCount: 2,
                              position: controller.currentIndexPage.value.toDouble(),
                              decorator: DotsDecorator(
                                  size: const Size.square(6.0),
                                  activeSize: const Size(12.0, 6.0),
                                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                                  color: Colors.grey[500],
                                  // Inactive color
                                  activeColor: Theme.of(Get.context).accentColor),
                            ),)),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [Text('更多', style: TextStyle(color: Colors.grey[500], fontSize: 12.0)), Icon(Icons.keyboard_arrow_right, size: 18.0, color: Colors.grey[500])],
                                ),
                              ),
                              onTap: () =>Get.toNamed('/sheet_classify'),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 6.0)),
                        Expanded(
                            child: PageView.builder(
                          onPageChanged: (index) => controller.currentIndexPage.value = index,
                          itemBuilder: (context, index) {
                            return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3, //每行三列
                                    childAspectRatio: 1),
                                itemCount: controller.result.length > 0 ? controller.result[index].length : 3,
                                itemBuilder: (context, index1) {
                                  return controller.result.length > 0 ? _sheetItem(controller.result[index][index1]) : LoadingView.buildGridViewSheetLoadingView();
                                });
                          },
                          itemCount: controller.result.length > 0 ? controller.result.length : 1,
                        )),
                      ],
                    ),
                  ),
                ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: 110.0,
                //     child: Row(
                //       children: [
                //         Expanded(
                //             child: InkWell(
                //               child: Stack(
                //                 children: [
                //                   Container(
                //                     height: 110.0,
                //                     child: Card(
                //                       shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                //                       clipBehavior: Clip.antiAlias,
                //                       child: Image.asset(
                //                         'assets/images/p_two.png',
                //                         height: 100,
                //                         width: double.infinity,
                //                         fit: BoxFit.cover,
                //                       ),
                //                     ),
                //                   ),
                //                   Positioned(
                //                     bottom: 5.0,
                //                     right: 8.0,
                //                     child: Container(
                //                       padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                //                       decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(10.0)),
                //                       child: Text(
                //                         'radio',
                //                         style: TextStyle(color: Colors.white),
                //                       ),
                //                     ),
                //                   )
                //                 ],
                //               ),
                //               onTap: () {},
                //             )),
                //         Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                //         Expanded(
                //           child: InkWell(
                //             child: Stack(
                //               children: [
                //                 Container(
                //                   height: 110.0,
                //                   child: Card(
                //                     shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                //                     clipBehavior: Clip.antiAlias,
                //                     child: Image.asset(
                //                       'assets/images/fm.png',
                //                       height: 100,
                //                       width: double.infinity,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   bottom: 6.0,
                //                   right: 8.0,
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
                //                     decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(10.0)),
                //                     child: Text(
                //                       'fm',
                //                       style: TextStyle(color: Colors.white),
                //                     ),
                //                   ),
                //                 )
                //               ],
                //             ),
                //             onTap: () {},
                //           ),
                //           flex: 2,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return controller.newSong.length > 0 ? _newSongItem(index) : _loadNewSongView();
                    },
                    childCount: controller.newSong.length > 0 ? controller.newSong.length : 10,
                  ),
                ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 20.0))
              ],
            ),
            onRefresh: () async => controller.loadTodaySheet(),
          )));
    });
  }

  ///歌单itemView
  Widget _sheetItem(PersonalResult personalResult) {
    return Wrap(
      children: [
        InkWell(
            child: Hero(
              tag: '${personalResult.id}',
              child: Center(child: Card(
                // margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  height: 110.0,
                  width: 110.0,
                  fit: BoxFit.cover,
                  imageUrl: '${personalResult.picUrl}?param=180y180',
                ),
              ),),
            ),
            onTap: () {
              Get.toNamed('/sheet', arguments: {'id': personalResult.id, 'name': personalResult.name, 'imageUrl': '${personalResult.picUrl}?param=300y300'});
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
          child: Text(personalResult.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
        )
      ],
    );
  }

  ///新歌itemView
  Widget _newSongItem(index) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 12.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(4.0)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  width: 48,
                  height: 48,
                  imageUrl: '${controller.newSong[index].picUrl}?param=130y130',
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text(controller.newSong[index].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0)),
                ),
                Container(
                  height: 25,
                  alignment: Alignment.centerLeft,
                  child: Text('${controller.newSong[index].song.artists[0].name}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0, color: Colors.grey[500])),
                )
              ],
            )),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey[500],
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  ///新歌加载中View
  Widget _loadNewSongView() {
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
