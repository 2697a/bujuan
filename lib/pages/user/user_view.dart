import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../routes/router.dart';
import '../home/home_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leadingWidth: 110.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
              padding: EdgeInsets.all(0.1.w),
              onPressed: () {
                if (controller.loginStatus.value) {
                  HomeController.to.myDrawerController.open!();
                  return;
                }
                AutoRouter.of(context).pushNamed(Routes.login);
              },
              icon: Obx(() => AnimatedScale(
                scale: 1+(controller.op.value*.06),
                duration: const Duration(milliseconds: 120),
                child: Lottie.asset(
                  'assets/lottie/personal_character.json',
                  width: 85.w,
                ),
              ))),
        ),
        title: Obx(
              () => InkWell(
            child: AnimatedOpacity(
              opacity: controller.op.value,
              duration: const Duration(milliseconds: 100),
              child: RichText(
                  text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
                    TextSpan(
                        text: '${controller.loginStatus.value ? controller.userData.value.profile?.nickname : '请登录'}～',
                        style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
                  ])),
            ),
            onTap: () {
              if (!controller.loginStatus.value) {
                AutoRouter.of(context).pushNamed(Routes.login);
              }
            },
          ),
        ),
        actions: [IconButton(onPressed: () {
          AutoRouter.of(context).pushNamed(Routes.search);
        }, icon: const Icon(TablerIcons.search))],
      ),
      body: SingleChildScrollView(
        controller: controller.userScrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildMeInfo(context),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
            _buildSheet(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSheet(context) {
    return Obx(() => Visibility(
          visible: controller.loginStatus.value,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.userItems
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (!controller.loginStatus.value) {
                                      return;
                                    }
                                    AutoRouter.of(context).pushNamed(e.routes ?? '');
                                  },
                                  icon: Icon(e.iconData),
                                  iconSize: 52.w,
                                ),
                                Text(
                                  e.title,
                                  style: TextStyle(fontSize: 26.sp),
                                )
                              ],
                            ))
                        .toList(),
                  ),
                ),
                StickyHeader(
                  header: _buildHeader('创建的歌单', context),
                  content: Obx(() => SizedBox(
                        height: (750.w - 120.w) / 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (c, i) =>
                              _buildItem((controller.playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).toList()[i], c),
                          itemCount: (controller.playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).length,
                        ),
                      )),
                ),
                StickyHeader(
                  header: _buildHeader('收藏的歌单', context),
                  content: Obx(() => ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 120.w,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (c, i) =>
                            _buildItem1((controller.playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).toList()[i], c),
                        itemCount: (controller.playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).length,
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildHeader(String title, context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(colors: controller.colors.map((e) => Theme.of(context).scaffoldBackgroundColor.withOpacity(e)).toList()),
      // ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6.w)),
            width: 10.w,
            height: 10.w,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 6.w)),
          Text(
            title,
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(.8)),
          ),
          // Icon(Icons.keyboard_arrow_right_outlined,color: Colors.black87.withOpacity(.6))
        ],
      ),
    );
  }

  Widget _buildMeInfo(context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
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
          ],
        ),
      ),
      onTap: () {
        if (controller.loginStatus.value) {
          return;
        }
        AutoRouter.of(context).pushNamed(Routes.login);
      },
    );
  }

  Widget _buildItem(Play play, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 18.w),
        height: (750.w - 120.w) / 3,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SimpleExtendedImage(
              '${play.coverImgUrl ?? ''}?param=400y400',
              width: (750.w - 120.w) / 3,
              height: (750.w - 120.w) / 3,
              borderRadius: BorderRadius.circular(25.w),
            ),
            Container(
              height: 90.w,
              width: (750.w - 120.w) / 3,
              color: Theme.of(context).bottomAppBarColor.withOpacity(.8),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    play.name ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 26.sp),
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 2.w)),
                  Text(
                    '${play.trackCount ?? 0} 首',
                    style: TextStyle(fontSize: 22.sp, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () => context.router.push(const PlayListView().copyWith(args: play)).then((value) {}),
    );
    // return ListTile(
    //   dense: true,
    //   contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    //   leading: SimpleExtendedImage(
    //     '${play.coverImgUrl ?? ''}?param=200y200',
    //     width: 80.w,
    //     height: 80.w,
    //   ),
    //   title: Text(play.name ?? ''),
    //   subtitle: Text('${play.trackCount ?? 0} 首'),
    //   onTap: () {
    //     context.router.push(const PlayList().copyWith(args: play));
    //   },
    // );
  }

  Widget _buildItem1(Play play, BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            SimpleExtendedImage(
              '${play.coverImgUrl ?? ''}?param=200y200',
              width: 85.w,
              height: 85.w,
              borderRadius: BorderRadius.circular(16.w),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    play.name ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                  Text(
                    '${play.trackCount ?? 0} 首',
                    style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () => context.router.push(const PlayListView().copyWith(args: play)),
    );
  }
}

class UserItem {
  String title;
  IconData iconData;
  String? routes;

  UserItem(this.title, this.iconData, {this.routes});
}
