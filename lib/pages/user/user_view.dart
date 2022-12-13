import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/router.dart';
import '../home/first/first_controller.dart';
import '../home/home_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              if (controller.login.value) {
                controller.myDrawerController.open!();
                return;
              }
              AutoRouter.of(context).pushNamed(Routes.login);
            },
            icon: Obx(() => SimpleExtendedImage.avatar('${HomeController.to.login.value ? controller.userData.value.profile?.avatarUrl : ''}'))),
        title: Obx(
              () => RichText(
              text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
                TextSpan(
                    text: '${controller.login.value ? controller.userData.value.profile?.nickname : '请登录'}～',
                    style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
              ])),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: FirstController.to.getHomeBottomPadding()),
        child: Column(
          children: [
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) => _buildItem(controller.playlist[i],c),
                  itemCount: controller.playlist.length,
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Play play,BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: Row(
          children: [
            SimpleExtendedImage(
              '${play.coverImgUrl ?? ''}?param=150y150',
              width: 80.w,
              height: 80.w,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                play.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        // Get.toNamed(Routes.playlist, arguments: play);
        context.router.push(const PlayList().copyWith(args: play));
      },
    );
  }
}
