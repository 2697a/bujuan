 import 'package:audio_service/audio_service.dart';

abstract class AudioPlayerHandler implements AudioHandler {
  // 添加公共方法
  Future<void> changeQueueLists(List<MediaItem> list);

  // 改变播放列表
  Future<void> readySongUrl();

  // 获取歌曲url
  Future<void> playIndex(int index);

  // 从下标播放
  Future<void> addFmItems(List<MediaItem> mediaItems, bool isAddcurIndex);
// 私人fm
}
