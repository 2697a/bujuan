import 'package:bujuan/api/lyric/lyric_controller.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class BottomBarController extends GetxController
    with SingleGetTickerProviderMixin {
  var isPlay = false.obs;
  var playState = PlayState.STOP.obs;
  var currentIndex = 0.obs;
  var playPos = 0.obs;
  var song = MusicItem(musicId: null, duration: 0).obs;
  var color = Theme.of(Get.context).primaryColor.obs;
  var lyric = LyricEntity().obs;
  LyricController controller;
  WeSlideController weSlideController;

  // LyricController controller1;
  @override
  void onInit() {
    weSlideController = WeSlideController();
    _listenerStarry();
    super.onInit();
  }

  // void setController(lyricController) {
  //   controller = lyricController;
  // }

  void getNowPlaying() async {
    var musicItem = await Starry.getNowPlaying();
    song.value = musicItem;
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    Get.find<HomeController>().changeIndex(index);
  }

  ///更新当前歌曲
  changeSong(MusicItem song) async {
    getColorFromUrl('${song.iconUri}').then((color) {
      this.color.value = Color.fromRGBO(color[0], color[1], color[2], 1);
      print(color); // [R,G,B]
    });
    var lyricEntity = await NetUtils().getMusicLyric(song.musicId);
    lyric.value = lyricEntity;
    this.song.value = song;
    isPlay.value = true;

    // panelController?.open();
  }

  ///播放或暂停
  playOrPause() async {
    if (playState.value == PlayState.ERROR || playState.value == PlayState.STOP)
      return;
    if (playState.value == PlayState.PLAYING) {
      await Starry.pauseMusic();
    } else {
      await Starry.restoreMusic();
    }
  }

  ///上一首
  skipToPrevious() async {
    await Starry.skipToPrevious();
  }

  ///下一首
  skipToNext() async {
    await Starry.skipToNext();
  }

  _listenerStarry() {
    Starry.onPlayerSongChanged.listen((MusicItem songInfo) async {
      getColorFromUrl('${songInfo.iconUri}').then((color) {
        this.color.value = Color.fromRGBO(color[0], color[1], color[2], 1);
        print(color); // [R,G,B]
      });
      var lyricEntity = await NetUtils().getMusicLyric(songInfo.musicId);
      lyric.value = lyricEntity;
      this.song.value = songInfo;
      // getColorFromUrl('${songInfo.iconUri}').then((color) {
      //   this.color.value = Color.fromRGBO(color[0], color[1], color[2], 1);
      //   print(color); // [R,G,B]
      // });
    });
    Starry.onPlayerStateChanged.listen((PlayState playState) {
      this.playState.value = playState;
      if (playState == PlayState.ERROR) skipToNext();
    });
    Starry.onPlayerSongPosChanged.listen((pos) {
      if (pos != null) {
        this.playPos.value = pos;
        // print("======as=d=====$pos");
        // if (controller == null) controller = LyricController(vsync: this);
        // controller?.progress = Duration(seconds: pos);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }
}
