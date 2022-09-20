import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:get/get.dart';

class PlayListBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<PlayListController>(PlayListController());
  }

}