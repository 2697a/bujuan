import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/icon.dart';
import 'package:bujuan/pages/play_list/playlist_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import '../../common/constants/key.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../routes/router.dart';
import '../../routes/router.gr.dart' as gr;
import '../../widget/draggable_home.dart';
import '../home/home_controller.dart';
import '../home/view/panel_view.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Home.to.landscape ? const UserViewL() : const UserViewP();
  }
}

class UserViewP extends GetView<UserController> {
  const UserViewP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Obx(() => Visibility(
        visible: Home.to.loginStatus.value == LoginStatus.login,
        replacement: _buildMeInfo(context),
        child: Obx(() => Visibility(
              visible: !controller.loading.value,
              replacement: const LoadingView(),
              child: DraggableHome(
                physics: const ClampingScrollPhysics(),
                backgroundColor: Colors.transparent,
                appBarColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(Home.to.background.value.isEmpty ? 1 : 0),
                curvedBodyRadius: 0,
                leading: IconButton(
                    onPressed: () {
                      if (Home.to.loginStatus.value == LoginStatus.login) {
                        Home.to.myDrawerController.open!();
                        return;
                      }
                      AutoRouter.of(context).pushNamed(Routes.login);
                    },
                    icon: Obx(() => SimpleExtendedImage.avatar(
                          Home.to.userData.value.profile?.avatarUrl ?? '',
                          width: 80.w,
                        ))),
                headerExpandedHeight: .23,
                centerTitle: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        AutoRouter.of(context).pushNamed(Routes.search);
                      },
                      icon: const Icon(TablerIcons.search))
                ],
                alwaysShowLeadingAndAction: true,
                title: ClassStatelessWidget(
                    child: RichText(
                        text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Hi  ', children: [
                  TextSpan(text: '${Home.to.userData.value.profile?.nickname}～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
                ]))),
                body: [
                  GridView.count(
                    padding: const EdgeInsets.only(top: 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: .75,
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
                                      Home.to.audioServeHandler.setRepeatMode(AudioServiceRepeatMode.all);
                                      Home.to.audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
                                      Home.to.box.put(repeatModeSp, AudioServiceRepeatMode.all.name);
                                      Home.to.getFmSongList();
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
                  _buildHeader('喜欢的音乐', context),
                  ListTile(
                    leading: Obx(() => SimpleExtendedImage(
                          '${controller.play.value.coverImgUrl ?? ''}?param=200y200',
                          width: 100.w,
                          height: 100.w,
                          borderRadius: BorderRadius.circular(100.w),
                        )),
                    title: Obx(() => Text(
                          controller.play.value.name ?? '',
                          maxLines: 1,
                          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                        )),
                    subtitle: Obx(() => Text(
                          '${controller.play.value.trackCount ?? 0} 首',
                          style: TextStyle(fontSize: 26.sp),
                        )),
                    onTap: () => context.router.push(const gr.PlayListView().copyWith(args: controller.play.value)),
                  ),
                  _buildHeader('我的歌单', context),
                  Obx(() => ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        shrinkWrap: true,
                        addRepaintBoundaries: false,
                        addAutomaticKeepAlives: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (content, index) => PlayListItem(index: index, play: controller.playlist[index]),
                        itemCount: controller.playlist.length,
                        itemExtent: 120.w,
                      )),
                ],
                headerWidget: _buildMeInfo(context),
              ),
            ))));
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
            style: TextStyle(fontSize: 32.sp, color: Theme.of(context).iconTheme.color),
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
        padding: EdgeInsets.only(left: 30.w, top: 30.w, right: 30.w),
        margin: EdgeInsets.only(bottom: 16.w, top: 120.w),
        height: 240.w,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedScale(
              scale: 1.13,
              duration: Duration.zero,
              child: SvgPicture.asset(
                AppIcons.meTop,
                height: 240.w,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi', style: TextStyle(fontSize: 52.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
                  Obx(() => Text('${Home.to.loginStatus.value == LoginStatus.login ? Home.to.userData.value.profile?.nickname : '请登录'}～',
                      style: TextStyle(fontSize: 52.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (Home.to.loginStatus.value == LoginStatus.login) {
          return;
        }
        AutoRouter.of(context).pushNamed(Routes.login);
      },
    ));
  }
}

class UserViewL extends GetView<UserController> {
  const UserViewL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Obx(() => Visibility(
        visible: Home.to.loginStatus.value == LoginStatus.login,
        replacement: _buildMeInfo(context),
        child: Obx(() => Visibility(
              visible: !controller.loading.value,
              replacement: const LoadingView(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Obx(() => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Theme.of(context).scaffoldBackgroundColor,
                              controller.palette.value.lightMutedColor?.color.withOpacity(.3) ?? Colors.transparent,
                              controller.palette.value.dominantColor?.color.withOpacity(.3) ?? Colors.transparent
                            ]),
                            borderRadius: BorderRadius.circular(25.w),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 80.w),
                          height: 500.w,
                          child: Row(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 40.w)),
                              InkWell(
                                child: SimpleExtendedImage(
                                  '${controller.play.value.coverImgUrl ?? ''}?param=500y500',
                                  width: 400.w,
                                  height: 400.w,
                                  borderRadius: BorderRadius.circular(25.w),
                                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(25.w), bottomLeft: Radius.circular(25.w)),
                                ),
                                onTap: () {
                                  context.router.push(const gr.PlayListView().copyWith(args: controller.play.value));
                                },
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Text(
                                        controller.play.value.name ?? '',
                                        style: TextStyle(color: controller.palette.value.dominantColor?.bodyTextColor, fontSize: 54.sp),
                                      )),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: controller.userItems
                                        .map((e) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if ((e.routes ?? '') == 'playFm') {
                                                      Home.to.audioServeHandler.setRepeatMode(AudioServiceRepeatMode.all);
                                                      Home.to.audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
                                                      Home.to.box.put(repeatModeSp, AudioServiceRepeatMode.all.name);
                                                      Home.to.getFmSongList();
                                                      return;
                                                    }
                                                    AutoRouter.of(context).pushNamed(e.routes ?? '');
                                                  },
                                                  icon: Icon(e.iconData),
                                                  color: controller.palette.value.dominantColor?.bodyTextColor,
                                                  iconSize: 72.w,
                                                ),
                                                Text(
                                                  e.title,
                                                  style: TextStyle(fontSize: 26.sp, color: controller.palette.value.dominantColor?.bodyTextColor),
                                                )
                                              ],
                                            ))
                                        .toList(),
                                  )
                                ],
                              )),
                            ],
                          ),
                        )),
                  ),
                  // SliverPadding(
                  //   padding: EdgeInsets.symmetric(horizontal: 80.w),
                  //   sliver: SliverToBoxAdapter(
                  //     child: Container(
                  //       padding: EdgeInsets.all(20.w),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           InkWell(
                  //             child: Obx(() => Column(
                  //                   children: [
                  //                     SimpleExtendedImage(
                  //                       '${controller.play.value.coverImgUrl ?? ''}?param=500y500',
                  //                       width: 340.w,
                  //                       height: 340.w,
                  //                       borderRadius: BorderRadius.all(Radius.circular(25.w)),
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.only(top: 10.w),
                  //                       child: Obx(() => Text(
                  //                             controller.play.value.name ?? '',
                  //                             style: TextStyle(fontSize: 36.sp),
                  //                           )),
                  //                     ),
                  //                   ],
                  //                 )),
                  //             onTap: () {
                  //               context.router.push(const gr.PlayListView().copyWith(args: controller.play.value));
                  //             },
                  //           ),
                  //           Expanded(
                  //               child: GridView.count(
                  //             padding: const EdgeInsets.only(top: 0),
                  //             shrinkWrap: true,
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             crossAxisCount: 4,
                  //             //设置内边距
                  //             //设置横向间距
                  //             //设置主轴间距
                  //             mainAxisSpacing: 10,
                  //             children: controller.userItems
                  //                 .map((e) => Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.center,
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         IconButton(
                  //                           onPressed: () {
                  //                             if ((e.routes ?? '') == 'playFm') {
                  //                               Home.to.audioServeHandler.setRepeatMode(AudioServiceRepeatMode.all);
                  //                               Home.to.audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
                  //                               Home.to.box.put(repeatModeSp, AudioServiceRepeatMode.all.name);
                  //                               Home.to.getFmSongList();
                  //                               return;
                  //                             }
                  //                             AutoRouter.of(context).pushNamed(e.routes ?? '');
                  //                           },
                  //                           icon: Icon(e.iconData),
                  //                           iconSize: 72.w,
                  //                         ),
                  //                         Text(
                  //                           e.title,
                  //                           style: TextStyle(fontSize: 26.sp),
                  //                         )
                  //                       ],
                  //                     ))
                  //                 .toList(),
                  //           ))
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: _buildHeader('我的歌单', context),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 80.w),
                    sliver: SliverGrid.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, childAspectRatio: .75, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
                        itemBuilder: (context, index) => _buildItem(controller.playlist[index], context),
                        itemCount: controller.playlist.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false),
                  ),
                ],
                // child: Column(
                //   children: [
                //     FrameSeparateWidget(child: _buildHeader('喜欢的音乐', context)),
                //     FrameSeparateWidget(
                //         child: ListTile(
                //           leading: Obx(() => SimpleExtendedImage(
                //             '${controller.play.value.coverImgUrl ?? ''}?param=300y300',
                //             width: 100.w,
                //             height: 100.w,
                //             borderRadius: BorderRadius.circular(100.w),
                //           )),
                //           title: Obx(() => Text(
                //             controller.play.value.name ?? '',
                //             maxLines: 1,
                //             style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
                //           )),
                //           subtitle: Obx(() => Text(
                //             '${controller.play.value.trackCount ?? 0} 首',
                //             style: TextStyle(fontSize: 26.sp),
                //           )),
                //           onTap: () => context.router.push(const gr.PlayListView().copyWith(args: controller.play.value)),
                //         )),
                //     FrameSeparateWidget(child: _buildHeader('我的歌单', context)),
                //     FrameSeparateWidget(
                //         child: Obx(() => ListView.builder(
                //           padding: EdgeInsets.symmetric(horizontal: 20.w),
                //           shrinkWrap: true,
                //           addRepaintBoundaries: false,
                //           addAutomaticKeepAlives: false,
                //           physics: const NeverScrollableScrollPhysics(),
                //           itemBuilder: (content, index) => PlayListItem(index: index, play: controller.playlist[index]),
                //           itemCount: controller.playlist.length,
                //           itemExtent: 120.w,
                //         ))),
                //   ],
                // ),
              ),
            ))));
  }

  Widget _buildHeader(String title, BuildContext context, {VoidCallback? onTap}) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 30.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6.w)),
              width: 10.w,
              height: 10.w,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.w)),
            Text(
              title,
              style: TextStyle(fontSize: 34.sp, color: Theme.of(context).iconTheme.color),
            ),
          ],
        ),
      ),
      onTap: () => onTap?.call(),
    );
  }

  Widget _buildItem(Play albumModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleExtendedImage(
              '${albumModel.coverImgUrl ?? ''}?param=230y230',
              borderRadius: BorderRadius.all(Radius.circular(25.w)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                  child: Text(
                    albumModel.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => context.router.push(const gr.PlayListView().copyWith(args: albumModel)),
      ),
    );
  }

  Widget _buildMeInfo(context) {
    return SafeArea(
        child: GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 30.w, top: 30.w, right: 30.w),
        margin: EdgeInsets.only(bottom: 16.w, top: 120.w),
        height: 240.w,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedScale(
              scale: 1.13,
              duration: Duration.zero,
              child: SvgPicture.asset(
                AppIcons.meTop,
                height: 240.w,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi', style: TextStyle(fontSize: 52.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8.w)),
                  Obx(() => Text('${Home.to.loginStatus.value == LoginStatus.login ? Home.to.userData.value.profile?.nickname : '请登录'}～',
                      style: TextStyle(fontSize: 52.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        if (Home.to.loginStatus.value == LoginStatus.login) {
          return;
        }
        AutoRouter.of(context).pushNamed(Routes.login);
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
