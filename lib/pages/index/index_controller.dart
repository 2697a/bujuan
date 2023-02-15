import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // var status = await Permission.manageExternalStorage.status;
      // if (!status.isGranted) {
      //   await Permission.manageExternalStorage.request();
      // }
      // if (status.isGranted) {
      //   _getCache();
      // }
    });
  }

  _getCache() async {
    Directory directory = Directory('/storage/emulated/0/netease/cloudmusic/Cache/Music1');
    List<FileSystemEntity> files = directory.listSync().where((element) => element.path.contains('uc')).toList();
    File file = File(files[0].path);
    print('object========${file.path}');
    Uint8List uint8list = Uint8List.fromList(file.readAsBytesSync().map((e) => e ^ 0xa3).toList());
    File file1 = File(files[0].path.replaceAll('.uc!', ''));
    print('object========${file1.path}');
    file1.createSync();
    file1.writeAsBytes(uint8list);
  }

  Future<PersonalizedPlayListWrap> getSheetData() async {
    return await NeteaseMusicApi().personalizedPlaylist();
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
