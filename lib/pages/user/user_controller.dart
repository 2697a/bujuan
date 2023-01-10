
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/request_widget/request_loadmore_view.dart';

enum LoginStatus { login, noLogin }

class UserController extends GetxController {
  // List<Play> playlist = <Play>[].obs;
  ScrollController userScrollController = ScrollController();
  RxDouble op = 0.0.obs;
  final List<double> colors = [1, .9, .8, .7, .6, .5, .4, .3, .2, .1, 0];
  final List<UserItem> userItems = [
    UserItem('每日', TablerIcons.calendar, routes: Routes.today),
    UserItem('FM', TablerIcons.vinyl, routes: 'playFm'),
    UserItem('播客', TablerIcons.brand_apple_podcast, routes: Routes.myRadio),
    UserItem('云盘', TablerIcons.cloud_fog, routes: Routes.cloud)
  ];

  Rx<LoginStatus> loginStatus = LoginStatus.noLogin.obs;
  RequestRefreshController refreshController = RequestRefreshController();
  Rx<NeteaseAccountInfoWrap> userData = NeteaseAccountInfoWrap().obs;
  RxList<int> likeIds = <int>[].obs;

  //进度
  @override
  void onInit() {
    super.onInit();
    getUserState();
    userScrollController.addListener(() {
      if (userScrollController.position.pixels <= 130.w && op.value != 0) {
        op.value = 0;
      }
      if (userScrollController.position.pixels >= 240.w && op.value < 1) {
        op.value = 1;
      }
    });
  }

  @override
  void onReady() {}

  static UserController get to => Get.find();

  //获取用户信息
  getUserState() async {
    try {
      NeteaseAccountInfoWrap neteaseAccountInfoWrap = await NeteaseMusicApi().loginAccountInfo();
      if (neteaseAccountInfoWrap.code == 200 && neteaseAccountInfoWrap.profile != null) {
        userData.value = neteaseAccountInfoWrap;
        loginStatus.value = LoginStatus.login;
        getUserPlayList();
        _getUserLikeSongIds();
      }
    } catch (e) {
      loginStatus.value = LoginStatus.noLogin;
      WidgetUtil.showToast('获取用户资料失败，请检查网络');
    }
  }

  _getUserLikeSongIds() async {
    LikeSongListWrap likeSongListWrap = await NeteaseMusicApi().likeSongList(userData.value.profile?.userId ?? '-1');
    if (likeSongListWrap.code == 200) {
      likeIds
        ..clear()
        ..addAll(likeSongListWrap.ids);
    }
  }

  clearUser() {
    NeteaseMusicApi().logout().then((value) {
      if (value.code != 200) {
        WidgetUtil.showToast(value.message ?? '');
      }
      loginStatus.value = LoginStatus.noLogin;
    });
  }

  getUserPlayList() {
    // NeteaseMusicApi().userPlayList(userData.value.profile?.userId ?? '-1').then((MultiPlayListWrap2 multiPlayListWrap2) {
    //   playlist
    //     ..clear()
    //     ..addAll(multiPlayListWrap2.playlist ?? []);
    // });
  }

  DioMetaData userPlayListDioMetaData(String userId, {int offset = 0, int limit = 30}) {
    var params = {'uid': userId, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/user/playlist'), data: params, options: joinOptions());
  }

  @override
  void onClose() {
    userScrollController.dispose();
    super.onClose();
  }
}
