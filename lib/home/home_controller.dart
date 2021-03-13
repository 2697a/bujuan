import 'dart:async';
import 'dart:convert';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class HomeController extends GlobalController
    with SingleGetTickerProviderMixin {
  var currentIndex = 0.obs;
  PageController pageController;
  WeSlideController weSlideController;
  var isDarkTheme = false.obs;
  var bottomHeight = 58.0.obs;
  StreamSubscription _streamSubscription;

  @override
  void onInit() {
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

  void changeHide(double bottomHeight) {
    this.bottomHeight.value = bottomHeight;
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
    // Starry.onPlayerSongPosChanged.listen((pos) {
    //   if (pos != null) {
    //     Get.find<GlobalController>().playPos.value = pos;
    //   }
    // });
  }
}
