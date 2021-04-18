import 'dart:math';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class UserController extends GetxController {
  var lovePlayList = [].obs;
  var createPlayList = [].obs;
  var collectPlayList = [].obs;
  final isNoCreate = false.obs;
  final isNoCollect = false.obs;
  final privacy = false.obs;
  RefreshController refreshController;
  TextEditingController textEditingController;
  var isLoad = false;

  static UserController get to => Get.find();

  @override
  void onInit() {
    textEditingController = TextEditingController();
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    if (HomeController.to.currentIndex == 0) {
      getUserSheet();
    }
    super.onReady();
  }

  ///获取用户歌单
  getUserSheet({forcedRefresh = false}) async {
    if (HomeController.to.login.value) {
      NetUtils()
          .getUserPlayList(HomeController.to.userId,
              forcedRefresh: forcedRefresh)
          .then((userOrderEntity) {
        if (userOrderEntity != null && userOrderEntity.code == 200) {
          var list = userOrderEntity.playlist;
          if (list.length > 0) {
            lovePlayList
              ..clear()
              ..add(list[0]);
            list.removeAt(0);
            var item = list.where((element) =>
                element.userId == int.parse(HomeController.to.userId));
            if (item.length > 0) {
              createPlayList
                ..clear()
                ..addAll(item);
              isNoCreate.value = false;
            } else {
              isNoCreate.value = true;
            }
            var where = list.where((element) =>
                element.userId != int.parse(HomeController.to.userId));
            if (where.length > 0) {
              collectPlayList
                ..clear()
                ..addAll(where);
              isNoCollect.value = false;
            } else {
              isNoCollect.value = true;
            }
          }
        } else {
          isNoCreate.value = true;
          isNoCollect.value = true;
        }
        isLoad = true;
        refreshController.refreshCompleted();
      });
    } else {
      refreshController.refreshCompleted();
    }
  }

  ///心动模式
  playHeartSong(pid) {
    if (HomeController.to.likeSongs.length == 0) return;
    var rng = new Random();
    var nextInt = rng.nextInt(HomeController.to.likeSongs.length);
    NetUtils()
        .getHeart(HomeController.to.likeSongs[nextInt], pid)
        .then((List<MusicItem> musics) async {
      if (musics.length > 0) {
        //当前歌单未在播放
        SpUtil.putInt(PLAY_SONG_SHEET_ID, HEART_ID);
        BuJuanUtil.playSongByIndex(musics, 0, PlayListMode.SONG);
      }
    });
  }

  addPlayList(name) {
    if (!GetUtils.isNullOrBlank(name)) {
      NetUtils().createPlayList(name, privacy.value).then((value) {
        if (value) getUserSheet(forcedRefresh: true);
      });
    }
  }

  ///显示创建歌单页面
  showAddPlayListSheet() {
    textEditingController.text = '';
    Get.bottomSheet(
      Wrap(
        children: [
          ListTile(
            title: Text('创建歌单'),
            trailing: Text('创建'),
            onTap: () {
              Get.back();
              addPlayList(textEditingController.text);
            },
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Container(
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                  Expanded(
                      child: TextField(
                    controller: textEditingController,
                    // inputFormatters: [FilteringTextInputFormatter(RegExp('[a-zA-Z]|[0-9.]'), allow: true)],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '请输入歌单名称',
                    ),
                  ))
                ],
              ),
            ),
          ),
          Obx(() => SwitchListTile(
                value: privacy.value,
                onChanged: (value) {
                  privacy.value = value;
                },
                title: Text('私密歌单'),
              ))
        ],
      ),
      backgroundColor: Theme.of(Get.context).primaryColor,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      ),
    );
  }
}
