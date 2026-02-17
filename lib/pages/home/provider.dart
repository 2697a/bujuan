import 'package:audio_service/audio_service.dart';
import 'package:bujuan_music_api/api/recommend/entity/recommend_song_entity.dart'; // 改用旧实体
import 'package:bujuan_music_api/api/recommend/entity/recommend_resource_entity.dart';
import 'package:bujuan_music_api/api/top/entity/top_artist_entity.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<HomeData> newAlbum(Ref ref) async {
  var recommendResourceFuture = BujuanMusicManager().recommendResource();
  var songsFuture = BujuanMusicManager().recommendSongs(); // 改用旧方法
  var topArtistFuture = BujuanMusicManager().topArtist(limit: 10);
  var recommendSongFuture = BujuanMusicManager().recommendSongs(); // 改用旧方法

  var list = await Future.wait([
    recommendResourceFuture,
    topArtistFuture,
    songsFuture,
    recommendSongFuture,
  ]);
  return compute(_buildHomeData, list);
}

HomeData _buildHomeData(List list) {
  var playlist = list[0] as RecommendResourceEntity;
  var listArtist = list[1] as TopArtistEntity;
  var songEntity = list[2] as RecommendSongEntity; // 改用旧实体
  var recommendSongEntity = list[3] as RecommendSongEntity; // 改用旧实体

  var songs = songEntity.data?.dailySongs ?? [];

  var medias = songs
      .map(
        (e) => MediaItem(
          id: '${e.id}',
          title: e.name ?? "",
          duration: Duration(milliseconds: e.dt ?? 0),
          artist: (e.ar ?? []).map((ar) => ar.name).toList().join(' '),
          artUri: Uri.parse(e.al?.picUrl ?? ''),
          extras: {'mv': e.mv ?? 0},
        ),
      )
      .toList();

  var recommend = recommendSongEntity.data?.dailySongs ?? [];
  return HomeData(
    playlist,
    listArtist,
    medias,
    recommend.isEmpty ? '' : recommend.first.al?.picUrl ?? '',
  );
}

@riverpod
Future<List<MediaItem>> recommendSongs(Ref ref) async {
  var recommendSongEntity = await BujuanMusicManager().recommendSongs(); // 改用旧方法
  var list = recommendSongEntity?.data?.dailySongs ?? [];
  return list
      .map(
        (e) => MediaItem(
          id: '${e.id}',
          title: e.name ?? "",
          duration: Duration(milliseconds: e.dt ?? 0),
          artist: (e.ar ?? []).map((e) => e.name).toList().join(' '),
          artUri: Uri.parse(e.al?.picUrl ?? ''),
          extras: {'mv': e.mv ?? 0},
        ),
      )
      .toList();
}

class HomeData {
  RecommendResourceEntity recommendResourceEntity;
  TopArtistEntity topArtistEntity;
  List<MediaItem> medias;
  String image;

  HomeData(this.recommendResourceEntity, this.topArtistEntity, this.medias, this.image);
}
