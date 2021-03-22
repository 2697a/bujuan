import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FindController extends GetxController {
  var banner = [].obs;
  var sheet = [].obs;
  var newSong = [].obs;
  var currentIndexPage = 0.obs;
  RefreshController refreshController;

  @override
  void onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onReady() {
    loadBanner();
    super.onReady();
  }


  loadBanner() async{
    var bannerEntity = await NetUtils().getBanner();
    if(bannerEntity!=null&&bannerEntity.code==200){
      banner..clear()..addAll(bannerEntity.banners);
    }
    await loadTodaySheet();
  }
  loadTodaySheet() async {
    var personalEntity = await NetUtils().getRecommendResource();
    if (personalEntity != null && personalEntity.code == 200) {
      var sheets = personalEntity.result;
      sheet..clear()..addAll(sheets);
      // if (sheets.length ==6) {
      //   var i = sheets.length ~/ 3;
      //   for (int j = 0; j < i; j++) {
      //     sheet.add(sheets.sublist(j*3,(j+1)*3));
      //   }
      // }
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
  goToTodayMusic() {
    if (Get.find<HomeController>().login.value) {
      Get.toNamed('/today');
    } else {
      Get.find<HomeController>().goToLogin();
    }
  }
}
