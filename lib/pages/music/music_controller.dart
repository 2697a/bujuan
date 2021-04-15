import 'dart:io';

import 'package:bujuan/main.dart';
import 'package:bujuan/widget/art_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicController extends GetxController {
  var artists = [].obs;
  var albums = [].obs;
  final isNoAlbum = false.obs;
  final isNoArtists = false.obs;
  var isLoad = false;
  RefreshController refreshController;

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getAllArtists() async {
    OnAudioQuery()
        .queryArtists(ArtistSortType.DEFAULT, OrderType.ASC_OR_SMALLER,
            UriType.EXTERNAL, true)
        .then((value) {
      artists.clear();
      value.forEach((element) {
        if (element.artistName != "<unknown>") {
          artists.add(element);
        }
      });
      if (artists.length == 0)
        isNoArtists.value = true;
      else
        isNoArtists.value = false;
    });
    getAllAlbum();
  }

  getAllAlbum() {
    OnAudioQuery()
        .queryAlbums(AlbumSortType.DEFAULT, OrderType.ASC_OR_SMALLER,
            UriType.EXTERNAL, true)
        .then((value) {
      albums.clear();
      isLoad = true;
      value.forEach((element) {
        if (element.artist != "<unknown>") {
          albums.add(element);
        }
      });
      if (albums.length == 0)
        isNoAlbum.value = true;
      else
        isNoAlbum.value = false;
      refreshController?.refreshCompleted();
    });
  }

  Widget getLocalImage(AlbumModel albumModel, double size) {
    return Get.find<FileService>().version.value >= 29
        ? ArtworkWidget(
            artworkBorder: BorderRadius.circular(0),
            artworkHeight: size,
            artworkWidth: size,
            id: albumModel.id,
            type: ArtworkType.ALBUM,
          )
        : albumModel.artwork != null && albumModel.artwork.split('?').length > 0
            ? Image.file(
                File(
                  albumModel.artwork.split('?')[0],
                ),
                width: size,
                height: size)
            : Icon(
                Icons.image_not_supported,
                size: size,
              );
  }
}
