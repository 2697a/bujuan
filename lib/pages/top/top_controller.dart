import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopController extends GetxController {
  var soaring = [].obs; //飙升榜
  final soaringImageUrl = 'http://p2.music.126.net/DrRIg6CrgDfVLEph9SNh7w==/18696095720518497.jpg?param=300y300';
  var newSong = [].obs;
  var newSongImageUrl = 'https://p1.music.126.net/N2HO5xfYEqyQ8q6oxCw8IQ==/18713687906568048.jpg?param=300y300';
  var hotSong = [].obs;
  var hotSongImageUrl = 'http://p2.music.126.net/GhhuF6Ep5Tq9IEvLsyCN7w==/18708190348409091.jpg?param=300y300';
  RefreshController refreshController;
  var isLoad = false;

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  ///获取排行榜数据
  getData() async {
    await loadTopData("19723756", soaring);
    await loadTopData("3779629", newSong);
    await loadTopData("3778678", hotSong);
    isLoad = true;
    refreshController.refreshCompleted();
  }

  loadTopData(id, result) async {
    var sheetDetailsEntity = await NetUtils().getPlayListDetails(id);
    if (sheetDetailsEntity != null && sheetDetailsEntity.code == 200) {
      if (sheetDetailsEntity.playlist.tracks != null && sheetDetailsEntity.playlist.tracks.length >= 3)
        result
          ..clear()
          ..addAll(sheetDetailsEntity.playlist.tracks.sublist(0, 3));
    }
  }
}
