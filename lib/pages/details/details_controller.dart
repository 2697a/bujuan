import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class DetailsController extends GetxController {
  DetailsArguments? detailsArguments;
  RxList<SongModel> songs = <SongModel>[].obs;
  String queueTitle = '';
  final List<MediaItem> mediaItems = [];

  @override
  void onInit() {
    detailsArguments = Get.arguments;
    queueTitle = '${detailsArguments?.albumModel.id}';
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      queryAudiosFrom();
    });
  }

  queryAudiosFrom() async {
    songs.value = await HomeController.to.audioQuery.queryAudiosFrom(
        AudiosFromType.ALBUM_ID, detailsArguments?.albumModel.id ?? 0);
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
          extras: {'url': songModel.uri},
          title: songModel.title,
          artist: songModel.artist);
      mediaItems.add(mediaItem);
    }
  }

  play(index) async {
    String title = HomeController.to.audioServeHandler.queueTitle.value;
    if (title.isEmpty || title != queueTitle) {
      await HomeController.to.audioServeHandler
          .replaceQueueItems(mediaItems, queueTitle);
    }
    HomeController.to.audioServeHandler
      ..skipToQueueItem(index)
      ..play();
  }
}
