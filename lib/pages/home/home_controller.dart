import 'dart:async';

import 'package:bujuan/api/netease_cloud_music.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/pages/find/find_view.dart';
import 'package:bujuan/pages/search/search_view.dart';
import 'package:bujuan/pages/top/top_controller.dart';
import 'package:bujuan/pages/top/top_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/net_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/keep.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';
import 'package:we_slide/we_slide.dart';

class HomeController extends SuperController {
  var currentIndex = 1.obs;
  var currentIndex1 = 1.obs;
  var userProfileEntity = UserProfileEntity().obs;
  var isSystemTheme = true.obs;
  PreloadPageController pageController;
  WeSlideController weSlideController;
  StreamSubscription _streamSubscription;
  var login = false.obs;
  var scroller = false.obs;
  final pages = [
    KeepAliveWrapper(child: UserView()),
    KeepAliveWrapper(child: FindView()),
    KeepAliveWrapper(child: TopView()),
    KeepAliveWrapper(child: SearchView()),
  ];

  @override
  void onInit() {
    userProfileEntity.value = null;
    pageController = PreloadPageController(initialPage: currentIndex.value);
    isSystemTheme.value = SpUtil.getBool(IS_SYSTEM_THEME_SP, defValue: true);
    weSlideController = WeSlideController();
    login.value = !GetUtils.isNullOrBlank(SpUtil.getString(USER_ID_SP));
    scroller.value = SpUtil.getBool(OPEN_SCROLL, defValue: false);
    super.onInit();
    // SpUtil.putBool(IS_FIRST_OPEN, false);
  }

  @override
  void onReady() {
    Starry.init(url: SongUrl(getSongUrl: (id) async {
      return await NetUtils().getSongUrl(id);
    }));
    refreshLogin();
    _listenerStarry();
    weSlideController.addListener(() {
      if (weSlideController.isOpened) {
        resumeStream();
      } else {
        pauseStream();
      }
    });
    super.onReady();
  }

  void pauseStream() {
    if (_streamSubscription != null && !_streamSubscription.isPaused) _streamSubscription.pause();
  }

  void resumeStream() {
    if (_streamSubscription != null && _streamSubscription.isPaused) {
      _streamSubscription.resume();
    } else {
      _streamSubscription = Starry.eventChannel.receiveBroadcastStream().listen((pos) {
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
    weSlideController = null;
    super.onClose();
  }

  void changeIndex(int index) {
    if (!login.value && index == 0) {
      goToLogin();
      return;
    }
    currentIndex.value = index;
    onPageChange(index);
    pageController.jumpToPage(index);
  }

  //监听播放音乐状态以及进度！
  _listenerStarry() {
    ///歌曲发生变化
    Starry.onPlayerSongChanged.listen((MusicItem songInfo) async {
      var lyricEntity = await NetUtils().getMusicLyric(songInfo.musicId);
      Get.find<GlobalController>().lyric.value = lyricEntity;
      Get.find<GlobalController>().song.value = songInfo;
      // SpUtil.putString(LAST_PLAY_INFO, jsonEncode(songInfo));
    });
    ///播放状态发生变化
    Starry.onPlayerStateChanged.listen((PlayState playState) {
      Get.find<GlobalController>().playState.value = playState;
      if (playState == PlayState.ERROR) Get.find<GlobalController>().skipToNext();
    });

    ///播放列表发生变化
    Starry.onPlayerSongListChanged.listen((PlayListInfo playListInfo) async {
      Get.find<GlobalController>().addPlayList(playListInfo.playlist);
      var currSong = playListInfo.playlist[playListInfo.position];
      Get.find<GlobalController>().song.value = currSong;
      var lyric = Get.find<GlobalController>().lyric.value;
      if (lyric == null) {
        var lyricEntity = await NetUtils().getMusicLyric(currSong.musicId);
        Get.find<GlobalController>().lyric.value = lyricEntity;
      }
    });

    ///b
    Starry.onPlayerModeChanged.listen((value) {
      if (value != null) {
        Get.find<GlobalController>().playMode.value = value;
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
        await getUserProfile(SpUtil.getString(USER_ID_SP, defValue: null));
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
    if(profile!=null&&profile.code==200){
      userProfileEntity.value = profile;
      login.value = true;
    }else{
      if (await BuJuanUtil.checkFileExists(CACHE_USER_PROFILE)) {
        debugPrint("用户资料已缓存，获取失败用缓存");
        var data = await BuJuanUtil.readStringFile(CACHE_USER_PROFILE);
        if (data != null) {
          userProfileEntity.value = UserProfileEntity.fromJson(Map<String, dynamic>.from(data));
          login.value = true;
        }
      }
    }
  }

  @override
  void didChangePlatformBrightness() {
    if (isSystemTheme.value) {
      Get.changeTheme(!Get.isPlatformDarkMode ? lightTheme : darkTheme);
      Future.delayed(Duration(milliseconds: 300), () => SystemChrome.setSystemUIOverlayStyle(BuJuanUtil.setNavigationBarTextColor(Get.isPlatformDarkMode)));
    }
    super.didChangePlatformBrightness();
  }

  onPageChange(index) {
    if (index != currentIndex.value) {
      Future.delayed(Duration(microseconds: 500), () {
        var userController = Get.find<UserController>();
        var topController = Get.find<TopController>();
        if (index == 0 && !userController.isLoad) {
          userController.getUserSheet();
        } else if (index == 2 && !topController.isLoad) {
          topController.getData();
        }
      });
    }
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
