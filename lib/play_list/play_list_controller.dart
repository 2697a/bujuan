import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class PlayListController extends GetxController {
  var playList = List<MusicItem>().obs;

  @override
  void onReady() {
    super.onReady();
  }

  _getPlayList() async {
    var list = await Starry.getPlayList();
    playList.addAll(list);
  }

  playMusicByIndex(index) {
    Starry.playMusicByIndex(index);
    Get.back();
  }
}
