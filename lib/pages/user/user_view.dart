import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:sticky_headers/sticky_headers.dart';
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
        leading: Obx(() => IconButton(
            onPressed: () {
              if (controller.loginStatus.value) {
                controller.myDrawerController.open!();
                return;
              }
              AutoRouter.of(context).pushNamed(Routes.login);
            },
            icon: SimpleExtendedImage.avatar('${controller.loginStatus.value ? controller.userData.value.profile?.avatarUrl : ''}'))),
        title: Obx(
          () => AnimatedOpacity(
            opacity: controller.op.value,
            duration: const Duration(milliseconds: 100),
            child: RichText(
                text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
              TextSpan(
                  text: '${controller.loginStatus.value ? controller.userData.value.profile?.nickname : '请登录'}～',
                  style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
            ])),
          ),
        ),
        actions: [
          Obx(() => AnimatedOpacity(opacity: controller.op.value,
            duration: const Duration(milliseconds: 100),child: IconButton(onPressed: (){}, icon: const Icon(TablerIcons.search)),))
        ],
      ),
      body: SingleChildScrollView(
        controller: controller.userScrollController,
        padding: EdgeInsets.only(bottom: FirstController.to.getHomeBottomPadding()),
        child: Column(
          children: [
            _buildMeInfo(context),
            StickyHeader(header: _buildHeader('创建的歌单', context), content: Obx(() => ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) => _buildItem((controller.playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).toList()[i], c),
              itemCount: (controller.playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).length,
            )),),
            StickyHeader(header: _buildHeader('收藏的歌单', context), content: Obx(() => ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) => _buildItem((controller.playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).toList()[i], c),
              itemCount: (controller.playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).length,
            )),),
          ],
        ),
      ),
    );
  }

Widget _buildHeader(String title,context){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6.w)
            ),
            width: 10.w,
            height: 10.w,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 6.w)),
          Expanded(child: Text(title,style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(.8)),)),
          // Icon(Icons.keyboard_arrow_right_outlined,color: Colors.black87.withOpacity(.6))
        ],
      ),
    );
}

  Widget _buildMeInfo(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 30.w),
      height: 240.w,
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi', style: TextStyle(fontSize: 52.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
              Obx(() => Text('${controller.loginStatus.value ? controller.userData.value.profile?.nickname : '请登录'}～',
                  style: TextStyle(fontSize: 52.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
            ],
          )),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(25.w)),
            height: 180.w,
            width: 80.w,
            child: const Icon(
              TablerIcons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(Play play, BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: SimpleExtendedImage(
        '${play.coverImgUrl ?? ''}?param=200y200',
        width: 80.w,
        height: 80.w,
      ),
      title: Text(play.name ?? ''),
      subtitle: Text('${play.trackCount ?? 0} 首'),
      onTap: () {
        context.router.push(const PlayList().copyWith(args: play));
      },
    );
  }
}
