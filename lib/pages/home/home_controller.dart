import 'dart:async';

import 'package:bujuan/api/lyric/lyric_util.dart';
import 'package:bujuan/api/lyric/lyric_view.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/pages/find/find_controller.dart';
import 'package:bujuan/pages/find/find_view.dart';
import 'package:bujuan/pages/search/search_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/timer/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class HomeController extends SuperController {
  var currentIndex = 1;
  var userId = '';
  final userProfileEntity = UserProfileEntity().obs;
  final isSystemTheme = true.obs;
  PreloadPageController pageController;
  StreamSubscription _streamSubscription;
  final login = false.obs;
  final likeSongs = [].obs;
  var miniPlayView = false;
  var secondPlayView = false;
  final pages = [UserView(), FindView()];
  CountdownController countdownController;
  var sleepTime = 0;
  var selectIndex = 99;
  final data = [
    TimingData("分钟", 10 * 60, "10"),
    TimingData("分钟", 20 * 60, "20"),
    TimingData("分钟", 30 * 60, "30"),
    TimingData("分钟", 45 * 60, "45"),
    TimingData("小时", 60 * 60, "1"),
    TimingData("小时", 1.5 * 60 * 60, "1.5"),
    TimingData("小时", 2 * 60 * 60, "2"),
    TimingData("小时", 2.5 * 60 * 60, "2.5"),
    TimingData("小时", 3 * 60 * 60, "3"),
    TimingData("小时", 4 * 60 * 60, "4")
  ];
  final itmes = ['我的', '首页'];

  static HomeController get to => Get.find();

  @override
  void onInit() {
    userId = SpUtil.getString(USER_ID_SP);
    miniPlayView = SpUtil.getBool(MINI_PLAY_VIEW, defValue: false);
    secondPlayView = SpUtil.getBool(SECOND_PLAY_VIEW, defValue: false);
    login.value = !GetUtils.isNullOrBlank(userId);
    countdownController = CountdownController();
    GlobalController.to.playListMode.value =
        PlayListMode.values[SpUtil.getInt(PLAY_LIST_MODE, defValue: 0)];
    userProfileEntity.value = null;
    currentIndex = SpUtil.getInt(HOME_INDEX, defValue: 1);
    pageController = PreloadPageController(initialPage: currentIndex);
    isSystemTheme.value = SpUtil.getBool(IS_SYSTEM_THEME_SP, defValue: true);
    _streamSubscription =
        Starry.eventChannel.receiveBroadcastStream().listen((pos) {
      if (pos != null) {
        GlobalController.to.changePosition(pos);
        // update(['play_pos']);
      }
    }, cancelOnError: true);

    ///获取歌曲播放地址
    Starry.init(url: SongUrl(getSongUrl: (id) async {
      return await NetUtils().getSongUrl(id);
    }));
    _listenerStarry();
    super.onInit();
    // SpUtil.putBool(IS_FIRST_OPEN, false);
  }

  @override
  void onReady() {
    OnAudioQuery().queryPlaylists(PlaylistSortType.DATA_ADDED,
        OrderType.ASC_OR_SMALLER, UriType.EXTERNAL, true);
    changeSleepIndex(SpUtil.getInt(SLEEP_INDEX, defValue: 99));

    refreshLogin();
    getLikeSongList();
    super.onReady();
  }

  getLikeSongList() {
    var likeSong = SpUtil.getStringList(LIKE_SONGS, defValue: []);
    if (likeSong.length > 0) {
      ///之前获取过了
      likeSongs
        ..clear()
        ..addAll(likeSong);
    } else {
      ///未获取过喜欢的歌曲
      if (login.value)
        NetUtils().getLikeSongs().then((value) {
          SpUtil.putStringList(LIKE_SONGS, value);
          likeSongs
            ..clear()
            ..addAll(value);
        });
    }
  }

  void pauseStream() {
    if (_streamSubscription != null && !_streamSubscription.isPaused)
      _streamSubscription.pause();
  }

  void resumeStream() {
    if (_streamSubscription != null && _streamSubscription.isPaused)
      _streamSubscription.resume();
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.onClose();
  }

  void changeIndex(int index) {
    pageController.jumpToPage(index);
    onPageChange(index);
  }

  //监听播放音乐状态以及进度！
  _listenerStarry() {
    ///歌曲发生变化
    Starry.onPlayerSongChanged.listen((PlayMusicInfo playMusicInfo) async {
      GlobalController.to.song.value = playMusicInfo.musicItem;
      // GlobalController.to.getLocalImage();

      if (GlobalController.to.playListMode.value != PlayListMode.RADIO &&
          GlobalController.to.playListMode.value != PlayListMode.LOCAL)
        NetUtils()
            .getMusicLyric(playMusicInfo.musicItem.musicId)
            .then((lyricEntity) {
          var formatLyric = LyricUtil.formatLyric(lyricEntity.lrc.lyric);
          GlobalController.to.lyrics
            ..clear()
            ..addAll(formatLyric);
          GlobalController.to.lyric.value = LyricContent.from(lyricEntity.lrc.lyric);
        });
      var playListMode = GlobalController.to.playListMode.value;
      var playList = GlobalController.to.playList;

      ///fm播放到倒数第二首了，删除之前所有的歌曲，添加新的歌曲
      if (playListMode == PlayListMode.FM &&
          playMusicInfo.position == playList.length - 2) {
        ///要删除的歌曲列表
        await Starry.removeSong(playList.length - 2);

        ///要添加的歌曲列表
        var addList = await getFM();
        await Starry.addSong(addList);
      }
    });

    ///播放状态发生变化
    Starry.onPlayerStateChanged.listen((PlayState playState) {
      GlobalController.to.playState.value = playState;
      if (playState == PlayState.ERROR) GlobalController.to.skipToNext();
    });

    ///播放列表发生变化
    Starry.onPlayerSongListChanged.listen((PlayListInfo playListInfo) async {
      if (!GetUtils.isNullOrBlank(playListInfo.playlist.length) &&
          playListInfo.playlist.length > 0) {
        GlobalController.to.addPlayList(playListInfo.playlist);
        var currSong = playListInfo.playlist[playListInfo.position];
        GlobalController.to.song.value = currSong;
        // GlobalController.to.getLocalImage();
        var lyric = Get.find<GlobalController>().lyric.value;
        if (lyric.size==0 &&
            GlobalController.to.playListMode.value != PlayListMode.RADIO &&
            GlobalController.to.playListMode.value != PlayListMode.LOCAL)
          NetUtils().getMusicLyric(currSong.musicId).then((lyricEntity) {
            var formatLyric = LyricUtil.formatLyric(lyricEntity.lrc.lyric);
            GlobalController.to.lyrics
              ..clear()
              ..addAll(formatLyric);
            GlobalController.to.lyric.value = LyricContent.from(lyricEntity.lrc.lyric);
          });
      }
    });

    ///播放模式发生变化
    Starry.onPlayerModeChanged.listen((value) {
      if (value != null) {
        GlobalController.to.playMode.value = value;
      }
    });

    ///睡眠状态发生变化
    Starry.onSleepStateChanged.listen((event) {
      sleepTime = event;
      update(['sleep', 'sleep_index']);
    });
  }

  ///去个人资料页面
  goToProfile() {
    if (login.value && userProfileEntity.value != null) {
      Get.toNamed('/profile', arguments: {'profile': userProfileEntity.value});
    } else {
      goToLogin();
    }
  }

  ///去登录页面
  goToLogin() {
    Get.toNamed('/login');
  }

  ///刷新登录
  refreshLogin() async {
    if (login.value) {
      await NetUtils().refreshLogin();
      // if (loginEntity != null && loginEntity['code'] == 200) {
      //刷新成功
      await getUserProfile(SpUtil.getString(USER_ID_SP, defValue: ''));
      // } else {
      //   ///太久未登录，重新登录吧！！！！！
      // }
    }
  }

  ///获取用户资料
  getUserProfile(userId,{isLogin = false}) async {
    var profile = await NetUtils().getUserProfile(userId);
    if (profile != null && profile.code == 200) {
      userProfileEntity.value = profile;
      login.value = true;
    } else {
      if (await BuJuanUtil.checkFileExists(CACHE_USER_PROFILE)) {
        var data = await BuJuanUtil.readStringFile(CACHE_USER_PROFILE);
        if (data != null) {
          userProfileEntity.value =
              UserProfileEntity.fromJson(Map<String, dynamic>.from(data));
          login.value = true;
        }
      }
    }

    if(isLogin){
      UserController.to.getUserSheet(forcedRefresh:true);
      HomeController.to.getLikeSongList();
    }
  }

  @override
  void didChangePlatformBrightness() {
    if (isSystemTheme.value) {
      Get.changeTheme(!Get.isPlatformDarkMode ? lightTheme : darkTheme);
      Future.delayed(
          Duration(milliseconds: 300),
          () => SystemChrome.setSystemUIOverlayStyle(
              BuJuanUtil.setNavigationBarTextColor(Get.isPlatformDarkMode)));
    }
    super.didChangePlatformBrightness();
  }

  ///页面发生变化
  onPageChange(index) {
    currentIndex = index;
    update(['bottom_bar']);
    Future.delayed(Duration(microseconds: 500), () {
      if (index == 0 && !UserController.to.isLoad) {
        UserController.to.getUserSheet();
      } else if (index == 1 && !FindController.to.isLoad) {
        FindController.to.loadTodaySheet();
      } else if (index == 2 && !SearchController.to.isLoad) {
        SearchController.to.getSearchList();
      }
    });
  }

  ///获取fm
  Future<List<MusicItem>> getFM() async {
    List<MusicItem> fmSong = [];
    var fmEntity = await NetUtils().getFm();
    if (fmEntity != null && fmEntity.code == 200) {
      fmEntity.data.forEach((track) {
        MusicItem musicItem = MusicItem(
          musicId: '${track.id}',
          duration: track.duration,
          iconUri: "${track.album.picUrl}",
          title: track.name,
          uri: '${track.id}',
          artist: track.artists[0].name,
        );
        fmSong.add(musicItem);
      });
    }
    return fmSong;
  }

  ///显示睡眠弹窗
  showSleepBottomSheet() {
    Get.bottomSheet(
        SizedBox(
          height: MediaQuery.of(Get.context).size.width / 5 * 2.15 + 60,
          child: GetBuilder<HomeController>(
            builder: (HomeController homeController) {
              return Column(
                children: [
                  SwitchListTile(
                    value: sleepTime > 0,
                    onChanged: (value) => closeSleep(),
                    title: Row(
                      children: [Text("定时停止播放")],
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    height: MediaQuery.of(Get.context).size.width / 5 * 2.15,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          crossAxisCount: 5, //每行三列
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                            child: Container(
                              color: selectIndex == index && sleepTime > 0
                                  ? Theme.of(context).accentColor
                                  : CardTheme.of(context).color,
                              padding: EdgeInsets.only(bottom: 6.0),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: Text("${data[index].name}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  )),
                                  Text(
                                    "${data[index].format}",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            countdownController
                                .setTimer(data[index].value.toInt());
                            changeSleepIndex(index, true);
                            Get.back();
                          },
                        );
                      },
                      itemCount: data.length,
                    ),
                  )
                ],
              );
            },
            init: HomeController(),
            id: 'sleep_index',
          ),
        ),
        backgroundColor: Theme.of(Get.context).primaryColor,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
        ));
  }

  ///设置睡眠
  changeSleepIndex(index, [isStart = false]) {
    if (index == 99) return;
    selectIndex = index;
    update(['sleep_index']);
    if (isStart) {
      SpUtil.putInt(SLEEP_INDEX, selectIndex);
      Starry.startTiming((data[index].value * 1000) ~/ 1);
    }
  }

  ///关闭睡眠
  closeSleep() {
    if (sleepTime > 0) {
      selectIndex = 99;
      SpUtil.putInt(SLEEP_INDEX, selectIndex);
      update(['sleep_index']);
      Starry.stopTiming();
    }
  }

  ///改变迷你播放页
  changeMiniPlayView(bool mini) {
    miniPlayView = mini;
    update(['view_type']);
  }
  ///改变迷你播放页
  changeSecondPlayView(bool mini) {
    secondPlayView = mini;
    update(['second_view']);
  }
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
