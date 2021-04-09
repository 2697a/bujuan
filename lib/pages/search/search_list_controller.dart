import 'package:bujuan/entity/search_album.dart';
import 'package:bujuan/entity/search_mv_entity.dart';
import 'package:bujuan/entity/search_sheet_entity.dart';
import 'package:bujuan/entity/search_singer_entity.dart';
import 'package:bujuan/entity/search_song_entity.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:get/get.dart';

class SearchListController extends GetxController {
  final search = [].obs;

  static SearchListController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  getSearch(content, type) {
    NetUtils().search(content, type).then((data) {
      if (data is SearchSongEntity) {
        search
          ..clear()
          ..addAll(data.result.songs);
      }
      if (data is SearchAlbumEntity) {
        search
          ..clear()
          ..addAll(data.result.albums);
      }
      if (data is SearchSheetEntity) {
        search
          ..clear()
          ..addAll(data.result.playlists);
      }
      if (data is SearchSingerEntity) {
        search
          ..clear()
          ..addAll(data.result.artists);
      }
      if (data is SearchMvEntity) {
        search
          ..clear()
          ..addAll(data.result.mvs);
      }
    });
  }
}
