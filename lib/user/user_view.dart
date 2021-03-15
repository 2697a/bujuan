import 'package:bujuan/global/global_state_view.dart';
import 'package:bujuan/login/login_binding.dart';
import 'package:bujuan/login/login_view.dart';
import 'package:bujuan/user/user_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          controller.isLogin.value ? _buildLoginView() : _buildNoLoginView()),
    );
  }

  ///未登录的UI
  Widget _buildNoLoginView() {
    return Center(
      child: IconButton(
        icon: Icon(Icons.supervised_user_circle_outlined),
        onPressed: () => Get.to(() => LoginView(), binding: LoginBinding()),
      ),
    );
  }

  ///已登录的UI
  Widget _buildLoginView() {
    return Obx(() => StateView(
          controller.loadState.value,
          widget: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      leading: Hero(
                        tag: "${controller.playList[index].id}",
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(8.0)),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl:
                                "${controller.playList[index].coverImgUrl}?param=200y200",
                          ),
                        ),
                      ),
                      subtitle: Text("${controller.playList.length}首单曲",maxLines: 1,overflow: TextOverflow.ellipsis),
                      title: Text(controller.playList[index].name),
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
        ));
  }
}
