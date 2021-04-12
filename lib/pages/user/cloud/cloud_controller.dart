import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class CloudController extends GetxController {
  RefreshController refreshController;
  var clouds = [].obs;
  var loadPageIndex = 0.obs;
  var enableLoadMore = true.obs;

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    _getCloudData();
    super.onReady();
  }

  ///获云盘数据
  _getCloudData() async {
    var cloudEntity = await NetUtils().getCloudData(loadPageIndex * 30);
    if (cloudEntity != null) {
      //获取成功
      if (loadPageIndex.value == 0) {
        clouds
          ..clear()
          ..addAll(cloudEntity);
        refreshController.refreshCompleted();
        if (cloudEntity.length < 30) enableLoadMore.value = false;
      } else {
        if (cloudEntity.length > 0) {
          clouds.addAll(cloudEntity);
          refreshController?.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
    }else{
      refreshController.loadNoData();
    }
  }

  refreshData() {
    loadPageIndex.value = 0;
    onReady();
  }

  loadMoreData() {
    loadPageIndex.value++;
    onReady();
  }

  @override
  void onClose() {
    refreshController?.dispose();
    super.onClose();
  }

  playSong(index) async {
    List<MusicItem>  songs = [];
    // var playSheetId = SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -1);
    // if (playSheetId == -998) {
    //   //当前歌单正在播放，直接根据下标播放
    //   Starry.playMusicByIndex(index);
    // } else {
      //当前歌单未在播放
      clouds.forEach((track) {
        MusicItem musicItem = MusicItem(
          musicId: '${track.id}',
          duration: track.dt,
          iconUri: "${track.al.picUrl}",
          title: track.name,
          uri: '${track.id}',
          artist: track.ar[0].name == null ? '未知' : track.ar[0].name,
        );
        songs.add(musicItem);
      });
    BuJuanUtil.playSongByIndex(songs, index, PlayListMode.SONG);
      SpUtil.putInt(PLAY_SONG_SHEET_ID, -998);
    // }
  }
}
