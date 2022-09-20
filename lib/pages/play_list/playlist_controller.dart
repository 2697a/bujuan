import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import '../../common/bean/playlist_entity.dart';
import '../home/home_controller.dart';

class PlayListController extends GetxController {
  List<PlaylistPlaylistTracks> tracks = <PlaylistPlaylistTracks>[].obs;
  final List<MediaItem> mediaItems = [];
  String queueTitle = '';

  setPlayList(List<PlaylistPlaylistTracks> list) {
    queueTitle = '${Get.arguments}';
    tracks
      ..clear()
      ..addAll(list);
    for (var track in list) {
      MediaItem mediaItem = MediaItem(
          id: '${track.id}',
          duration: Duration(milliseconds: track.dt ?? 0),
          artUri: Uri.parse(track.al?.picUrl??''),
          extras: {'url': 'http://music.163.com/song/media/outer/url?id=${track.id??0}', 'data': '', 'type': '', 'albumId': ''},
          title: track.name??"",
          artist: '网易云');
      mediaItems.add(mediaItem);
    }
  }

  playIndex(int index) async{
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
      await HomeController.to.audioServeHandler.addQueueItems(mediaItems);
    }
    HomeController.to.audioServeHandler
      ..skipToQueueItem(index)
      ..play();
  }
}
