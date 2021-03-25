import 'package:bujuan/global/global_config.dart';
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
  var otherTops = [];

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    otherTops..add(TopInfo('10520166', '电音榜', dy_top))..add(TopInfo('180106', 'UK榜',  uk_top))..add(TopInfo('60131', '日本榜',  rb_top))..add(TopInfo('60198', 'Billl榜',  billl_top))..add(TopInfo('21845217', 'KTV榜',  krv_top))..add(TopInfo('11641012', 'Itunes榜',  itunes_top));
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
class TopInfo {
  String id;
  String name;
  String picUrl;

  TopInfo(this.id, this.name, this.picUrl);
}
