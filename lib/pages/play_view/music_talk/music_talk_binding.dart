import 'package:bujuan/pages/play_view/music_talk/music_talk_controller.dart';
import 'package:get/get.dart';

class MusicTalkBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<MusicTalkController>(MusicTalkController());
  }

}