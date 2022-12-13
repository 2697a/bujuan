import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:get/get.dart';

class UserBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserController());
  }

}