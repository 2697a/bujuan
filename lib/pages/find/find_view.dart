import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/over_scroll.dart';
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
          child: Obx(()=>SmartRefresher(
            enablePullUp: false,
            controller: controller.refreshController,
            child: CustomScrollView(
              slivers: [
                // SliverToBoxAdapter(
                //   child: Padding(padding: EdgeInsets.only(left: 12.0,top: 16.0,bottom: 3.0),child: Text("你好,",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),),
                // ),
                // SliverToBoxAdapter(
                //   child: Padding(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 3),child: Text("总有些惊喜的奇遇",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),),
                // ),
                // SliverToBoxAdapter(
                //   child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 25.0),child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         width: 50,
                //         height: 50,
                //         decoration: BoxDecoration(
                //             color: Color.fromRGBO(66, 153, 244, .6),
                //             borderRadius: BorderRadius.circular(50.0)
                //         ),
                //         child: IconButton(icon: Icon(Icons.today,color: Colors.white,), onPressed: ()=>controller.goToTodayMusic()),
                //       ),
                //       Container(
                //         width: 50,
                //         height: 50,
                //         decoration: BoxDecoration(
                //             color: Color.fromRGBO(234, 67, 53, .6),
                //             borderRadius: BorderRadius.circular(50.0)
                //         ),
                //         child: IconButton(icon: Icon(Icons.account_circle,color: Colors.white,), onPressed: (){}),
                //       ),
                //       Container(
                //         width: 50,
                //         height: 50,
                //         decoration: BoxDecoration(
                //             color: Color.fromRGBO(251, 188, 5, .6),
                //             borderRadius: BorderRadius.circular(50.0)
                //         ),
                //         child: IconButton(icon: Icon(Icons.account_circle,color: Colors.white,), onPressed: (){}),
                //       ),
                //       Container(
                //         width: 50,
                //         height: 50,
                //         decoration: BoxDecoration(
                //             color: Color.fromRGBO(50, 168, 83, .6),
                //             borderRadius: BorderRadius.circular(50.0)
                //         ),
                //         child: IconButton(icon: Icon(Icons.account_circle,color: Colors.white,), onPressed: (){}),
                //       ),
                //     ],
                //   ),),
                // ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                    child: Text(
                      "推荐歌单",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 6.0),child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),child: Obx(()=>DotsIndicator(
                        dotsCount: 2,
                        position: controller.currentIndexPage.value.toDouble(),
                        decorator: DotsDecorator(
                            size: const Size.square(6.0),
                            activeSize: const Size(12.0, 6.0),
                            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                            color: Colors.grey[500],
                            // Inactive color
                            activeColor: Theme.of(Get.context).accentColor),
                      ))),
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
                  )),
                ),
                SliverToBoxAdapter(
                  child: Container(
                      height: 180.0,
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: (index)=>controller.currentIndexPage.value = index,
                        itemBuilder: (context, index) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.sheet.length > 0 ? controller.sheet[index].length : 3,
                              itemBuilder: (context, index1) {
                                return controller.sheet.length > 0 ? _sheetItem(controller.sheet[index][index1]) : LoadingView.buildGridViewSheetLoadingView();
                              });
                        },
                        itemCount: controller.sheet.length > 0 ? controller.sheet.length : 1,
                      )),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                    child: Text(
                      "每日新歌",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child:SizedBox(
                //     height: 162.0,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return controller.newSong.length > 0 ? _newSongItem(controller.newSong[index]) : _loadNewSongView();
                //       },
                //       itemCount: controller.newSong.length > 0 ? controller.newSong.length : 10,
                //     ),
                //   ),
                // ),

                SliverList(delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return controller.newSong.length==0 ?LoadingView.buildNewSongLoadingView():_newSongItem(controller.newSong[index]);
                  },
                  childCount: controller.newSong.length==0 ? 10 : controller.newSong.length,
                ))
              ],
            ),
            onRefresh: () async => controller.onReady(),
          )));
    });
  }

  ///歌单itemView
  Widget _sheetItem(PersonalResult personalResult) {
    return Container(
      width: (MediaQuery.of(Get.context).size.width-10)/3,
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
            child: Container(
              width: 120,
              height: 170.0,
              child: Column(
                children: [
                  Hero(tag: '${personalResult.id}', child: CachedNetworkImage(
                    height: 120.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                    imageUrl: '${personalResult.picUrl}?param=300y300',
                  )),
                  Container(
                    height: 45.0,
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 110.0),
                    child: Text(personalResult.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w100)),
                  )
                ],
              ),
            ),
            onTap: () {
              Get.toNamed('/sheet', arguments: {'id': personalResult.id, 'name': personalResult.name, 'imageUrl': '${personalResult.picUrl}?param=300y300'});
            }
        ),
      ),
    );
  }

  ///新歌itemView
  Widget _newSongItem(NewSongResult newSongResult) {
    return InkWell(
      child: Padding(
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
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),child: Column(
                  children: [
                    Container(
                      height: 38,
                      alignment: Alignment.centerLeft,
                      child: Text('${newSongResult.name}', maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.0)),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text(newSongResult.song.artists[0].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0,color: Colors.grey[500])),
                    ),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      child: Text("时长：${BuJuanUtil.unix2TimeTo(newSongResult.song.duration)}", maxLines: 1, overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0,color: Colors.grey[500])),
                    )
                  ],
                ),)),
            IconButton(icon: Icon(Icons.more_horiz), onPressed: () {  },)
          ],
        ),
      ),
      onTap: () {},
    );
  }

}
