import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class TodayController extends GetxController {
  final list = [].obs;

  @override
  void onReady() {
    getToday();
    super.onReady();
  }



  getToday() {
    NetUtils().getTodaySongs().then((list) {
      if (list != null) {
        this.list
          ..clear()
          ..addAll(list);
      }
    });
  }

  playSong(index) async {
    var songs = [];
    // var playSheetId = SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -1);
    // if (playSheetId == -999) {
    //   //当前歌单正在播放，直接根据下标播放
    //   Starry.playMusicByIndex(index);
    // } else {
    //当前歌单未在播放
    list.forEach((track) {
      MusicItem musicItem = MusicItem(
        musicId: '${track.id}',
        duration: track.dt,
        iconUri: track.al.picUrl,
        title: track.name,
        uri: '${track.id}',
        artist: track.ar[0].name,
      );
      songs.add(musicItem);
    });
    await Starry.playMusic(songs, index);
    SpUtil.putInt(PLAY_SONG_SHEET_ID, -999);
    // }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
