import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopController extends GetxController {
  var soaring = [].obs; //飙升榜
  final soaringImageUrl =
      'http://p2.music.126.net/DrRIg6CrgDfVLEph9SNh7w==/18696095720518497.jpg';
  var newSong = [].obs;
  var newSongImageUrl =
      'https://p1.music.126.net/N2HO5xfYEqyQ8q6oxCw8IQ==/18713687906568048.jpg';
  var hotSong = [].obs;
  var hotSongImageUrl =
      'http://p2.music.126.net/GhhuF6Ep5Tq9IEvLsyCN7w==/18708190348409091.jpg';
  RefreshController refreshController;
  var otherTops = [];

  static TopController get to => Get.find();

  @override
  void onInit() {
    otherTops
      ..add(TopInfo('10520166', '电音榜', dy_top))
      ..add(TopInfo('180106', 'UK榜', uk_top))
      ..add(TopInfo('60131', '日本榜', rb_top))
      ..add(TopInfo('60198', 'Billl榜', billl_top))
      ..add(TopInfo('21845217', 'KTV榜', krv_top))
      ..add(TopInfo('11641012', 'Itunes榜', itunes_top));
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  ///获取排行榜数据
  getData({forcedRefresh = false}) async {
    loadTopData("19723756", soaring, forcedRefresh: forcedRefresh);
    loadTopData("3779629", newSong, forcedRefresh: forcedRefresh);
    loadTopData("3778678", hotSong, forcedRefresh: forcedRefresh);
  }

  loadTopData(id, result, {forcedRefresh = false}) {
    NetUtils()
        .getPlayListDetails(id, count: 3, forcedRefresh: forcedRefresh)
        .then((sheetDetailsEntity) {
      if (sheetDetailsEntity != null && sheetDetailsEntity.code == 200) {
        if (sheetDetailsEntity.playlist.tracks != null &&
            sheetDetailsEntity.playlist.tracks.length >= 3)
          result
            ..clear()
            ..addAll(sheetDetailsEntity.playlist.tracks.sublist(0, 3));
      }
      if (refreshController.isRefresh) refreshController.refreshCompleted();
    });
  }
}

class TopInfo {
  String id;
  String name;
  String picUrl;

  TopInfo(this.id, this.name, this.picUrl);
}
