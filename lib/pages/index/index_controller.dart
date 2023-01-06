import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/common/netease_api/src/api/play/cloud_entity.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
// import 'package:on_audio_query/on_audio_query.dart';

class IndexController extends GetxController {
  // RxList<SongModel> songs = <SongModel>[].obs;
  // RxList<AlbumModel> albums = <AlbumModel>[].obs;
  final List<MediaItem> mediaItems = [];
  final RxList<PaletteColorData> colors = <PaletteColorData>[].obs;

  DioMetaData cloudSongDioMetaData({int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/v1/cloud/get'), data: params, options: joinOptions());
  }

  DioMetaData personalizedPlaylistDioMetaData({int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset, 'n': 1000};
    return DioMetaData(joinUri('/weapi/personalized/playlist'), data: params, options: joinOptions());
  }

  // List<Audio> audios = [];

  @override
  void onReady() async {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<PersonalizedPlayListWrap> getSheetData() async {
    return await NeteaseMusicApi().personalizedPlaylist();
  }

  Future<List<CloudData>> getCloudData() async {
    CloudEntity cloudSongListWrap = await NeteaseMusicApi().cloudSong();
    mediaItems
      ..clear()
      ..addAll((cloudSongListWrap.data ?? [])
          .map((e) => MediaItem(
              id: '${e.songId}',
              duration: Duration(milliseconds: e.simpleSong?.dt ?? 0),
              artUri: Uri.parse('${e.simpleSong?.al?.picUrl ?? ''}?param=500y500'),
              extras: {'url': '', 'image': e.simpleSong?.al?.picUrl ?? '', 'type': '', 'available': false},
              title: e.songName ?? "",
              artist: (e.simpleSong?.ar ?? []).map((e) => e.name).toList().join(' / ')))
          .toList());
    return cloudSongListWrap.data ?? [];
  }

  // querySong() async {
  //   List<AlbumModel> albumList = await HomeController.to.audioQuery.queryAlbums();
  //   for (var element in albumList) {
  //     String path = '${HomeController.to.directoryPath}${element.id}';
  //     File file = File(path);
  //     if (!await file.exists()) {
  //       Uint8List? a = await HomeController.to.audioQuery.queryArtwork(element.id, ArtworkType.ALBUM, size: 800);
  //       if (a != null) {
  //         await file.writeAsBytes(a);
  //       } else {
  //         path = '';
  //       }
  //     }
  //   }
  //   albums.value = albumList;
  //   List<SongModel> songList = await HomeController.to.audioQuery.querySongs();
  //   for (var songModel in songList) {
  //     String path = '${HomeController.to.directoryPath}${songModel.albumId}';
  //     MediaItem mediaItem = MediaItem(
  //         id: '${songModel.id}',
  //         duration: Duration(milliseconds: songModel.duration ?? 0),
  //         artUri: Uri.file(path),
  //         rating: const Rating.newHeartRating(false),
  //         extras: {
  //           'url': songModel.uri,
  //           'data': songModel.data,
  //           'type': songModel.fileExtension,
  //           'albumId': songModel.albumId,
  //         },
  //         title: songModel.title,
  //         artist: songModel.artist);
  //     mediaItems.add(mediaItem);
  //   }
  //   songs.value = songList;
  // }

  queryAlbum() async {}

}
