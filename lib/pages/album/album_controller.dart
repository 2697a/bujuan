import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class AlbumController extends GetxController {
  final albumDetails = [].obs;
  final albumId = 1.obs;

  @override
  void onReady() {
    getAlbum();
    super.onReady();
  }

  getAlbum() {
    NetUtils().getAlbumDetails(Get.arguments['id']).then((value) {
      if (value != null) {
        albumDetails
          ..clear()
          ..addAll(value.data);
        albumId.value = value.album.id;
      }
    });
  }

  playSong(index) async {
    List<MusicItem> songs = [];
    albumDetails.forEach((track) {
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
    SpUtil.putInt(PLAY_SONG_SHEET_ID, albumId.value);
    BuJuanUtil.playSongByIndex(songs, index, PlayListMode.SONG);
  }
}
