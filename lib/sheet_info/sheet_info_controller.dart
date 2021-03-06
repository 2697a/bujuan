import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:starry/song_info.dart';
import 'package:starry/starry.dart';

class SheetInfoController extends GlobalController {
  PanelController panelController;
  var loadState = 0.obs;
  var result = SheetDetailsPlaylist().obs;

  @override
  void onInit() {
    panelController = PanelController();
    super.onInit();
  }

  getSheetInfo(id) async {
    var sheetDetailsEntity = await NetUtils().getPlayListDetails(id);
    if (sheetDetailsEntity != null && sheetDetailsEntity.code == 200) {
      result.value = sheetDetailsEntity.playlist;
      loadState.value = 2;
    } else {
      loadState.value = 1;
    }
  }

  playSong(index) async {
    var songs = [];
    var playSheetId = SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -1);
    if (result.value.id == playSheetId) {
      //当前歌单正在播放，直接根据下标播放
      Starry.playMusicById("${result.value.tracks[index].id}");
    } else {
      //当前歌单未在播放
      result.value.tracks.forEach((element) {
        SongInfo songInfo = SongInfo(
          songId: "${element.id}",
          duration: element.dt,
          songCover: element.al.picUrl,
          songName: element.name,
          artist: element.ar[0].name,
        );
        songs.add(songInfo);
      });
      await Starry.playMusic(songs, index);
      SpUtil.putInt(PLAY_SONG_SHEET_ID, result.value.id);
    }
    var track = result.value.tracks[index];
    SongInfo songInfo = SongInfo(
      songId: "${track.id}",
      duration: track.dt,
      songCover: track.al.picUrl,
      songName: track.name,
      artist: track.ar[0].name,
    );
    Get.find<BottomBarController>().changeSong(songInfo);
  }
}
