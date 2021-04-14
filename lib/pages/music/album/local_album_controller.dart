import 'package:bujuan/utils/bujuan_util.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class LocalAlbumController extends GetxController{

  final  listSong = [].obs;
  @override
  void onReady() {
    getSongByAlbum();
    super.onReady();
  }

  getSongByAlbum(){
    OnAudioQuery().queryWithFilters(Get.arguments['albumName'], WithFiltersType.AUDIOS,Get.arguments['type']).then((value) {
      listSong..clear()..addAll(value.map((e) => SongModel(e)).toList());
    });
  }

  playSong(index) async {
    BuJuanUtil.playSongByIndex(getSheetList(), index, PlayListMode.LOCAL);
  }


  getSheetList() {
    List<MusicItem> songs = [];
    listSong.forEach((track) {
      MusicItem musicItem = MusicItem(
        musicId: '${track.id}',
        duration: !GetUtils.isNullOrBlank(track.duration)
            ? int.parse(track.duration)
            : 30000,
        iconUri: track.artwork,
        title: track.title,
        uri: '${track.data}',
        artist: track.artist,
      );
      songs.add(musicItem);
    });
    return songs;
  }
}