import 'package:bujuan/global/global_state_view.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/user/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          Get.find<HomeController>().login.value ? _buildLoginView() : _buildNoLoginView()),
    );
  }

  ///未登录的UI
  Widget _buildNoLoginView() {
    return Center(
      child: IconButton(
        icon: Icon(Icons.supervised_user_circle_outlined),
        onPressed: () => Get.find<HomeController>().goToLogin(),
      ),
    );
  }

  ///已登录的UI
  Widget _buildLoginView() {
    return Obx(() => StateView(
          controller.loadState.value,
          widget: ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
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
                                  tag: "${controller.playList[index].id}",
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadiusDirectional.circular(4.0)),
                                    clipBehavior: Clip.antiAlias,
                                    child: CachedNetworkImage(
                                      width: 48,
                                      height: 48,
                                      imageUrl:
                                      "${controller.playList[index].coverImgUrl}?param=200y200",
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
                                        child: Text(controller.playList[index].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16.0)),
                                      ),
                                      Container(
                                        height: 25,
                                        alignment: Alignment.centerLeft,
                                        child: Text("${controller.playList.length}首单曲", maxLines: 1, overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14.0,color: Colors.grey[500])),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed("/sheet", arguments: {
                          "id": controller.playList[index].id,
                          "name": controller.playList[index].name,
                          "imageUrl":
                          "${controller.playList[index].coverImgUrl}?param=300y300"
                        }),
                      );
                    },
                    childCount: controller.playList.length,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
