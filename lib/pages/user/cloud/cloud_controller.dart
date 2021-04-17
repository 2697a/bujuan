import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/state_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class CloudController extends GetxController {
  RefreshController refreshController;
  var clouds = [].obs;
  var loadPageIndex = 0.obs;
  final loadState = LoadState.IDEA.obs;
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
      if (cloudEntity.length == 0) {
        loadState.value = LoadState.EMPTY;
        return;
      }
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
    } else {
      loadState.value = LoadState.FAIL;
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
    List<MusicItem> songs = [];
    clouds.forEach((track) {
      MusicItem musicItem = MusicItem(
        musicId: '${track.id}',
        duration: track.dt==0?320000:track.dt,
        iconUri: "${track.al.picUrl}",
        title: track.name,
        uri: '${track.id}',
        artist: track.ar[0].name == null ? '未知' : track.ar[0].name,
      );
      songs.add(musicItem);
    });
    BuJuanUtil.playSongByIndex(songs, index, PlayListMode.SONG);
    SpUtil.putInt(PLAY_SONG_SHEET_ID, CLOUD_ID);
  }
}
