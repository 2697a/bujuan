import 'dart:async';
import 'dart:convert';

import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/login/login_binding.dart';
import 'package:bujuan/login/login_view.dart';
import 'package:bujuan/play_list/play_list_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class HomeController extends GlobalController {
  var currentIndex = 0.obs;
  var userProfileEntity = UserProfileEntity().obs;
  PageController pageController;
  WeSlideController weSlideController;
  StreamSubscription _streamSubscription;
  var login = false.obs;

  @override
  void onInit() {
    userProfileEntity.value = null;
    pageController = PageController(initialPage: currentIndex.value);
    weSlideController = WeSlideController();
    login.value = !GetUtils.isNullOrBlank(SpUtil.getString(USER_ID_SP));
    super.onInit();
    SpUtil.putBool(IS_FIRST_OPEN, false);
  }

  @override
  void onReady() {
    Starry.init(url: SongUrl(getSongUrl: (id) async {
      return await NetUtils().getSongUrl(id);
    }));
    refreshLogin();
    _listenerStarry();
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        resumeStream();
      } else {
        pauseStream();
      }
    });
    super.onReady();
  }

  void pauseStream() {
    if (_streamSubscription != null && !_streamSubscription.isPaused) _streamSubscription.pause();
  }

  void resumeStream() {
    if (_streamSubscription != null && _streamSubscription.isPaused) {
      _streamSubscription.resume();
    } else {
      _streamSubscription = Starry.eventChannel.receiveBroadcastStream().listen((pos) {
        if (pos != null) {
          Get.find<GlobalController>().playPos.value = pos;
        }
      }, cancelOnError: true);
    }
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    weSlideController?.dispose();
    weSlideController = null;
    super.onClose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  //监听播放音乐状态以及进度！
  _listenerStarry() {
    Starry.onPlayerSongChanged.listen((MusicItem songInfo) async {
      var lyricEntity = await NetUtils().getMusicLyric(songInfo.musicId);
      Get.find<GlobalController>().lyric.value = lyricEntity;
      Get.find<GlobalController>().song.value = songInfo;
      SpUtil.putString(LAST_PLAY_INFO, jsonEncode(songInfo));
    });
    Starry.onPlayerStateChanged.listen((PlayState playState) {
      Get.find<GlobalController>().playState.value = playState;
      if (playState == PlayState.ERROR) Get.find<GlobalController>().skipToNext();
    });

    Starry.onPlayerSongListChanged.listen((List<MusicItem> playList) {
      Get.find<PlayListController>().playList
        ..clear()
        ..addAll(playList);
    });
  }

  ///去个人资料页面
  goToProfile() {
    if (login.value && userProfileEntity.value != null) {
      Get.toNamed("/profile", arguments: {"profile": userProfileEntity.value});
    } else {
      goToLogin();
    }
  }

  ///去登录页面
  goToLogin() {
    Get.to(() => LoginView(), binding: LoginBinding());
  }

  ///刷新登录
  refreshLogin() async {
    if (login.value) {
      var loginEntity = await NetUtils().refreshLogin();
      if (loginEntity != null && loginEntity["code"] == 200) {
        //刷新成功
        await getUserProfile(SpUtil.getString(USER_ID_SP, defValue: null));
      } else {
        ///太久未登录，重新登录吧！！！！！
      }
    }
  }

  getUserProfile(userId) async {
    login.value = true;
    userProfileEntity.value = await NetUtils().getUserProfile(userId);
  }
}
