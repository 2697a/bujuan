import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/find/find_controller.dart';
import 'package:bujuan/pages/music/music_controller.dart';
import 'package:bujuan/pages/top/top_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GlobalController>(() => GlobalController());
    Get.lazyPut<FindController>(() => FindController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<TopController>(() => TopController());
    Get.lazyPut<MusicController>(() => MusicController());
  }

}