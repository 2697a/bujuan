import 'package:bujuan/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:starry/song_info.dart';
import 'package:starry/starry.dart';

class BottomBarController extends GetxController {
  var isPlay = false.obs;
  var playState = PlayState.STOP.obs;
  var currentIndex = 0.obs;
  var playPos = 0.obs;
  var song = SongInfo(songId: null, duration: 0).obs;

  @override
  void onInit() {
    _listenerStarry();
    super.onInit();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    Get.find<HomeController>().changeIndex(index);
  }

  ///更新当前歌曲
  changeSong(SongInfo song) {
    this.song.value = song;
    isPlay.value = true;
    // panelController?.open();
  }

  ///播放或暂停
  playOrPause() async{
    if (playState.value == PlayState.ERROR||playState.value == PlayState.STOP) return;
    if (playState.value == PlayState.PLAYING) {
      await Starry.pauseMusic();
    } else {
      await Starry.restoreMusic();
    }
  }
  ///上一首
  skipToPrevious() async {
    await Starry.skipToPrevious();
  }

  ///下一首
  skipToNext() async {
    await Starry.skipToNext();
  }

  _listenerStarry() {
    Starry.onPlayerSongChanged.listen((SongInfo songInfo) {
      this.song.value = songInfo;
    });
    Starry.onPlayerStateChanged.listen((PlayState playState) {
      this.playState.value = playState;
    });
    Starry.onPlayerSongPosChanged.listen((pos) {
      this.playPos.value = pos;
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
