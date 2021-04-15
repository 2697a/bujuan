
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';


class AllSongController extends GetxController {
  WeSlideController weSlideController;
  var allMusic = [].obs;

  @override
  void onInit() {
    weSlideController = WeSlideController();
    super.onInit();
  }

  @override
  void onReady() {
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        Get.find<HomeController>().resumeStream();
      } else {
        Get.find<HomeController>().pauseStream();
      }
    });
    getAllMusic();
    super.onReady();
  }

  getAllMusic() async {
    OnAudioQuery()
        .querySongs(SongSortType.DEFAULT, OrderType.ASC_OR_SMALLER,
            UriType.EXTERNAL, true)
        .then((value) {
      allMusic.clear();
      value.forEach((element) {
        if(element.artist!="<unknown>"&&!GetUtils.isNullOrBlank(element.artist)&&!GetUtils.isNullOrBlank(element.title)){
          allMusic.add(element);
        }
      });
    });
    // var list = await Get.find<FileService>().audioQuery.getSongs();
    // allMusic..clear()..addAll(list);
    print("object");
  }

  playSong(index) async {

    SpUtil.putInt(PLAY_SONG_SHEET_ID, LOCAL_ID);
    BuJuanUtil.playSongByIndex(getSheetList(), index, PlayListMode.LOCAL);
  }

  getSheetList() {
    List<MusicItem> songs = [];
    allMusic.forEach((track) {
      MusicItem musicItem = MusicItem(
        musicId: '${track.id}',
        duration: !GetUtils.isNullOrBlank(track.duration)
            ? int.parse(track.duration)
            : 30000,
        iconUri: track.artwork,
        title: track.title,
        uri: '${track.data}',
        artist: track.artist,
      );
      songs.add(musicItem);
    });
    return songs;
  }
}
