import 'dart:convert';

import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/routes/router.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../common/netease_api/src/api/login/bean.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_api.dart';
import '../../common/netease_api/src/netease_handler.dart';

enum LoginStatus { login, noLogin }

class UserController extends GetxController {
  List<Play> playlist = <Play>[].obs;
  Rx<Play> play = Play().obs;
  RxBool loading = true.obs;
  final List<UserItem> userItems = [
    UserItem('每日', TablerIcons.calendar, routes: Routes.today),
    UserItem('FM', TablerIcons.vinyl, routes: 'playFm'),
    UserItem('播客', TablerIcons.brand_apple_podcast, routes: Routes.myRadio),
    UserItem('云盘', TablerIcons.cloud_fog, routes: Routes.cloud)
  ];

  //进度
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserState();
      _update();
    });
  }

  _update() {
    Https.dioProxy.get('https://gitee.com/yasengsuoai/bujuan_version/raw/master/version.json').then((value) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      Map<String, dynamic> versionData = value.data..putIfAbsent('oldVersion', () => version);
      if (int.parse((versionData['version'] ?? '0').replaceAll('.', '')) > int.parse(version.replaceAll('.', ''))) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          GetIt.instance<RootRouter>().push(const UpdateView().copyWith(queryParams: versionData));
        });
      }
    });
  }

  static UserController get to => Get.find();

  //获取用户信息
  getUserState() async {
    try {
      NeteaseAccountInfoWrap neteaseAccountInfoWrap = await NeteaseMusicApi().loginAccountInfo();
      if (neteaseAccountInfoWrap.code == 200 && neteaseAccountInfoWrap.profile != null) {
        Home.to.userData.value = neteaseAccountInfoWrap;
        Home.to.loginStatus.value = LoginStatus.login;
        StorageUtil().setString(loginData, jsonEncode(neteaseAccountInfoWrap.toJson()));
        getUserPlayList();
        _getUserLikeSongIds();
      }
    } catch (e) {
      Home.to.loginStatus.value = LoginStatus.noLogin;
      WidgetUtil.showToast('获取用户资料失败，请检查网络');
    }
  }

  clearUser() {
    NeteaseMusicApi().logout().then((value) {
      if (value.code != 200) {
        WidgetUtil.showToast(value.message ?? '');
        return;
      }
      StorageUtil().setString(loginData, '');
      Home.to.loginStatus.value = LoginStatus.noLogin;
    });
  }

  getUserPlayList() {
    NeteaseMusicApi().userPlayList(Home.to.userData.value.profile?.userId ?? '-1').then((MultiPlayListWrap2 multiPlayListWrap2) {
      List<Play> list = (multiPlayListWrap2.playlist ?? []);
      if (list.isNotEmpty) {
        play.value = list.first;
        playlist
          ..clear()
          ..addAll(list..removeAt(0));
      }
      loading.value = false;
    });
  }

  _getUserLikeSongIds() async {
    LikeSongListWrap likeSongListWrap = await NeteaseMusicApi().likeSongList(Home.to.userData.value.profile?.userId ?? '-1');
    if (likeSongListWrap.code == 200) {
      Home.to.likeIds
        ..clear()
        ..addAll(likeSongListWrap.ids);
    }
  }

  @override
  void onClose() {
    // userScrollController.dispose();
    super.onClose();
  }
}
