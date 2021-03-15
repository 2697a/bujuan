
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/global/global_state_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindView extends GetView<FindController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => StateView(controller.loadState.value, widget: _buildFindView()),
    ));
  }

  Widget _buildFindView() {
    return OrientationBuilder(builder: (context, orientation) {
      return Obx(()=>SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: controller.refreshController,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: InkWell(
                child: Hero(
                    tag: "today",
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.0),
                            height: 120.0,
                            child: Image.asset("assets/images/today.png"),
                          ),
                          Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "每日推荐",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                    height: 120,
                                    alignment: Alignment.bottomRight,
                                    width: double.infinity,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          BuJuanUtil.dateToString(DateTime.now(),2),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,color: Theme.of(context).accentColor),
                                        ),
                                        Text(
                                          BuJuanUtil.dateToString(DateTime.now(),1),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Theme.of(context).accentColor),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )),
                onTap: () => Get.toNamed("/today"),
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 1.5)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.portrait, size: 32)),
                  IconButton(icon: Icon(Icons.portrait, size: 32)),
                  IconButton(icon: Icon(Icons.portrait, size: 32)),
                  IconButton(icon: Icon(Icons.portrait, size: 32)),
                ],
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 1.5)),
            SliverToBoxAdapter(
              child: Container(
                height: 200.0,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 4.0,left: 3.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => DotsIndicator(
                          dotsCount: 2,
                          position: controller.currentIndexPage.value.toDouble(),
                          decorator: DotsDecorator(
                              size: const Size.square(6.0),
                              activeSize: const Size(12.0, 6.0),
                              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                              color: Colors.grey[500],
                              // Inactive color
                              activeColor: Theme.of(Get.context).accentColor),
                        )),
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "更多 >>",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[500],fontSize: 12.0),
                            ),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 6.0)),
                    Expanded(
                        child: PageView(
                          onPageChanged: (index) => controller.currentIndexPage.value = index,
                          children: [
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, //每行三列
                                    childAspectRatio: .6),
                                itemCount: controller.result.sublist(0, 3).length,
                                itemBuilder: (context, index) {
                                  return _sheetItem(controller.result.sublist(0, 3)[index]);
                                }),
                            GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, //每行三列
                                    childAspectRatio: .6),
                                itemCount: controller.result.sublist(3, 6).length,
                                itemBuilder: (context, index) {
                                  return _sheetItem(controller.result.sublist(3, 6)[index]);
                                }),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 2)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 2.0,vertical: 0.0),
                    leading: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        width: 48,
                        height: 48,
                        imageUrl: "${controller.newSong[index].picUrl}?param=150y150",
                      ),
                    ),
                    subtitle: Text(controller.newSong[index].song.artists[0].name),
                    title: Text(controller.newSong[index].name),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                    onTap: () {},
                  );
                },
                childCount: controller.newSong == null ? 0 : controller.newSong.length,
              ),
            )
          ],
        ),
        onRefresh: () async => controller.loadTodaySheet(),
      ));
    });
  }

  Widget _sheetItem(PersonalResult personalResult) {
    return Wrap(
      children: [
        InkWell(
            child: Hero(
              tag: "${personalResult.id}",
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(6.0)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  height: 120.0,
                  width: 120.0,
                  fit: BoxFit.cover,
                  imageUrl: "${personalResult.picUrl}?param=300y300",
                ),
              ),
            ),
            onTap: () {
              Get.toNamed("/sheet", arguments: {"id": personalResult.id, "name": personalResult.name, "imageUrl": "${personalResult.picUrl}?param=300y300"});
            }),
        Padding(padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 3),child: Text(personalResult.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0)),)
      ],
    );
  }
}
