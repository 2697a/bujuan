import 'dart:io';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/art_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

import '../main.dart';

class GlobalController extends SuperController {
  final playState = PlayState.STOP.obs;
  var playPos = 0;
  final playMode = 1.obs;
  final song = MusicItem(
          musicId: '-99',
          duration: 6000,
          title: '暂无歌曲',
          artist: '暂无',
          iconUri:
              'https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg')
      .obs;
  var lyric; //音质
  final playList = [].obs;
  final playListMode = PlayListMode.SONG.obs;
  ScrollController scrollController;

  static GlobalController get to => Get.find();

  @override
  void onInit() {
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
    if (playListMode.value == PlayListMode.SONG) {
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
  }

  likeOrUnLike() {
    if (song.value.musicId == '-99') return;
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
    if (playListMode.value == PlayListMode.SONG) {
      await Starry.skipToPrevious();
    }
  }

  ///下一首
  skipToNext() async {
    await Starry.skipToNext();
  }

  ///播放跳转
  seekTo(int seek) async {
    await Starry.changeSongSeek(seek);
  }

  ///获取本地音乐图片
  Widget getLocalImage() {
    return Get.find<FileService>().version.value >= 29
        ? ArtworkWidget(
            id: int.parse(song.value.musicId),
            artworkHeight: 50.0,
            artworkWidth: 50.0,
            type: ArtworkType.AUDIO,
          )
        : song.value.iconUri != null && song.value.iconUri.split('?').length > 0
            ? Image.file(File(song.value.iconUri.split('?')[0]))
            : Icon(
                Icons.image_not_supported,
                size: 50.0,
              );
  }


  ///听歌打卡
  scrobble() {
    if (SpUtil.getInt(PLAY_SONG_SHEET_ID, defValue: -999) > 0) {
      NetUtils()
          .scrobble(song.value.musicId, SpUtil.getInt(PLAY_SONG_SHEET_ID),
              DateTime.now().second)
          .then((value) {
        var text = '听歌打卡失败';
        if (value) text = '听歌打卡成功';
        Get.defaultDialog(
            title: '听歌打卡',
            content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Center(
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Text(
                        text,
                        style: TextStyle(color: Colors.blue, fontSize: 16.0),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                      Text(
                        '(请不要频繁请求！)',
                        style: TextStyle(fontSize: 14.0),
                      )
                    ],
                  ),
                )),
            textConfirm: '确定',
            buttonColor: Theme.of(Get.context).cardColor,
            onConfirm: () => Get.back());
      });
    } else {
      Get.defaultDialog(
          title: '听歌打卡',
          content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      '该歌曲不支持听歌打卡',
                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                    ),
                  ],
                ),
              )),
          textConfirm: '确定',
          buttonColor: Theme.of(Get.context).cardColor,
          onConfirm: () => Get.back());
    }
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
class TimingData {
  var format;
  var value;
  var name;

  TimingData(this.format, this.value, this.name);
}