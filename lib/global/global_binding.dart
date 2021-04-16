import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/find/find_controller.dart';
import 'package:bujuan/pages/music/music_controller.dart';
import 'package:bujuan/pages/search/search_controller.dart';
import 'package:bujuan/pages/top/top_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController(),permanent: true);
    Get.put<FindController>(FindController());
    Get.put<UserController>(UserController());
    Get.put<TopController>(TopController());
    Get.put<MusicController>(MusicController());
    Get.put<SearchController>(SearchController());
  }

}