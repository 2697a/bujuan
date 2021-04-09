import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/find/find_controller.dart';
import 'package:bujuan/pages/music/music_controller.dart';
import 'package:bujuan/pages/search/search_airsit/search_airsit_controller.dart';
import 'package:bujuan/pages/search/search_album/search_album_controller.dart';
import 'package:bujuan/pages/search/search_mv/search_mv_controller.dart';
import 'package:bujuan/pages/search/search_sheet/search_sheet_controller.dart';
import 'package:bujuan/pages/search/search_song/search_song_controller.dart';
import 'package:bujuan/pages/top/top_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<GlobalController>( GlobalController(),permanent: false);

    Get.lazyPut<FindController>(() => FindController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<TopController>(() => TopController());
    Get.lazyPut<MusicController>(() => MusicController());
  }

}