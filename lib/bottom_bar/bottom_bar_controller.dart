import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var isPlay = false.obs;
  var song = SheetDetailsPlaylistTrack().obs;

  @override
  void onInit() {
    super.onInit();
  }

  changeSong(SheetDetailsPlaylistTrack song) {
    this.song.value = song;
    isPlay.value = true;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
