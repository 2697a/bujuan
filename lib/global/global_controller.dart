import 'dart:convert';

import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

import 'global_config.dart';

class GlobalController extends GetxController {
  var playState = PlayState.STOP.obs;
  var playPos = 0.obs;
  var song = MusicItem(
          musicId: '-99',
          duration: 0,
          title: "暂无歌曲",
          artist: "暂无",
          iconUri:
              "https://p2.music.126.net/pCJ3_kG8FeLR749dbkpT2A==/109951165784923841.jpg")
      .obs;
  var lyric = LyricEntity().obs;

  @override
  void onInit() {
    var string = SpUtil.getString(LAST_PLAY_INFO, defValue: null);
    if (string != null) {
      song.value = MusicItem.fromJson(jsonDecode(string));
    }
    super.onInit();
  }

  ///获取当前播放歌曲
  void getNowPlaying() async {
    var musicItem = await Starry.getNowPlaying();
    song.value = musicItem;
  }

  ///更新当前歌曲(弃用)
  changeSong(MusicItem song) async {
    var lyricEntity = await NetUtils().getMusicLyric(song.musicId);
    lyric.value = lyricEntity;
    this.song.value = song;
  }

  ///播放或暂停
  playOrPause() async {
    // if (playState.value == PlayState.ERROR || playState.value == PlayState.STOP)
    //   return;
    if (song.value.musicId == "-99") return;
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

  seekTo(int seek) async {
    await Starry.changeSongSeek(seek);
  }
}
