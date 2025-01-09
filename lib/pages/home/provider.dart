import 'package:bujuan_music_api/api/recommend/entity/recommend_resource_entity.dart';
import 'package:bujuan_music_api/api/song/entity/new_song_entity.dart';
import 'package:bujuan_music_api/api/top/entity/top_artist_entity.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/request_state.dart';

class HomeRequestState extends RequestState<HomeData> {
  HomeRequestState({super.isLoading, super.data, super.isError, super.isEmpty});

  @override
  HomeRequestState copyWith({bool? isLoading, HomeData? data, bool? isError, bool? isEmpty}) {
    return HomeRequestState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      isError: isError ?? this.isError,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}

class HomeData {
  final TopArtistEntity? topArtists;
  final RecommendResourceEntity? recommendResource;
  final NewSongEntity? newSongEntity;

  HomeData({this.topArtists, this.recommendResource, this.newSongEntity});

  HomeData copyWith({
    TopArtistEntity? topArtists,
    RecommendResourceEntity? recommendResource,
    NewSongEntity? newSongEntity,
  }) {
    return HomeData(
      topArtists: topArtists ?? this.topArtists,
      recommendResource: recommendResource ?? this.recommendResource,
      newSongEntity: newSongEntity ?? this.newSongEntity,
    );
  }
}

//定义 StateNotifier
class HomeRequestNotifier extends StateNotifier<HomeRequestState> {
  HomeRequestNotifier() : super(HomeRequestState()) {
    _fetchData();
  }

  refresh({bool showLoading = false}) async {
    await _fetchData(showLoading: showLoading, refresh: true);
    return true;
  }

  getSongUrl(String id){
    BujuanMusicManager().songUrl(ids: [id]);
  }

  Future<void> _fetchData({bool? showLoading, bool? refresh = false}) async {
    if (showLoading ?? true) {
      state = state.copyWith(isLoading: showLoading ?? true);
    }
    try {
      final topArtist = BujuanMusicManager().topArtist();
      final recommendResource = BujuanMusicManager().recommendResource();
      final newSongs = BujuanMusicManager().newSongs();
      final requestedList = await Future.wait([newSongs]);

      final newSongResponse = requestedList[0];
      // final recommendResourceResponse =
      //     requestedList[1] as RecommendResourceEntity?;
      // if (topArtistResponse == null) {
      //   if (refresh ?? false) return;
      //   throw Exception('加载失败');
      // }
      final homeData = HomeData(newSongEntity: newSongResponse);
      state = state.copyWith(isLoading: false, data: homeData, isError: false);
    } catch (e) {
      // state = state.copyWith(isLoading: false, isError: true);
    }
  }
}

// 创建 StateNotifierProvider
final homeProvider =
    StateNotifierProvider.autoDispose<HomeRequestNotifier, HomeRequestState>((ref) {
  // ref.onDispose(() {
  //   if (kDebugMode) {
  //     print('首页页面Provider被销毁了========');
  //   }
  // });
  return HomeRequestNotifier();
});
