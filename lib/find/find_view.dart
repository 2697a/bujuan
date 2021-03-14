import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/global/global_state_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: controller.refreshController,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: InkWell(
                child: Hero(tag: "today", child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadiusDirectional.circular(8.0)),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        height: 120.0,
                        child: Image.asset("assets/images/today.png"),
                      ),
                      Expanded(child: Text("每日推荐",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),))
                    ],
                  ),
                )),
                onTap: ()=>Get.toNamed("/today"),
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return InkWell(
                      child: Hero(
                        tag: "${controller.result[index].id}",
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(8.0)),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                "${controller.result[index].picUrl}?param=300y300",
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.toNamed("/sheet", arguments: {
                          "id": controller.result[index].id,
                          "name": controller.result[index].name,
                          "imageUrl":
                              "${controller.result[index].picUrl}?param=300y300"
                        });
                      });
                },
                childCount: controller.result.length, //内部控件数量
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1),
            )
          ],
        ),
        onRefresh: () async => controller.loadTodaySheet(),
      );
    });
  }
}
