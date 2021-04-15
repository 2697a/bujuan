import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
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

class SheetInfoController extends GetxController {
  final result = SheetDetailsPlaylist().obs;
  final sub = false.obs;
  RefreshController refreshController;
  PersonalResult personalResult;


  @override
  void onInit() {
    result.value = null;
    refreshController = RefreshController();
    personalResult = Get.arguments['sheet'];
    super.onInit();
  }

  @override
  void onReady() {
    getSheetInfo();
    super.onReady();
  }

  ///获取歌单详情
  getSheetInfo({forcedRefresh = true}) {
    NetUtils()
        .getPlayListDetails(personalResult.id, forcedRefresh: forcedRefresh)
        .then((sheetDetailsEntity) {
      if (sheetDetailsEntity != null && sheetDetailsEntity.code == 200) {
        if (sheetDetailsEntity.playlist.tracks != null)
          result.value = sheetDetailsEntity.playlist;
        sub.value = result.value.subscribed!=null?result.value.subscribed:false;
      }
      refreshController?.refreshCompleted();
    });
  }

  ///收藏或取消收藏歌单
  likeOrUnLikeSheet() {
    if (HomeController.to.login.value) {
      NetUtils().subPlaylist(!sub.value, result.value.id).then((success) {
        if (success) {
          sub.value = !sub.value;
        }
      });
    }else{
      HomeController.to.goToLogin();
    }

  }

  playSong(index) {
    var playSheetId = SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -1);
    if (result.value.id == playSheetId) {
      var playList = Get.find<GlobalController>().playList;
      if (playList.length != result.value.tracks.length) {
        //当前歌单未在播放
        BuJuanUtil.playSongByIndex(getSheetList(), index, PlayListMode.SONG);
        SpUtil.putInt(PLAY_SONG_SHEET_ID, result.value.id);
      } else {
        Starry.playMusicByIndex(index);
      }
      //当前歌单正在播放，直接根据下标播放
      Starry.playMusicByIndex(index);
    } else {
      //当前歌单未在播放
      BuJuanUtil.playSongByIndex(getSheetList(), index, PlayListMode.SONG);
      SpUtil.putInt(PLAY_SONG_SHEET_ID, result.value.id);
    }
  }

  getSheetList() {
    List<MusicItem> songs = [];
    result.value.tracks.forEach((track) {
      MusicItem musicItem = MusicItem(
        musicId: '${track.id}',
        duration: track.dt,
        iconUri: "${track.al.picUrl}",
        title: track.name,
        uri: '${track.id}',
        artist: track.ar[0].name,
      );
      songs.add(musicItem);
    });
    return songs;
  }

  @override
  void onClose() {
    refreshController?.dispose();
    super.onClose();
  }
}
