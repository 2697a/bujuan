import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class GlobalController extends SuperController {
  final playState = PlayState.STOP.obs;
  final playPos = 0.obs;
  final playMode = 1.obs;
  final song = MusicItem(
          musicId: '-99',
          duration: 6000,
          title: '暂无歌曲',
          artist: '暂无',
          iconUri:
              'https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg')
      .obs;
  final lyric = LyricEntity().obs; //音质
  final playList = [].obs;
  final playListMode = PlayListMode.SONG.obs;
  ScrollController scrollController;

  static GlobalController get to => Get.find();

  @override
  void onInit() {
    lyric.value = null;
    scrollController = ScrollController();
    super.onInit();
  }

  void addSliderListener(weSlideController) {
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        Get.find<HomeController>().resumeStream();
      } else {
        Get.find<HomeController>().pauseStream();
      }
    });
  }

  ///获取当前播放歌曲
  void getNowPlaying() async {
    var musicItem = await Starry.getNowPlaying();
    song.value = musicItem;
  }

  ///滚动到指定位置
  scrollToIndex() {
    var indexWhere =
        playList.indexWhere((element) => element.musicId == song.value.musicId);
    if (indexWhere > -1) scrollController?.jumpTo(indexWhere * 52.0);
  }

  playMusicByIndex(index) {
    Starry.playMusicByIndex(index);
    Get.back();
  }

  ///更改当前播放列表
  addPlayList(list) async {
    playList
      ..clear()
      ..addAll(list);
  }

  ///更新当前歌曲(弃用)
  changeSong(MusicItem song) async {
    this.song.value = song;
  }

  ///播放或暂停
  playOrPause() async {
    // if (playState.value == PlayState.ERROR || playState.value == PlayState.STOP)
    //   return;
    if (song.value.musicId == '-99') return;
    if (playState.value == PlayState.PLAYING) {
      await Starry.pauseMusic();
    } else {
      await Starry.restoreMusic();
    }
  }

  ///设置播放模式
  changePlayMode() {
    //1->2->3
    var value = 1;
    switch (playMode.value) {
      case 1:
        value = 2;
        break;
      case 2:
        value = 3;
        break;
      case 3:
        value = 1;
        break;
    }
    Starry.setPlayMode(value);
  }

  likeOrUnLike() {
    var contains = HomeController.to.likeSongs.contains(song.value.musicId);
    NetUtils().likeOrUnlike(song.value.musicId, !contains).then((value) {
      ///操作成功
      if (value) {
        if (contains) {
          ///不喜欢成功
          HomeController.to.likeSongs.remove(song.value.musicId);
        } else {
          ///喜欢成功
          HomeController.to.likeSongs.add(song.value.musicId);
        }
        UserController.to.getUserSheet(forcedRefresh: true);
        SpUtil.putStringList(
            LIKE_SONGS, HomeController.to.likeSongs.toList().cast<String>());
      }
    });
  }

  ///上一首
  skipToPrevious() async {
    await Starry.skipToPrevious();
  }

  ///下一首
  skipToNext() async {
    await Starry.skipToNext();
  }

  ///播放跳转
  seekTo(int seek) async {
    await Starry.changeSongSeek(seek);
  }

  @override
  void onClose() {
    scrollController?.dispose();
    super.onClose();
  }

  @override
  void onDetached() {
    print('onDetached');
  }

  @override
  void onInactive() {
    print('onInactive');
  }

  @override
  void onPaused() {
    print('onPaused');
  }

  @override
  void onResumed() {
    print('onResumed');
  }
}
