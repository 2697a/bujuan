import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class BottomBarController extends GetxController {
  var isPlay = false.obs;
  var playState = PlayState.STOP.obs;
  var playPos = 0.obs;
  var song = MusicItem(musicId: null, duration: 0).obs;
  var lyric = LyricEntity().obs;
  var color = Theme.of(Get.context).primaryColor.obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    _listenerStarry();
    super.onInit();
  }

  void setController(WeSlideController weSlideController){
    // this.weSlideController = weSlideController;
  }
  @override
  void onReady() {
    super.onReady();
  }

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
    var lyricEntity = await NetUtils().getMusicLyric(song.musicId);
    lyric.value = lyricEntity;
    this.song.value = song;
    isPlay.value = true;
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
      var lyricEntity = await NetUtils().getMusicLyric(songInfo.musicId);
      lyric.value = lyricEntity;
      this.song.value = songInfo;
    });
    Starry.onPlayerStateChanged.listen((PlayState playState) {
      this.playState.value = playState;
      if (playState == PlayState.ERROR) skipToNext();
    });
    Starry.onPlayerModeChanged.listen((pos) {
      if (pos != null) {
        this.playPos.value = pos;
      }
    });
  }


  @override
  void onClose() {
    super.onClose();
  }

}
