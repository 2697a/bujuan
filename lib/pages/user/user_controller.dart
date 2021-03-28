import 'package:bujuan/entity/fm_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:starry/starry.dart';

class UserController extends GetxController {
  var lovePlayList = [].obs;
  var createPlayList = [].obs;
  var collectPlayList = [].obs;
  RefreshController refreshController;
  var isLoad = false;

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
    var userId = SpUtil.getString(USER_ID_SP, defValue: null);
    var userOrderEntity =
        await NetUtils().getUserPlayList(userId, forcedRefresh: forcedRefresh);
    if (userOrderEntity != null && userOrderEntity.code == 200) {
      var list = userOrderEntity.playlist;
      if (list.length > 0) {
        lovePlayList
          ..clear()
          ..add(list[0]);
        list.removeAt(0);
        var item = list.where((element) => element.userId == num.parse(userId));
        createPlayList
          ..clear()
          ..addAll(item);
        var where =
            list.where((element) => element.userId != num.parse(userId));
        collectPlayList
          ..clear()
          ..addAll(where);
      }
    }
    isLoad = true;
    refreshController.refreshCompleted();
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
      if (playListMode == PlayListMode.SONG) {
        Get.find<GlobalController>().playListMode.value = PlayListMode.FM;
        Starry.playMusic(fmSong, 0);
      }
    }
    return fmSong;
  }
}
