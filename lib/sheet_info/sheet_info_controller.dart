import 'package:bujuan/api/lyric/lyric_controller.dart';
import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class SheetInfoController extends GlobalController
    with SingleGetTickerProviderMixin {
  WeSlideController panelController;
  var loadState = 0.obs;
  var result = SheetDetailsPlaylist().obs;
  var color = Theme.of(Get.context).primaryColor.obs;
  LyricController lyricController;

  @override
  void onInit() {
    panelController = WeSlideController();
    lyricController = LyricController(vsync: this);
    super.onInit();
  }

  getSheetInfo(id) async {
    var sheetDetailsEntity = await NetUtils().getPlayListDetails(id);
    if (sheetDetailsEntity != null && sheetDetailsEntity.code == 200) {
      getColorFromUrl('${sheetDetailsEntity.playlist.coverImgUrl}').then((color) {
        this.color.value = Color.fromRGBO(color[0], color[1], color[2], 1);
        print(color); // [R,G,B]
      });
      result.value = sheetDetailsEntity.playlist;
      loadState.value = 2;
    } else {
      loadState.value = 1;
    }
  }

  playSong(index) async {
    var songs = [];
    var playSheetId = SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -1);
    if (result.value.id == playSheetId) {
      //当前歌单正在播放，直接根据下标播放
      Starry.playMusicByIndex(index);
    } else {
      //当前歌单未在播放
      result.value.tracks.forEach((track) {
        MusicItem musicItem = MusicItem(
          musicId: "${track.id}",
          duration: track.dt,
          iconUri: track.al.picUrl,
          title: track.name,
          uri: "${track.id}",
          artist: track.ar[0].name,
        );
        songs.add(musicItem);
      });
      await Starry.playMusic(songs, index);
      SpUtil.putInt(PLAY_SONG_SHEET_ID, result.value.id);
    }
    var track = result.value.tracks[index];
    MusicItem musicItem = MusicItem(
      musicId: "${track.id}",
      duration: track.dt,
      iconUri: track.al.picUrl,
      title: track.name,
      uri: "${track.id}",
      artist: track.ar[0].name,
    );
    Get.find<BottomBarController>().changeSong(musicItem);
  }

  @override
  void onClose() {
    // panelController?.dispose();
    super.onClose();
  }
}
