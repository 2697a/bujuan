import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class IndexController extends GetxController {
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  final List<MediaItem> mediaItems = [];
  late BuildContext buildContext;
  final String queueTitle = Get.routing.current;
  final RxList<PaletteColorData> colors = <PaletteColorData>[].obs;

  // List<Audio> audios = [];

  @override
  void onReady() async {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      querySong();
    });
  }

  querySong() async {
    List<AlbumModel> albumList =
        await HomeController.to.audioQuery.queryAlbums();
    for (var element in albumList) {
      String path = '${HomeController.to.directoryPath}${element.id}';
      File file = File(path);
      // if (!await file.exists()) {
        Uint8List? a = await HomeController.to.audioQuery
            .queryArtwork(element.id, ArtworkType.ALBUM, size: 800);
        if(a!=null) {
          await file.writeAsBytes(a);
        }else{
          path = '';
        }
      // }
      PaletteColorData data =  await ImageUtils.getImageColor2(path);
      colors.add(data);
    }
    albums.value = albumList;
    List<SongModel> songList = await HomeController.to.audioQuery.querySongs();
    for (var songModel in songList) {
      String path = '${HomeController.to.directoryPath}${songModel.albumId}';
      MediaItem mediaItem = MediaItem(
          id: '${songModel.id}',
          duration: Duration(milliseconds: songModel.duration ?? 0),
          artUri: Uri.file(path),
          rating: const Rating.newHeartRating(false),
          extras: {
            'url': songModel.uri,
            'data': songModel.data,
            'type': songModel.fileExtension,
            'albumId': songModel.albumId,
          },
          title: songModel.title,
          artist: songModel.artist);
      mediaItems.add(mediaItem);
    }
    songs.value = songList;
  }

  queryAlbum() async {}

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
