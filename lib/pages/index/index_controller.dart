import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class IndexController extends GetxController {
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  final List<MediaItem> mediaItems = [];
  late BuildContext buildContext;
  final String queueTitle = Get.routing.current;

  // List<Audio> audios = [];

  @override
  void onReady() async {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      querySong();
      queryAlbum();
    });
  }

  querySong() async{
      songs.value = await HomeController.to.audioQuery.querySongs();
      for (var songModel in songs) {
        Directory directory = await getTemporaryDirectory();
        String path = '${directory.path}${songModel.id}';
        File file = File(path);
        if (!await file.exists()) {
          Uint8List? a = await HomeController.to.audioQuery
              .queryArtwork(songModel.id, ArtworkType.AUDIO, size: 800);
          await file.writeAsBytes(a!);
        }
        MediaItem mediaItem = MediaItem(
            id: '${songModel.id}',
            duration: Duration(milliseconds: songModel.duration ?? 0),
            artUri: Uri.file(path),
            rating: const Rating.newHeartRating(false),
            extras: {'url': songModel.uri, 'data': songModel.data,'type':songModel.fileExtension},
            title: songModel.title,
            artist: songModel.artist);
        mediaItems.add(mediaItem);
      }
  }

  queryAlbum() async {
    albums.value = await HomeController.to.audioQuery.queryAlbums();
  }

  play(index) async {
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      await HomeController.to.audioServeHandler.addQueueItems(mediaItems);
      HomeController.to.audioServeHandler.queueTitle.value = queueTitle;
    }
    HomeController.to.audioServeHandler
      ..skipToQueueItem(index)
      ..play();
  }
}
