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
    return Obx(() => controller.isLogin.value ? _buildLoginView() : _buildNoLoginView());
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
              SliverToBoxAdapter(
                child: CachedNetworkImage(imageUrl: controller.userProfile.value.profile.avatarUrl),
              )
            ],
          ),
        ));
  }

}
