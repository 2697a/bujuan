import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/user/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';

class UserSettingView extends StatefulWidget {
  const UserSettingView({Key? key}) : super(key: key);

  @override
  State<UserSettingView> createState() => _UserSettingViewState();
}

class _UserSettingViewState extends State<UserSettingView> {
  DioMetaData userDetailDioMetaData(String userId) {
    return DioMetaData(joinUri('/weapi/v1/user/detail/$userId'), data: {}, options: joinOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: const Text('个人信息'),),
      body: RequestWidget<NeteaseUserDetail>(
        dioMetaData: userDetailDioMetaData(UserController.to.userData.value.profile?.userId ?? ''),
        childBuilder: (userData) => Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 30.w)),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: Get.width,
                            margin: EdgeInsets.only(top: 200.w),
                            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 25.w, top: 80.w),
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(25.w)),
                            child: Column(
                              children: [
                                Text(
                                  userData.profile.nickname ?? '',
                                  style: TextStyle(fontSize: 56.sp),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.w),
                                  child: Text(
                                    userData.profile.signature ?? '',
                                    style: TextStyle(fontSize: 32.sp, color: Colors.grey),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 20.w),child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('${userData.profile.follows} 关注'),
                                    Text('${userData.profile.followeds} 粉丝'),
                                    Text('${userData.profile.playlistCount} 歌单'),
                                  ],
                                ),)
                              ],
                            ),
                          ),
                          SimpleExtendedImage.avatar(
                            UserController.to.userData.value.profile?.avatarUrl ?? '',
                            width: 260.w,
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            Obx(() => Visibility(
              visible: UserController.to.loginStatus.value == LoginStatus.login,
              child: GestureDetector(
                child: SafeArea(
                    child: Container(
                      height: 88.w,
                      alignment: Alignment.center,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 40.w, horizontal: 35.w),
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20.w)),
                      child: Text(
                        '注销登录',
                        style: TextStyle(fontSize: 28.sp, color: Colors.white),
                      ),
                    )),
                onTap: () {
                  UserController.to.clearUser();
                  AutoRouter.of(context).pop();
                },
              ),
            ))
          ],
        ),),
    );
  }
}
