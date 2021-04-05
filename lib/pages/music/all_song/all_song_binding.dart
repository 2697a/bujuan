import 'package:bujuan/pages/music/all_song/all_song_controller.dart';
import 'package:get/get.dart';

class AllSongBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AllSongController>(() => AllSongController());
  }

}