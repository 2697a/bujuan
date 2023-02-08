import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/icon.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../routes/router.dart';
import '../../routes/router.gr.dart';
import '../../widget/draggable_home.dart';
import '../home/home_controller.dart';
import '../home/view/panel_view.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible:  HomeController.to.loginStatus.value == LoginStatus.login,
          replacement: ClassStatelessWidget(child: _buildMeInfo(context)),
          child: OrientationBuilder(builder: (c, o) {
            return Visibility(
              visible: o == Orientation.portrait,
              replacement: const SizedBox.shrink(),
              child: DraggableHome(
                physics: const ClampingScrollPhysics(),
                backgroundColor: Colors.transparent,
                appBarColor: Colors.transparent,
                curvedBodyRadius: 0,
                leading: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: IconButton(
                      padding: EdgeInsets.all(0.1.w),
                      onPressed: () {
                        if ( HomeController.to.loginStatus.value == LoginStatus.login) {
                          HomeController.to.myDrawerController.open!();
                          return;
                        }
                        AutoRouter.of(context).pushNamed(Routes.login);
                      },
                      icon: Obx(() => SimpleExtendedImage.avatar(
                        HomeController.to.userData.value.profile?.avatarUrl ?? '',
                            width: 80.w,
                          ))),
                ),
                headerExpandedHeight: .23,
                centerTitle: false,
                actions: [IconButton(onPressed: () => HomeController.to.changePlayUi(context), icon: const Icon(TablerIcons.search))],
                alwaysShowLeadingAndAction: true,
                title: ClassStatelessWidget(
                    child: RichText(
                        text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
                  TextSpan(text: '${ HomeController.to.userData.value.profile?.nickname}～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
                ]))),
                body: [
                  GridView.count(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    //设置内边距
                    //设置横向间距
                    crossAxisSpacing: 40,
                    //设置主轴间距
                    mainAxisSpacing: 10,
                    children: controller.userItems
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
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
                  ClassWidget(child: _buildHeader('喜欢的音乐', context)),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        children: [
                          Obx(() => SimpleExtendedImage(
                            '${controller.play.value.coverImgUrl ?? ''}?param=200y200',
                            width: 110.w,
                            height: 110.w,
                            borderRadius: BorderRadius.circular(100.w),
                          )),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.play.value.name ?? '',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                                    Text(
                                      '${controller.play.value.trackCount ?? 0} 首',
                                      style: TextStyle(fontSize: 26.sp),
                                    )
                                  ],
                                )),
                              )),
                        ],
                      ),
                    ),
                    onTap: (){
                      context.router.push(const PlayListView().copyWith(args: controller.play.value));
                    },
                  ),
                  ClassWidget(child: _buildHeader('我的歌单', context)),
                  Obx(() => ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (content, index) => _buildItem1(controller.playlist[index], context, index),
                    itemCount: controller.playlist.length,
                    itemExtent: 120.w,
                  )),
                ],
                headerWidget: _buildMeInfo(context),
              ),
            );
          }),
        ));
  }


  Widget _buildHeader(String title, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
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
            style: TextStyle(fontSize: 32.sp,  color: Theme.of(context).iconTheme.color),
          ),
          // Icon(Icons.keyboard_arrow_right_outlined,color: Colors.black87.withOpacity(.6))
        ],
      ),
    );
  }

  Widget _buildMeInfo(context) {
    return SafeArea(
        child: GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 30.w, top: 30.w,right: 30.w),
        margin: EdgeInsets.only(bottom: 16.w, top: 120.w),
        height: 240.w,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedScale(scale: 1.13,duration:Duration.zero,child: SvgPicture.asset(AppIcons.meTop,height: 240.w,fit: BoxFit.fitHeight,),),
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi', style: TextStyle(fontSize: 52.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
                  Obx(() => Text('${ HomeController.to.loginStatus.value == LoginStatus.login ?  HomeController.to.userData.value.profile?.nickname : '请登录'}～',
                      style: TextStyle(fontSize: 52.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if ( HomeController.to.loginStatus.value == LoginStatus.login) {
          return;
        }
        AutoRouter.of(context).pushNamed(Routes.login);
      },
    ));
  }

  Widget _buildItem(Play play, BuildContext context, index) {
    return ClassStatelessWidget(
        child: InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
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
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor.withOpacity(.8),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.w), bottomRight: Radius.circular(25.w))),
              height: 90.w,
              width: (750.w - 120.w) / 3,
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
              '${play.coverImgUrl ?? ''}?param=120y120',
              width: 80.w,
              height: 80.w,
              borderRadius: BorderRadius.circular(40.w),
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
                    style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                  Text(
                    '${play.trackCount ?? 0} 首',
                    style: TextStyle(fontSize: 26.sp),
                  )
                ],
              ),
            )),
            IconButton(onPressed: (){}, icon: const Icon(TablerIcons.dots),iconSize: 36.w,)
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
