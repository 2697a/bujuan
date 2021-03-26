import 'dart:io';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/main.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class FindController extends GetxController {
  var banner = [].obs;
  var sheet = [].obs;
  var newSong = [].obs;
  var currentIndexPage = 0.obs;
  PreloadPageController pageController;
  RefreshController refreshController;

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    pageController = PreloadPageController();
    super.onInit();
  }

  @override
  void onReady() {
    loadTodaySheet();
    super.onReady();
  }


  loadBanner() async{
    var bannerEntity = await NetUtils().getBanner();
    if(bannerEntity!=null&&bannerEntity.code==200){
      banner..clear()..addAll(bannerEntity.banners);
    }
    await loadTodaySheet();
  }


  loadTodaySheet({forcedRefresh = false}) async {
    var personalEntity = await NetUtils().getRecommendResource(forcedRefresh: forcedRefresh);
    if (personalEntity != null && personalEntity.code == 200) {
      var sheets = personalEntity.result;
      sheet..clear();
      if (sheets.length ==6) {
        var i = sheets.length ~/ 3;
        for (int j = 0; j < i; j++) {
          sheet.add(sheets.sublist(j*3,(j+1)*3));
        }
      }
    }
    await loadNewSong();
  }

  loadNewSong({forcedRefresh = false}) async {
    var newSongEntity = await NetUtils().getNewSongs(forcedRefresh: forcedRefresh);
    if (newSongEntity != null && newSongEntity.code == 200) {
      newSong
        ..clear()
        ..addAll(newSongEntity.result.sublist(0,6));
    }
    refreshController?.refreshCompleted();
  }

  ///进入每日推荐
  goToTodayMusic() {
    if (Get.find<HomeController>().login.value) {
      Get.toNamed('/today');
    } else {
      Get.find<HomeController>().goToLogin();
    }
  }


  playSong(index) async {
    var songs = [];
    // var playSheetId = SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -1);
    // if (playSheetId == -997) {
    //   //当前歌单正在播放，直接根据下标播放
    //   Starry.playMusicByIndex(index);
    // } else {
      //当前歌单未在播放
      newSong.forEach((track) {
        MusicItem musicItem = MusicItem(
          musicId: '${track.song.id}',
          duration: track.song.duration,
          iconUri: "${track.picUrl}",
          title: track.name,
          uri: '${track.song.id}',
          artist: track.song.artists[0].name,
        );
        songs.add(musicItem);
      });
      await Starry.playMusic(songs, index);
      SpUtil.putInt(PLAY_SONG_SHEET_ID, -997);
    // }
  }
}
