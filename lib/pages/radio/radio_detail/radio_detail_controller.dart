import 'package:bujuan/entity/user_dj.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/state_view.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class RadioDetailController extends GetxController {
  RefreshController refreshController;
  final program = [].obs;
  DjRadios djRadios;
  int loadPage = 0;
  final loadState = LoadState.IDEA.obs;
  final asc = true.obs;
  static RadioDetailController get to => Get.find();

  @override
  void onInit() {
    refreshController = RefreshController();
    djRadios = Get.arguments['radio'];
    super.onInit();
  }

  @override
  void onReady() {
    getDjProgram();
    super.onReady();
  }

  getDjProgram([isRefresh = true]) {
    if (isRefresh) loadPage = 0;
    NetUtils().userProgram(djRadios.id, loadPage * 300, asc.value).then((value) {
      if (value != null && value.code == 200) {
        if ((value.programs == null || value.programs.length == 0) &&
            isRefresh) {
          loadState.value = LoadState.EMPTY;
          return;
        }
        if (isRefresh) {
          program
            ..clear()
            ..addAll(value.programs);
          refreshController.refreshCompleted();
        } else {
          program.addAll(value.programs);
          loadPage++;
          refreshController.loadComplete();
        }
      } else {
        loadState.value = LoadState.FAIL;
      }

      if (!value.more) refreshController.loadNoData();
    });
  }

  playSong(index) async {
    List<MusicItem> songs = [];
    program.forEach((programs) {
      MusicItem musicItem = MusicItem(
        musicId: '${programs.id}',
        duration: programs.duration,
        iconUri: "${programs.coverUrl}",
        title: programs.name,
        uri: '${programs.id}',
        artist: GetUtils.isNullOrBlank(djRadios.name) ? '未知' : djRadios.name,
      );
      songs.add(musicItem);
    });
    BuJuanUtil.playSongByIndex(songs, index, PlayListMode.RADIO);
    SpUtil.putInt(PLAY_SONG_SHEET_ID, RADIO_ID);
  }
}
