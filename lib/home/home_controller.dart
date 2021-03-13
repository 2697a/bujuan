import 'dart:async';
import 'dart:convert';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/play_list/play_list_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class HomeController extends GlobalController {
  var currentIndex = 0.obs;
  var avatar =
      "https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg?source=1940ef5c"
          .obs;
  PageController pageController;
  WeSlideController weSlideController;
  StreamSubscription _streamSubscription;

  @override
  void onInit() {
    var avatarSp = SpUtil.getString(USER_AVATAR, defValue: null);
    if (avatarSp != null) avatar.value = avatarSp;
    Starry.init(url: SongUrl(getSongUrl: (id) async {
      return await NetUtils().getSongUrl(id);
    }));
    pageController =
        PageController(initialPage: currentIndex.value, viewportFraction: 1);
    weSlideController = WeSlideController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _listenerStarry();
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        resumeStream();
      } else {
        pauseStream();
      }
    });
  }

  changeAvatar(avatar) {
    this.avatar.value = avatar;
  }

  void pauseStream() {
    if (_streamSubscription != null && !_streamSubscription.isPaused)
      _streamSubscription.pause();
  }

  void resumeStream() {
    if (_streamSubscription != null && _streamSubscription.isPaused) {
      _streamSubscription.resume();
    } else {
      _streamSubscription =
          Starry.eventChannel.receiveBroadcastStream().listen((pos) {
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
      if (playState == PlayState.ERROR)
        Get.find<GlobalController>().skipToNext();
    });

    Starry.onPlayerSongListChanged.listen((List<MusicItem> playList) {
      Get.find<PlayListController>().playList
        ..clear()
        ..addAll(playList);
    });
  }
}
