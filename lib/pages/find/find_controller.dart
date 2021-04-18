import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:bujuan/widget/state_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class FindController extends GetxController {
  final sheet = [].obs;
  final allSheet = [].obs;
  final newSong = [].obs;
  final currentIndexPage = 0.obs;
  final loadState = LoadState.IDEA.obs;
  PreloadPageController pageController;
  RefreshController refreshController;
  var isLoad = false;

  static FindController get to => Get.find();

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    pageController = PreloadPageController();
    super.onInit();
  }

  @override
  void onReady() {
    if(HomeController.to.currentIndex==1) loadTodaySheet();
    super.onReady();
  }

  loadTodaySheet({forcedRefresh = false}) {
    NetUtils()
        .getRecommendResource(forcedRefresh: forcedRefresh)
        .then((personalEntity) {
      if (personalEntity != null && personalEntity.code == 200) {
        var sheets = personalEntity.result;
        allSheet
          ..clear()
          ..addAll(sheets);
        sheet..clear();
        if (sheets.length == 6) {
          var i = sheets.length ~/ 3;
          for (int j = 0; j < i; j++) {
            sheet.add(sheets.sublist(j * 3, (j + 1) * 3));
          }
        }
      } else {
        loadState.value = LoadState.FAIL;
      }
    });
    loadNewSong();
  }

  loadNewSong({forcedRefresh = false}) {
    NetUtils().getNewSongs(forcedRefresh: forcedRefresh).then((newSongEntity) {
      if (newSongEntity != null && newSongEntity.code == 200) {
        newSong
          ..clear()
          ..addAll(newSongEntity.result.sublist(0, 6));
        loadState.value = LoadState.SUCCESS;
        isLoad = true;
      } else {
        loadState.value = LoadState.FAIL;
      }
      refreshController?.refreshCompleted();
    });
  }

  ///进入每日推荐
  goToTodayMusic() {
    if (HomeController.to.login.value) {
      Get.toNamed('/today');
    } else {
      HomeController.to.goToLogin();
    }
  }

  goToFm() {
    if (HomeController.to.login.value) {
      if (GlobalController.to.playListMode.value != PlayListMode.FM) {
        getFM();
      }
    } else {
      HomeController.to.goToLogin();
    }
  }

  Future<List<MusicItem>> getFM() async {
    List<MusicItem> fmSong = [];
    var fmEntity = await NetUtils().getFm();
    if (fmEntity != null && fmEntity.code == 200) {
      fmEntity.data.forEach((track) {
        MusicItem musicItem = MusicItem(
          musicId: '${track.id}',
          duration: track.duration,
          iconUri: "${track.album.picUrl}",
          title: track.name,
          uri: '${track.id}',
          artist: track.artists[0].name,
        );
        fmSong.add(musicItem);
      });
      SpUtil.putInt(PLAY_SONG_SHEET_ID, FM_ID);
      BuJuanUtil.playSongByIndex(fmSong, 0, PlayListMode.FM);
    }
    return fmSong;
  }

  playSong(index) async {
    List<MusicItem> songs = [];
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
    BuJuanUtil.playSongByIndex(songs, index, PlayListMode.SONG);
  }
}
