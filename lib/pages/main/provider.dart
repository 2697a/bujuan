import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/player/bujuan_player.dart';
import '../../common/request_state.dart';

class MainState extends RequestState<MainData> {
  MainState({super.isLoading, super.data, super.isError, super.isEmpty});

  @override
  MainState copyWith({bool? isLoading, MainData? data, bool? isError, bool? isEmpty}) {
    return MainState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      isError: isError ?? this.isError,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}

class MainData {
  final List<MediaItem>? playlist;
  final MediaItem? mediaItem;
  final Duration? position;
  final Duration? buffer;
  final bool? buffering;

  MainData({this.position, this.buffer, this.buffering, this.playlist, this.mediaItem});

  MainData copyWith(
      {List<MediaItem>? playlist,
      MediaItem? mediaItem,
      Duration? position,
      Duration? buffer,
      bool? buffering}) {
    return MainData(
      playlist: playlist ?? this.playlist,
      mediaItem: mediaItem ?? this.mediaItem,
      position: position ?? this.position,
      buffering: buffering ?? this.buffering,
    );
  }
}

//定义 StateNotifier
class MainNotifier extends StateNotifier<MainState> with BujuanPlayerListener {
  MainNotifier() : super(MainState()) {
    _fetchData();
  }

  final ProviderContainer providerContainer = ProviderContainer();

  refresh({bool showLoading = false}) async {
    await _fetchData(showLoading: showLoading, refresh: true);
    return true;
  }

  getSongUrl(String id) {
    BujuanMusicManager().songUrl(ids: [id]);
  }

  Future<void> _fetchData({bool? showLoading, bool? refresh = false}) async {
    if (showLoading ?? true) {
      state = state.copyWith(isLoading: false);
    }
    BujuanPlayer().onPlaylistChange(this);
    await BujuanPlayer().addQueueItems([
      MediaItem(id: '2652741529', title: '地球最后的夜晚'),
      MediaItem(id: '2650827769', title: '茶花开了 (Live版)'),
      MediaItem(id: '2651495968', title: '心之科学 (live)'),
      MediaItem(id: '2652314966', title: 'DISAPPOINTED'),
      MediaItem(id: '2651767054', title: '雨街'),
      MediaItem(id: '2651498754', title: '今夜你会不会来'),
    ]);
    // await BujuanPlayer().playIndex(0);
  }

  @override
  void onPlaylistChange(List<MediaItem> playlist) {
    print('onPlaylistChange================${playlist.length}');
    providerContainer.refresh(playlistProvider.notifier).state = playlist;
  }

  @override
  void onMediaItemChange(MediaItem? mediaItem) {
    state = state.copyWith(data: (state.data ?? MainData()).copyWith(mediaItem: mediaItem));
  }

  @override
  void onPlaybackState(PlaybackState playbackState) {
    // log('onPlaybackState==========${playbackState.toString()}');
  }

  @override
  void onPositionChange(Duration duration) {
    // ref.refresh(positionProvider.notifier).state = duration;
  }

  @override
  void isBuffering(bool buffering) {
    // TODO: implement isBuffering
  }

  @override
  void onBufferChange(Duration duration) {
    // TODO: implement onBufferChange
  }
}

// 创建 StateNotifierProvider
final mainProvider = StateNotifierProvider.autoDispose<MainNotifier, MainState>((ref) {
  // ref.onDispose(() {
  //   if (kDebugMode) {
  //     print('首页页面Provider被销毁了========');
  //   }
  // });
  return MainNotifier();
});

final positionProvider = StateProvider((ref) => Duration.zero);
final playlistProvider = StateProvider((ref) => []);
