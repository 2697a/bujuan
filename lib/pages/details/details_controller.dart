import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/common/api/src/netease_util.dart';
import 'package:bujuan/common/bean/song_url_entity.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../common/bean/song_details_entity.dart';

class DetailsController extends GetxController {
  DetailsArguments? detailsArguments;
  List<Audio> audios = [];
  bool added = false;

  @override
  void onInit() {
    detailsArguments = Get.arguments;
    super.onInit();
  }

  void initSong(List<SongDetailsSongs> songs) {
    List<Audio> audios = songs
        .map((e) => Audio.network(
              'https://music.163.com/song/media/outer/url?id=${e.id}.mp3',
              metas:
                  Metas(title: e.name, artist: e.ar?.map((e) => e.name).toList().join(','), album: e.al?.name ?? '', image: MetasImage.network(e.al?.picUrl ?? ''), id: '${e.id}'),
            ))
        .toList();
    this.audios
      ..clear()
      ..addAll(audios);
  }

  void playByIndex(int index) async {
    if (!added) {
      await HomeController.to.assetsAudioPlayer
          .open(Playlist(audios: audios), loopMode: LoopMode.playlist, autoStart: false, showNotification: true, playInBackground: PlayInBackground.enabled);
      added = true;
    }
  }
}
