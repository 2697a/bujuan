import 'package:bujuan/pages/playlist_manager/playlist_manager_controller.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaylistManager());
  }
}
