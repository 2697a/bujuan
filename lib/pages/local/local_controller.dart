import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/constants/enmu.dart';

class Local extends GetxController {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  OnAudioQuery query = GetIt.instance<OnAudioQuery>();
  RxBool loading = true.obs;
  RxBool loadingSong = true.obs;
  RxList<AlbumModel> albums = <AlbumModel>[].obs;
  RxList<ArtistModel> artists = <ArtistModel>[].obs;
  RxList<MediaItem> songs = <MediaItem>[].obs;
  Directory? directory;
  late BuildContext context;
  final List<AlbumModel> albumsAll = <AlbumModel>[];
  final List<ArtistModel> artistsAll = <ArtistModel>[];

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //不是获取歌曲的
      _getAlbumAndArtists();
    });
  }

  static Local get to => Get.find();

  getLocalSong() async {
    String type = context.routeData.queryParams.getString('type');
    var songList = await compute(getSongs, IsolateData(rootIsolateToken, query, directory, type: type, id: context.routeData.queryParams.getInt('id')));
    songs
      ..clear()
      ..addAll(songList);
    loadingSong.value = false;
  }

  _getAlbumAndArtists() async {
    directory = await getExternalStorageDirectory();
    bool permissionsRequest = await query.permissionsRequest();
    if (permissionsRequest) {
      var albumList = await compute(getAlbum, IsolateData(rootIsolateToken, query, directory));
      albumsAll
        ..clear()
        ..addAll(albumList);
      if (albumList.length > 8) albumList = albumList.sublist(0, 8);
      albums
        ..clear()
        ..addAll(albumList);
      var artistList = await compute(getArtists, IsolateData(rootIsolateToken, query, directory));
      artistsAll
        ..clear()
        ..addAll(artistList);
      if (artistList.length > 3) artistList = artistList.sublist(0, 3);
      artists
        ..clear()
        ..addAll(artistList);
      loading.value = false;
    }
  }
}

Future<List<AlbumModel>> getAlbum(IsolateData isolateData) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.rootIsolateToken);
  if (isolateData.directory == null) return [];
  List<AlbumModel> albums = await isolateData.onAudioQuery.queryAlbums();
  Directory directory = Directory('${isolateData.directory?.path}/albums');
  if (!directory.existsSync()) directory.createSync();
  for (var album in albums) {
    File file = File('${directory.path}/${album.id}.jpeg');
    if (!await file.exists()) {
      Uint8List? byteData = await isolateData.onAudioQuery.queryArtwork(album.id, ArtworkType.ALBUM, size: 300, format: ArtworkFormat.JPEG);
      if (byteData != null) {
        await file.create();
        await file.writeAsBytes(byteData);
      }
    }
  }
  return albums;
}

Future<List<ArtistModel>> getArtists(IsolateData isolateData) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.rootIsolateToken);
  if (isolateData.directory == null) return [];
  List<ArtistModel> artists = await isolateData.onAudioQuery.queryArtists();
  Directory directory = Directory('${isolateData.directory?.path}/artists');
  if (!directory.existsSync()) directory.createSync();
  for (var artist in artists) {
    File file = File('${directory.path}/${artist.id}.jpeg');
    if (!await file.exists()) {
      Uint8List? byteData = await isolateData.onAudioQuery.queryArtwork(artist.id, ArtworkType.ARTIST, size: 300, format: ArtworkFormat.JPEG);
      if (byteData != null) {
        await file.create();
        await file.writeAsBytes(byteData);
      }
    }
  }
  return artists;
}

Future<List<MediaItem>> getSongs(IsolateData isolateData) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.rootIsolateToken);
  if (isolateData.directory == null) return [];
  List<SongModel> songs;
  if (isolateData.type == 'all') {
    songs = await isolateData.onAudioQuery.querySongs();
  } else {
    songs = await isolateData.onAudioQuery.queryAudiosFrom(isolateData.type == 'album' ? AudiosFromType.ALBUM_ID : AudiosFromType.ARTIST_ID, isolateData.id ?? 0);
  }
  Directory directory = Directory('${isolateData.directory?.path}/albums');
  return songs
      .map((e) => MediaItem(
          id: '${e.id}',
          duration: Duration(milliseconds: e.duration ?? 0),
          artUri: Uri.file('${directory.path}/${e.albumId}.jpeg'),
          extras: {
            'url': e.data,
            'image': '${directory.path}/${e.albumId}.jpeg',
            'liked': false,
            'artist': '',
            'mv': 0,
            'type': MediaType.local.name,
          },
          title: e.title,
          album: e.album,
          artist: e.artist))
      .toList();
}

class IsolateData {
  RootIsolateToken rootIsolateToken;
  OnAudioQuery onAudioQuery;
  Directory? directory;
  int? id;
  String? type;

  IsolateData(this.rootIsolateToken, this.onAudioQuery, this.directory, {this.id, this.type});
}
