import 'dart:math';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class UserController extends GetxController {
  var lovePlayList = [].obs;
  var createPlayList = [].obs;
  var collectPlayList = [].obs;
  final isNoCreate = false.obs;
  final isNoCollect = false.obs;
  RefreshController refreshController;
  var isLoad = false;

  static UserController get to => Get.find();

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  ///获取用户歌单
  getUserSheet({forcedRefresh = false}) async {
    if (HomeController.to.login.value) {
      var userId = HomeController.to.userProfileEntity.value.profile.userId;
      NetUtils()
          .getUserPlayList(userId, forcedRefresh: forcedRefresh)
          .then((userOrderEntity) {
        if (userOrderEntity != null && userOrderEntity.code == 200) {
          var list = userOrderEntity.playlist;
          if (list.length > 0) {
            lovePlayList
              ..clear()
              ..add(list[0]);
            list.removeAt(0);
            var item = list.where((element) => element.userId == userId);
            if (item.length > 0) {
              createPlayList
                ..clear()
                ..addAll(item);
              isNoCreate.value = false;
            } else {
              isNoCreate.value = true;
            }
            var where = list.where((element) => element.userId != userId);
            if (where.length > 0) {
              collectPlayList
                ..clear()
                ..addAll(where);
              isNoCollect.value = false;
            } else {
              isNoCollect.value = true;
            }
          }
        } else {
          isNoCreate.value = true;
          isNoCollect.value = true;
        }
        isLoad = true;
        refreshController.refreshCompleted();
      });
    }
  }

  ///心动模式
  playHeartSong(pid) {
    var rng = new Random();
    var nextInt = rng.nextInt(HomeController.to.likeSongs.length);
    NetUtils()
        .getHeart(HomeController.to.likeSongs[nextInt], pid)
        .then((List<MusicItem> musics) async {
      if (musics.length > 0) {
        //当前歌单未在播放
        SpUtil.putInt(PLAY_SONG_SHEET_ID, HEART_ID);
        BuJuanUtil.playSongByIndex(musics, 0, PlayListMode.SONG);
      }
    });
  }

  Future<List<MusicItem>> getFM() async {
    var playListMode = Get.find<GlobalController>().playListMode.value;
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
}
