import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/search/search_detail/search_detail_controller.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class SearchSongController extends GetxController {
  final search = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getSearch();
    super.onReady();
  }

  getSearch() {
    NetUtils().search(SearchDetailController.to.searchContext, 1).then((data) {
      if (data is List<SheetDetailsPlaylistTrack>) {
        search
          ..clear()
          ..addAll(data);
      }
    });
  }


  playSong(index)  {
    BuJuanUtil.playSongByIndex(getSheetList(), index, PlayListMode.SONG);
  }

  getSheetList() {
    List<MusicItem>  songs = [];
   search.forEach(( track) {
     MusicItem musicItem = MusicItem(
       musicId: '${track.id}',
       duration: track.dt,
       iconUri: "${track.al.picUrl}",
       title: track.name,
       uri: '${track.id}',
       artist: track.ar[0].name,
     );
     songs.add(musicItem);
    });
    return songs;
  }
}
