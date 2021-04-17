import 'package:bujuan/pages/music/music_controller.dart';
import 'package:get/get.dart';

class MusicBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<MusicController>(MusicController());
  }

}