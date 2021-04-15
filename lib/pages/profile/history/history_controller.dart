import 'package:bujuan/entity/play_history_entity.dart';
import 'package:bujuan/entity/week_data.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class HistoryController extends GetxController {
  final history = [].obs;
  final currIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getHistList(1);
    super.onReady();
  }

  ///1: 最近一周, 0: 所有时间
  getHistList(type) {
    NetUtils()
        .getHistory(
            HomeController.to.userProfileEntity.value.profile.userId, type)
        .then((value) {
      if (value is WeekHistory) {
        if (value != null && value.code == 200)
          history
            ..clear()
            ..addAll(value.weekData);
      } else if (value is PlayHistoryEntity) {
        if (value != null && value.code == 200)
          history
            ..clear()
            ..addAll(value.allData);
      }
    });
  }

  changeIndex(index) {
    currIndex.value = index;
    getHistList(index == 0 ? 1 : 0);
  }

  playSong(index) async {
    List<MusicItem> songs = [];
    history.forEach((track) {
      MusicItem musicItem = MusicItem(
        musicId: '${track.song.id}',
        duration: track.song.dt,
        iconUri: track.song.al.picUrl,
        title: track.song.name,
        uri: '${track.song.id}',
        artist: track.song.ar[0].name,
      );
      songs.add(musicItem);
    });
    SpUtil.putInt(PLAY_SONG_SHEET_ID, HISTORY_ID);
    BuJuanUtil.playSongByIndex(songs, index, PlayListMode.SONG);
  }
}
