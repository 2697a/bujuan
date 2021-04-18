import 'package:bujuan/pages/user/playlist_manager/playlist_manager_controller.dart';
import 'package:get/get.dart';

class PlayListManagerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<PlayListManagerController>(PlayListManagerController());
  }

}