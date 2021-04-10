import 'dart:async';

import 'package:bujuan/api/netease_cloud_music.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/pages/find/find_view.dart';
import 'package:bujuan/pages/music/music_view.dart';
import 'package:bujuan/pages/search/search_view.dart';
import 'package:bujuan/pages/top/top_controller.dart';
import 'package:bujuan/pages/top/top_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

class HomeController extends SuperController {
  final currentIndex = 1.obs;
  final currentIndex1 = 1.obs;
  final userProfileEntity = UserProfileEntity().obs;
  final isSystemTheme = true.obs;
  PreloadPageController pageController;
  StreamSubscription _streamSubscription;
  final login = false.obs;
  final scroller = false.obs;
  final likeSongs = [].obs;
  final pages = [UserView(), FindView(), TopView(), MusicView()];

  static HomeController get to => Get.find();

  @override
  void onInit() {
    userProfileEntity.value = null;
    pageController = PreloadPageController(initialPage: currentIndex.value);
    isSystemTheme.value = SpUtil.getBool(IS_SYSTEM_THEME_SP, defValue: true);
    login.value = !GetUtils.isNullOrBlank(SpUtil.getString(USER_ID_SP));
    scroller.value = SpUtil.getBool(OPEN_SCROLL, defValue: false);
    super.onInit();
    // SpUtil.putBool(IS_FIRST_OPEN, false);
  }

  @override
  void onReady() {
    ///获取歌曲播放地址
    Starry.init(url: SongUrl(getSongUrl: (id) async {
      return await NetUtils().getSongUrl(id);
    }));
    refreshLogin();
    _listenerStarry();
    var likeSong = SpUtil.getStringList(LIKE_SONGS, defValue: []);
    if (likeSong.length > 0) {
      ///之前获取过了
      likeSongs
        ..clear()
        ..addAll(likeSong);
    } else {
      ///未获取过喜欢的歌曲
      NetUtils().getLikeSongs().then((value) {
        SpUtil.putStringList(LIKE_SONGS, value);
        likeSongs
          ..clear()
          ..addAll(value);
      });
    }
    super.onReady();
  }

  void pauseStream() {
    if (_streamSubscription != null && !_streamSubscription.isPaused)
      _streamSubscription.pause();
  }

  void resumeStream() {
    if (_streamSubscription != null && _streamSubscription.isPaused) {
      _streamSubscription.resume();
    } else {
      _streamSubscription =
          Starry.eventChannel.receiveBroadcastStream().listen((pos) {
        if (pos != null) {
          Get.find<GlobalController>().playPos.value = pos;
        }
      }, cancelOnError: true);
    }
  }

  @override
  void onClose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.onClose();
  }

  void changeIndex(int index) {
    if (!login.value && index == 0) {
      goToLogin();
      return;
    }
    // if (index <= 3) {
      pageController.jumpToPage(index);
      onPageChange(index);
    // } else {
    //   Get.toNamed('/search');
    // }
  }

  //监听播放音乐状态以及进度！
  _listenerStarry() {
    ///歌曲发生变化
    Starry.onPlayerSongChanged.listen((PlayMusicInfo playMusicInfo) async {
      Get.find<GlobalController>().song.value = playMusicInfo.musicItem;
      NetUtils()
          .getMusicLyric(playMusicInfo.musicItem.musicId)
          .then((lyricEntity) {
        GlobalController.to.lyric.value = lyricEntity;
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
      GlobalController.to.addPlayList(playListInfo.playlist);
      var currSong = playListInfo.playlist[playListInfo.position];
      GlobalController.to.song.value = currSong;
      var lyric = Get.find<GlobalController>().lyric.value;
      if (lyric == null)
        NetUtils().getMusicLyric(currSong.musicId).then((lyricEntity) {
          GlobalController.to.lyric.value = lyricEntity;
        });
    });

    ///b
    Starry.onPlayerModeChanged.listen((value) {
      if (value != null) {
        GlobalController.to.playMode.value = value;
      }
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
      getUserProfile(SpUtil.getString(USER_ID_SP, defValue: ''));
      // } else {
      //   ///太久未登录，重新登录吧！！！！！
      // }
    }
  }

  changeBottomState() {
    scroller.value = !scroller.value;
    pageController.jumpToPage(1);
    currentIndex.value = 1;
    SpUtil.putBool(OPEN_SCROLL, scroller.value);
  }

  getUserProfile(userId) async {
    var profile = await NetUtils().getUserProfile(userId);
    if (profile != null && profile.code == 200) {
      userProfileEntity.value = profile;
      login.value = true;
    } else {
      if (await BuJuanUtil.checkFileExists(CACHE_USER_PROFILE)) {
        debugPrint("用户资料已缓存，获取失败用缓存");
        var data = await BuJuanUtil.readStringFile(CACHE_USER_PROFILE);
        if (data != null) {
          userProfileEntity.value =
              UserProfileEntity.fromJson(Map<String, dynamic>.from(data));
          login.value = true;
        }
      }
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

  onPageChange(index) {
    if (index != currentIndex.value) {
      currentIndex.value = index;
      // Future.delayed(Duration(microseconds: 500), () {
      var userController = Get.find<UserController>();
      var topController = Get.find<TopController>();
      if (index == 0 && !userController.isLoad) {
        userController.getUserSheet();
      } else if (index == 2 && !topController.isLoad) {
        topController.getData();
      } else if (index == 3) {
        // Get.find<MusicController>().getAllArtists();
      }
      // });
    }
  }

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

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
