import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan_music_api/api/song/entity/song_url_entity.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:media_kit/media_kit.dart';

class BujuanPlayer extends BaseAudioHandler with SeekHandler, QueueHandler {
  // 单例模式实现
  static final BujuanPlayer _instance = BujuanPlayer._internal();

  factory BujuanPlayer() => _instance;

  final Player _player = Player();

  BujuanPlayer._internal();

  BujuanPlayer onPlaylistChange(BujuanPlayerListener b) {
    queue.listen((List<MediaItem> playlist) => b.onPlaylistChange(playlist));
    mediaItem.listen((MediaItem? mediaItem) {
      int index = queue.value.indexWhere((e) => e.id == mediaItem?.id);
      playbackState.add(playbackState.value.copyWith(queueIndex: index));
      b.onMediaItemChange(mediaItem);
    });
    playbackState.listen((PlaybackState playbackState) => b.onPlaybackState(playbackState));

    _player.stream
      ..completed.listen((_) {
        if (_) {
          skipToNext();
        }
      })
      ..duration.listen((Duration d) {
        mediaItem.add(mediaItem.value?.copyWith(duration: d));
      })
      ..buffer.listen((_) => b.onBufferChange(_))
      ..buffering.listen((_) => b.isBuffering(_))
      ..error.listen((String e) {
        print('error===================$e');
      })
      ..position.listen((_) => b.onPositionChange(_));
    return this;
  }

  Future<void> playIndex(int index) async {
    mediaItem.add(queue.value[index]);
    await play();
  }

  @override
  Future<void> seek(Duration position) {
    _player.seek(position);
    return super.seek(position);
  }

  @override
  Future<void> pause() async => await _player.pause();

  @override
  Future<void> play() async {
    MediaItem? media = mediaItem.value;
    if (media != null) {
      String url = await getSongUrl(media.id) ?? '';
      if (url.isEmpty) {
        skipToNext();
        return;
      }
      print('object===============$url');
      await _player.open(Media(url));
    }
  }

  @override
  Future<void> skipToNext() async {
    log('skipToNext');
    int index = queue.value.indexWhere((e) => e.id == mediaItem.value?.id);
    mediaItem.add(queue.value[index + 1]);
    play();
  }

  @override
  Future<void> skipToPrevious() async {}

  Future<String?> getSongUrl(String id) async {
    SongUrlEntity? songUrlEntity = await BujuanMusicManager().songUrl(ids: [id]);
    if (songUrlEntity != null && (songUrlEntity.data ?? []).isNotEmpty) {
      return songUrlEntity.data?[0].url;
    }
    return null;
  }
}

mixin BujuanPlayerListener {
  void onPlaylistChange(List<MediaItem> playlist);

  void onPositionChange(Duration duration);

  void onBufferChange(Duration duration);

  void isBuffering(bool buffering);

  void onMediaItemChange(MediaItem? mediaItem);

  void onPlaybackState(PlaybackState playbackState);
}

//准备
enum PlayStateEvent {
  loading,
  loaded,
}
