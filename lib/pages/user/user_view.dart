import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../routes/router.dart';
import '../../widget/app_bar.dart';
import '../home/home_controller.dart';
import '../home/view/panel_view.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leadingWidth: 110.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: IconButton(
              padding: EdgeInsets.all(0.1.w),
              onPressed: () {
                if (controller.loginStatus.value == LoginStatus.login) {
                  HomeController.to.myDrawerController.open!();
                  return;
                }
                AutoRouter.of(context).pushNamed(Routes.login);
              },
              icon: Obx(() => SimpleExtendedImage.avatar(
                    controller.userData.value.profile?.avatarUrl ?? '',
                    width: 80.w,
                  ))),
        ),
        title: ClassStatelessWidget(
            child: Obx(
          () => Visibility(
            visible: controller.loginStatus.value == LoginStatus.login,
            child: AnimatedOpacity(
              opacity: controller.op.value,
              duration: const Duration(milliseconds: 100),
              child: RichText(
                  text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
                TextSpan(text: '${controller.userData.value.profile?.nickname}～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
              ])),
            ),
          ),
        )),
        actions: [IconButton(onPressed: () => AutoRouter.of(context).pushNamed(Routes.search), icon: const Icon(TablerIcons.search))],
      ),
      body: Obx(() => Visibility(
            visible: controller.loginStatus.value == LoginStatus.login,
            replacement: ClassStatelessWidget(child: _buildMeInfo(context)),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: controller.userScrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: ClassStatelessWidget(child: _buildMeInfo(context)),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if ((controller.userItems[index].routes ?? '') == 'playFm') {
                                HomeController.to.getFmSongList();
                                return;
                              }
                              AutoRouter.of(context).pushNamed(controller.userItems[index].routes ?? '');
                            },
                            icon: Icon(controller.userItems[index].iconData),
                            iconSize: 52.w,
                          ),
                          Text(
                            controller.userItems[index].title,
                            style: TextStyle(fontSize: 26.sp),
                          )
                        ],
                      );
                    },
                    childCount: controller.userItems.length, //内部控件数量
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 45,
                    mainAxisSpacing: 10,
                    childAspectRatio: .9,
                  ),
                ),
                // SliverPadding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0),
                //   sliver: SliverGrid(
                //     delegate: SliverChildBuilderDelegate(
                //       (BuildContext context, int index) {
                //         return _buildItem(data[index], context, index);
                //       },
                //       childCount: 3, //内部控件数量
                //     ),
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       crossAxisSpacing: 5,
                //       mainAxisSpacing: 5,
                //       childAspectRatio: 1.14,
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(child: _buildHeader('我的歌单', context),),
               // SliverPadding(padding: EdgeInsets.symmetric(horizontal: 10.w),sliver:  SliverGrid(
               //   delegate: SliverChildBuilderDelegate(
               //         (BuildContext context, int index) {
               //       return _buildItem(controller.playlist[index], context, index);
               //     },
               //     childCount: controller.playlist.length, //内部控件数量
               //   ),
               //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               //     crossAxisCount: 3,
               //     crossAxisSpacing: 0,
               //     mainAxisSpacing: 10,
               //     childAspectRatio: 1.15,
               //   ),
               // ),),
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate((content, index) {
                    return Obx(() => _buildItem1(controller.playlist[index], context, index));
                  }, childCount: controller.playlist.length),
                  itemExtent: 120.w,
                ),
                // _buildSheet(context, data)
              ],
            ),
          )),
    );
  }

  Widget _buildSheet(context, List<Play> playlist) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ClassWidget(child: _buildHeader('创建的歌单', context)),
          ClassWidget(
              child: SizedBox(
            height: (750.w - 120.w) / 3,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) => _buildItem((playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).toList()[i], c, i),
              itemCount: (playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).length,
            ),
          )),
          // ClassWidget(child: _buildHeader('收藏的歌单', context)),
          ClassWidget(
              child: ListView.builder(
            shrinkWrap: true,
            itemExtent: 120.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemBuilder: (c, i) => _buildItem1((playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).toList()[i], c, i),
            itemCount: (playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).length,
          ))
        ],
      ),
    );
  }

  Widget _buildHeader(String title, context) {
    return Container(
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
        margin: EdgeInsets.only(bottom: 16.w),
        height: 240.w,
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi', style: TextStyle(fontSize: 52.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
                Obx(() => Text('${controller.loginStatus.value == LoginStatus.login ? controller.userData.value.profile?.nickname : '请登录'}～',
                    style: TextStyle(fontSize: 52.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
              ],
            )),
          ],
        ),
      ),
      onTap: () {
        if (controller.loginStatus.value == LoginStatus.login) {
          return;
        }
        AutoRouter.of(context).pushNamed(Routes.login);
      },
    );
  }

  Widget _buildItem(Play play, BuildContext context, index) {
    return ClassStatelessWidget(
        child: InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SimpleExtendedImage(
              '${play.coverImgUrl ?? ''}?param=300y300',
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
      onTap: () {
        context.router.push(const PlayListView().copyWith(args: play));
      },
    ));
  }

  Widget _buildItem1(Play play, BuildContext context, int index) {
    return ClassStatelessWidget(
        child: InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        height: 120.w,
        child: Row(
          children: [
            SimpleExtendedImage(
              '${play.coverImgUrl ?? ''}?param=80y80',
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
      onTap: () {
        context.router.push(const PlayListView().copyWith(args: play));
      },
    ));
  }
}

class UserItem {
  String title;
  IconData iconData;
  String? routes;

  UserItem(this.title, this.iconData, {this.routes});
}

class WidgetView extends StatelessWidget {
  final Widget child;

  const WidgetView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
