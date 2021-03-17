import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/login/login_binding.dart';
import 'package:bujuan/login/login_view.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindController extends GetxController {
  var result = [].obs;
  RefreshController refreshController;
  var newSong = [].obs;
  var currentIndexPage = 0.obs;

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onReady() {
    loadTodaySheet();
    super.onReady();
  }

  loadTodaySheet() async {
    var personalEntity = await NetUtils().getRecommendResource();
    if (personalEntity != null && personalEntity.code == 200) {
      result
        ..clear()
        ..addAll(personalEntity.result);
    }
    await loadNewSong();
  }

  loadNewSong() async {
    var newSongEntity = await NetUtils().getNewSongs();
    if (newSongEntity != null && newSongEntity.code == 200) {
      newSong
        ..clear()
        ..addAll(newSongEntity.result);
    }
    refreshController?.refreshCompleted();
  }


  ///进入每日推荐
  goToTodayMusic(){
    if(Get.find<HomeController>().login.value){
      Get.toNamed("/today");
    }else{
      Get.find<HomeController>().goToLogin();
    }
  }
}
