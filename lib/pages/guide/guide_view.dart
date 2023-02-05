import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'dart:math' as math;

import '../../common/bujuan_audio_handler.dart';

class GuideView extends StatefulWidget {
  const GuideView({Key? key}) : super(key: key);

  @override
  State<GuideView> createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> with WidgetsBindingObserver {
  bool gradient = true;
  bool left = true;
  PageController pageController = PageController();
  Timer? _timer;
  List<BottomData>? _bottomData;

  // final BujuanAudioHandler audioServeHandler = GetIt.instance<BujuanAudioHandler>();
  bool openSetting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        gradient = !gradient;
        left = !left;
      });
    });
    _bottomData = [
      BottomData('是否开启全局动效', '请观看上方图片示例', onCancel: () {
        _jumpToPage(2);
        StorageUtil().setBool(leftImageSp, false);
      }, onOk: () {
        _jumpToPage(2);
        StorageUtil().setBool(leftImageSp, true);
      }),
      BottomData('是否开启播放页渐变', '请观看上方图片示例', onCancel: () {
        _jumpToPage(3);
        StorageUtil().setBool(gradientBackgroundSp, false);
      }, onOk: () {
        _jumpToPage(3);
        StorageUtil().setBool(gradientBackgroundSp, true);
      }),
      BottomData('为了更好的为您服务', '请授予通知权限', onCancel: () {
        AutoRouter.of(context).replaceNamed(Routes.home);
      }, onOk: () async {
        //开始获取通知权限
        NotificationPermissions.getNotificationPermissionStatus().then((value) {
          if (value == PermissionStatus.denied || value == PermissionStatus.unknown) {
            NotificationPermissions.requestNotificationPermissions(openSettings: value == PermissionStatus.denied);
            openSetting = true;
          } else {
            AutoRouter.of(context).replaceNamed(Routes.home);
          }
        });
      }, cancelTitle: '不授权', okTitle: '授权'),
    ];
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && openSetting) {
      NotificationPermissions.getNotificationPermissionStatus().then((value) {
        if (value == PermissionStatus.denied || value == PermissionStatus.unknown) {
          WidgetUtil.showToast('您未开启通知权限哦');
        } else {
          if (mounted) AutoRouter.of(context).replaceNamed(Routes.home);
        }
      });
    }
  }

  void _jumpToPage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildWelcome(),
              _buildLeftImage(context),
              _buildSolidBackground(context),
              _buildNotification(),
            ],
          ),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: IconButton(
                onPressed: () {
                  AutoRouter.of(context).replaceNamed(Routes.home);
                  StorageUtil().setBool(leftImageSp, true);
                  StorageUtil().setBool(gradientBackgroundSp, true);
                },
                icon: Text(
                  'Skip',
                  style: TextStyle(fontSize: 32.sp),
                )),
          ))
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('assets/lottie/personal_character.json', width: 750.w / 1.6),
        Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
        Text(
          '欢迎来到不倦',
          style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10.w)),
        Text(
          '使用之前请先设置个性化功能',
          style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.normal),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 30.w)),
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xfffac9c9), Theme.of(context).primaryColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(5.w),
            ),
            width: 530.w,
            height: 86.w,
            child: Text(
              '前往设置',
              style: TextStyle(fontSize: 32.sp, color: Colors.white),
            ),
          ),
          onTap: () => pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.linear),
        ),
      ],
    );
  }

  Widget _buildLeftImage(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SafeArea(
            child: Transform.rotate(
          angle: -math.pi / 20,
          child: Container(
            margin: EdgeInsets.only(top: 100.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(25.w),
            ),
            width: 750.w / 2,
            height: 750.w,
          ),
        )),
        SafeArea(
            child: Transform.rotate(
          angle: -math.pi / 40,
          child: Container(
            margin: EdgeInsets.only(top: 100.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(25.w),
            ),
            width: 750.w / 2,
            height: 750.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Opacity(
                  opacity: left ? 1 : 0,
                  child: IconButton(
                    iconSize: 180.w,
                    icon: Opacity(
                        opacity: .9,
                        child: Lottie.asset(
                          'assets/lottie/vr_animation.json',
                          width: 180.w,
                          height: 180.w,
                          // fit: BoxFit.fitWidth,
                          // filterQuality: FilterQuality.low,
                        )),
                    onPressed: () {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 180.w,
                            height: 20.w,
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.w),
                            width: 80.w,
                            height: 20.w,
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 180.w,
                            height: 20.w,
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.w),
                            width: 80.w,
                            height: 20.w,
                            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
        _buildItem(_bottomData![0])
      ],
    );
  }

  Widget _buildSolidBackground(context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SafeArea(
            child: Transform.rotate(
          angle: -math.pi / 20,
          child: Container(
            margin: EdgeInsets.only(top: 100.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [!gradient ? Theme.of(context).primaryColor.withOpacity(.5) : const Color(0xfffac9c9).withOpacity(.5), Theme.of(context).primaryColor.withOpacity(.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(25.w),
            ),
            width: 750.w / 2,
            height: 750.w,
          ),
        )),
        SafeArea(
            child: Transform.rotate(
          angle: -math.pi / 40,
          child: Container(
            margin: EdgeInsets.only(top: 100.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [!gradient ? Theme.of(context).primaryColor : const Color(0xfffac9c9), Theme.of(context).primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(25.w),
            ),
            width: 750.w / 2,
            height: 750.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 180.w,
                  height: 180.w,
                  color: Theme.of(context).cardColor.withOpacity(.2),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        color: Theme.of(context).cardColor.withOpacity(.2),
                      ),
                      Container(
                        width: 40.w,
                        height: 40.w,
                        color: Theme.of(context).cardColor.withOpacity(.2),
                      ),
                      Container(
                        width: 20.w,
                        height: 20.w,
                        color: Theme.of(context).cardColor.withOpacity(.2),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 30.w))
              ],
            ),
          ),
        )),
        _buildItem(_bottomData![1])
      ],
    );
  }

  Widget _buildNotification() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SafeArea(
            child: Transform.rotate(
          angle: -math.pi / 20,
          child: Container(
            margin: EdgeInsets.only(top: 100.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(155, 178, 255, .3),
              borderRadius: BorderRadius.circular(25.w),
            ),
            width: 750.w / 2,
            height: 750.w,
          ),
        )),
        SafeArea(
            child: Transform.rotate(
          angle: -math.pi / 40,
          child: Container(
            margin: EdgeInsets.only(top: 100.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(155, 178, 255, 1),
              borderRadius: BorderRadius.circular(25.w),
            ),
            width: 750.w / 2,
            height: 750.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/notification_request.json', width: 750.w / 3),
                Padding(padding: EdgeInsets.symmetric(vertical: 15.w)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 46.w,
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 20.w)),
                    Container(
                      width: 100.w,
                      height: 46.w,
                      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
        _buildItem(_bottomData![2])
      ],
    );
  }

  Widget _buildItem(BottomData data) {
    return Positioned(
      bottom: 70.w,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              data.title,
              style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.w)),
            Text(
              data.subTitle,
              style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.normal),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 30.w)),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.2),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    width: 230.w,
                    height: 80.w,
                    child: Text(
                      data.cancelTitle ?? '关闭',
                      style: TextStyle(fontSize: 32.sp),
                    ),
                  ),
                  onTap: () {
                    data.onCancel?.call();
                  },
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 40.w)),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color(0xfffac9c9), Theme.of(context).primaryColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    width: 230.w,
                    height: 80.w,
                    child: Text(
                      data.okTitle ?? '开启',
                      style: TextStyle(fontSize: 32.sp, color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    data.onOk?.call();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomData {
  String title;
  String subTitle;
  String? cancelTitle;
  String? okTitle;
  VoidCallback? onCancel;
  VoidCallback? onOk;

  BottomData(this.title, this.subTitle, {this.cancelTitle, this.okTitle, this.onCancel, this.onOk});
}
