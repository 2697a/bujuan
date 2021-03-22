import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/global/global_loding_view.dart';
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
      return ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: Obx(()=>SmartRefresher(
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
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: 150.0,
                //     child: PageView.builder(
                //         itemBuilder: (context, index) {
                //           return controller.banner.length > 0
                //               ? Card(
                //                   // margin: EdgeInsets.all(0),
                //                   shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                //                   clipBehavior: Clip.antiAlias,
                //                   child: CachedNetworkImage(
                //                     height: 300.0,
                //                     width: 800.0,
                //                     fit: BoxFit.cover,
                //                     imageUrl: '${controller.banner[index].imageUrl}',
                //                   ),
                //                 )
                //               : Card();
                //         },
                //         itemCount: controller.banner.length > 0 ? controller.banner.length : 1,
                //         onPageChanged: (index) => controller.currentIndexPage.value = index),
                //   ),
                // ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "每日歌单",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "More >",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        onTap: () => Get.toNamed('/sheet_classify'),
                      ),
                    ],
                  ),
                ),
                SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return controller.sheet.length > 0 ? _sheetItem(controller.sheet[index]) : LoadingView.buildGridViewSheetLoadingView();
                      },
                      childCount: controller.sheet.length > 0 ? controller.sheet.length : 6,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: .75,
                    )),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "每日新歌",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                SliverToBoxAdapter(
                  child:SizedBox(
                    height: 162.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return controller.newSong.length > 0 ? _newSongItem(controller.newSong[index]) : _loadNewSongView();
                      },
                      itemCount: controller.newSong.length > 0 ? controller.newSong.length : 10,
                    ),
                  ),
                ),
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
              child: Center(
                child: Card(
                  // margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    height: 110.0,
                    width: 110.0,
                    fit: BoxFit.cover,
                    imageUrl: '${personalResult.picUrl}?param=300y300',
                  ),
                ),
              ),
            ),
            onTap: () {
              Get.toNamed('/sheet', arguments: {'id': personalResult.id, 'name': personalResult.name, 'imageUrl': '${personalResult.picUrl}?param=300y300'});
            }),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
          child: Text(personalResult.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0)),
        )
      ],
    );
  }

  ///新歌itemView
  Widget _newSongItem(NewSongResult newSongResult) {
    return Column(
      children: [
        InkWell(
            child: Hero(
              tag: '${newSongResult.id}',
              child: Center(
                child: Card(
                  // margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    height: 110.0,
                    width: 110.0,
                    fit: BoxFit.cover,
                    imageUrl: '${newSongResult.picUrl}?param=300y300',
                  ),
                ),
              ),
            ),
            onTap: () {}),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
          child: Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(maxWidth: 110.0),
            child: Text(newSongResult.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1),
          child: Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(maxWidth: 110.0),
            child: Text(newSongResult.song.artists[0].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0,color: Colors.grey[500])),
          )
        )
      ],
    );
  }

  ///新歌加载中View
  Widget _loadNewSongView() {
    return Column(
      children: [
    Center(
    child:  Container(
    width: 110.0,
      height: 110.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(6.0)
      ),
      child: Center(
        child: Icon(
          Icons.photo_size_select_actual,
          color: Colors.white,
          size: 42,
        ),
      ),
    ),
    ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
          width: 110.0,
          child: PlaceholderLines(
            lineHeight: 10.0,
            color: Colors.grey[400],
            animate: true,
            count: 2,
          ),
        )
      ],
    );
  }
}
