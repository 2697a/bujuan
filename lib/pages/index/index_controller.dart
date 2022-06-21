import 'dart:io';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class IndexController extends GetxController {
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  List<Audio> audios = [];

  @override
  void onReady() async {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      querySong();
      queryAlbum();
    });
  }

  querySong() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      songs.value = await HomeController.to.audioQuery.querySongs();
      for (var songModel in songs) {
        Directory directory = await getTemporaryDirectory();
        String path = '${directory.path}${songModel.id}';
        File file = File(path);
        if (!await file.exists()) {
          Uint8List? a = await HomeController.to.audioQuery.queryArtwork(songModel.id, ArtworkType.AUDIO, size: 800);
          await file.writeAsBytes(a!);
        }
        Audio audio = Audio.file(
          songModel.uri ?? '',
          metas: Metas(title: songModel.title, artist: songModel.artist, album: songModel.album, image: MetasImage.file(path), id: '${songModel.id}'),
        );
        audios.add(audio);
      }
    });
  }

  queryAlbum() async{
    albums.value = await HomeController.to.audioQuery.queryAlbums();
  }

  play(index) async {
    await HomeController.to.assetsAudioPlayer
        .open(Playlist(audios: audios, startIndex: index), loopMode: LoopMode.playlist, autoStart: true, showNotification: true, playInBackground: PlayInBackground.enabled);
  }
}
