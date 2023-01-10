import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/request_widget/request_loadmore_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../routes/router.dart';
import '../../widget/app_bar.dart';
import '../home/home_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                    controller.loginStatus.value == LoginStatus.login
                        ? controller.userData.value.profile?.avatarUrl ?? ''
                        : 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202105%2F06%2F20210506002916_3ce11.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1675913899&t=7e774d368476b1959bda340aa8dadf5c',
                    width: 80.w,
                  ))),
        ),
        title: Obx(
          () => Visibility(visible: controller.loginStatus.value == LoginStatus.login,child: AnimatedOpacity(
            opacity: controller.op.value,
            duration: const Duration(milliseconds: 100),
            child: RichText(
                text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
                  TextSpan(text: '${controller.userData.value.profile?.nickname}～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
                ])),
          ),),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AutoRouter.of(context).pushNamed(Routes.search);
              },
              icon: const Icon(TablerIcons.search))
        ],
      ),
      body: Obx(() => Visibility(
            visible: controller.loginStatus.value == LoginStatus.login,
            replacement: _buildMeInfo(context),
            child: RequestLoadMoreWidget<MultiPlayListWrap2, Play>(
                refreshController: controller.refreshController,
                scrollController: controller.userScrollController,
                listKey: const ['playlist'],
                enableLoad: false,
                dioMetaData: controller.userPlayListDioMetaData(controller.userData.value.profile?.userId ?? '-1'),
                childBuilder: (List<Play> data) => SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildMeInfo(context),
                          Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
                          _buildSheet(context, data),
                        ],
                      ),
                    )),
          )),
    );
  }

  Widget _buildSheet(context, List<Play> playlist) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: controller.userItems
                  .map((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (controller.loginStatus.value != LoginStatus.login) {
                                return;
                              }
                              if ((e.routes ?? '') == 'playFm') {
                                HomeController.to.getFmSongList();
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
          _buildHeader('创建的歌单', context),
          SizedBox(
            height: (750.w - 120.w) / 3,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (c, i) => _buildItem((playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).toList()[i], c),
              itemCount: (playlist.where((element) => element.creator?.userId == controller.userData.value.profile?.userId)).length,
            ),
          ),
          _buildHeader('收藏的歌单', context),
          ListView.builder(
            shrinkWrap: true,
            itemExtent: 120.w,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (c, i) => _buildItem1((playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).toList()[i], c),
            itemCount: (playlist.where((element) => element.creator?.userId != controller.userData.value.profile?.userId)).length,
          ),
        ],
      ),
    );
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

  Widget _buildItem(Play play, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        height: (750.w - 120.w) / 3,
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
      onTap: () => context.router.push(const PlayListView().copyWith(args: play)),
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
              '${play.coverImgUrl ?? ''}?param=120y120',
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
