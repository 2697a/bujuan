import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/lyric_parser/parser_lrc.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/pages/home/second/second_body_view.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/widget/weslide/weslide_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

// import 'package:on_audio_query/on_audio_query.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../common/lyric_parser/lyrics_reader_model.dart';
import '../../routes/router.dart';
import 'first/first_view.dart';

class HomeController extends SuperController with GetSingleTickerProviderStateMixin {
  final String weSlideUpdate = 'weSlide';
  double panelHeaderSize = 90.h;
  double secondPanelHeaderSize = 120.w;
  double panelMobileMinSize = 90.h;
  double topBarHeight = 110.h;
  final List<LeftMenu> leftMenus = [
    LeftMenu('个人中心', TablerIcons.user, Routes.user, '/home/user'),
    LeftMenu('推荐歌单', TablerIcons.smartHome, Routes.index, '/home/index'),
    LeftMenu('个人云盘', TablerIcons.cloud, Routes.search, '/home/search'),
  ];

  final List<BottomItem> bottomItems = [
    BottomItem(TablerIcons.playlist, 0),
    BottomItem(TablerIcons.quote, 1),
  ];

  RxString currPathUrl = '/home/user'.obs;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  RxInt selectIndex = 0.obs;

  RxDouble slidePosition = 0.0.obs;
  RxDouble slidePosition1 = 0.0.obs;
  Rx<PaletteColorData> rx = PaletteColorData().obs;
  RxBool isRoot = true.obs;
  RxBool second = false.obs;
  PageController pageController = PageController(viewportFraction: .99);

  //是否第一次进入首页
  bool first = true;
  Rx<MediaItem> mediaItem = const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10)).obs;
  RxBool playing = false.obs;

  // final OnAudioQuery audioQuery = GetIt.instance<OnAudioQuery>();
  late BuildContext buildContext;
  final AudioServeHandler audioServeHandler = GetIt.instance<AudioServeHandler>();
  Rx<Duration> duration = Duration.zero.obs;
  PanelController panelController = PanelController();
  RxBool isDownSlide = true.obs;

  Rx<AudioServiceRepeatMode> audioServiceRepeatMode = AudioServiceRepeatMode.all.obs;
  Rx<AudioServiceShuffleMode> audioServiceShuffleMode = AudioServiceShuffleMode.none.obs;

  List<Map<dynamic, dynamic>> mEffects = [];
  AnimationController? animationController;
  String directoryPath = '';
  FixedExtentScrollController scrollController = FixedExtentScrollController();

  ZoomDrawerController myDrawerController = GetIt.instance<ZoomDrawerController>();
  RxBool disableDragGesture = false.obs; //是否可以侧滑

  List<String> lyricList = <String>[].obs;
  List<LyricsLineModel> lyricsLineModels = <LyricsLineModel>[].obs;
  List<LyricsLineModel> lyricsLineModelsTran = <LyricsLineModel>[].obs;
  RxBool onMove = false.obs;
  Dio dio = Dio();

  //路由相关
  AutoRouterDelegate? autoRouterDelegate;

  RxString currLyric = ''.obs;

  RxDouble playListOffest = 10.0.obs;

  var lastPopTime = DateTime.now();

  bool intervalClick(int needTime) {
    // 防重复提交
    if (DateTime.now().difference(lastPopTime) > const Duration(milliseconds: 1000)) {
      print(lastPopTime);
      lastPopTime = DateTime.now();
      print("允许点击");
      return true;
    } else {
      // lastPopTime = DateTime.now(); //如果不注释这行,则强制用户一定要间隔2s后才能成功点击. 而不是以上一次点击成功的时间开始计算.
      print("请勿重复点击！");
      return false;
    }
  }

  //进度
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    autoRouterDelegate = AutoRouterDelegate.of(buildContext);
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    animationController?.addListener(() {
      slidePosition1.value = animationController?.value ?? 0;
    });
    var rng = Random();
    for (double i = 0; i < 100; i++) {
      mEffects.add({"percent": i, "size": 5 + rng.nextInt(30 - 5).toDouble()});
    }
    audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
    audioServeHandler.mediaItem.listen((value) async {
      if (value == null) return;
      //获取歌词
      SongLyricWrap songLyricWrap = await NeteaseMusicApi().songLyric(value.id ?? '');
      print('SongLyricWrap========${jsonEncode(songLyricWrap.toJson())}');
      String lyric = songLyricWrap.lrc.lyric ?? "";
      String lyricTran = songLyricWrap.tlyric.lyric ?? "";
      // lyricsLineModelsTran.clear();
      // if (lyricTran.isNotEmpty) {
      //   lyricsLineModelsTran.addAll(ParserLrc(lyricTran).parseLines());
      // }
      if (lyric.isNotEmpty) {
        lyricsLineModels.clear();
        var list = ParserLrc(lyric).parseLines();
        if (lyricTran.isNotEmpty) {
          lyricsLineModels.addAll(list.map((e) {
            int index = lyricsLineModelsTran.indexWhere((element) => element.startTime == e.startTime);
            if (index != -1) e.extText = lyricsLineModelsTran[index].mainText;
            return e;
          }).toList());
        } else {
          lyricsLineModels.addAll(list);
        }
      }

      mediaItem.value = value;
      ImageUtils.getImageColor('${mediaItem.value.extras?['image'] ?? ''}?param=50y50', (paletteColorData) {
        rx.value = paletteColorData;
      });
    });
    //监听实时进度变化
    AudioService.position.listen((event) {
      //如果没有展示播放页面就先不监听（节省资源）
      if (!second.value && slidePosition.value < 1) return;
      //如果监听到的毫秒大于歌曲的总时长 置0并stop
      if (event.inMilliseconds > (mediaItem.value.duration?.inMilliseconds ?? 0)) {
        duration.value = Duration.zero;
        return;
      }
      //赋值
      duration.value = event;
      //如果歌词列表没有滑动，根据歌词的开始时间自动滚动歌词列表
      if (!onMove.value) {
        int index = lyricsLineModels.indexWhere((element) => (element.startTime ?? 0) >= event.inMilliseconds && (element.endTime ?? 0) <= event.inMilliseconds);
        if (index != -1) {
          currLyric.value = lyricsLineModels[index > 0 ? index - 1 : index].mainText ?? '';
          scrollController.animateToItem(index > 0 ? index - 1 : index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        }
      }
    });
    audioServeHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });

    //监听路由变化
    autoRouterDelegate?.addListener(listenRouter);
    myDrawerController.stateNotifier?.addListener(() {
      if (myDrawerController.isOpen!()) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: Theme.of(buildContext).brightness == Brightness.dark ? Brightness.dark : Brightness.light,
        ));
      }
    });
  }

  listenRouter() {
    currPathUrl.value = autoRouterDelegate?.urlState.url ?? '';
    if (currPathUrl.value == '/home/index' || currPathUrl.value == '/home/user' || currPathUrl.value == '/home/search') {
      if (!disableDragGesture.value) disableDragGesture.value = true;
    } else {
      if (disableDragGesture.value) disableDragGesture.value = false;
    }
  }

  static HomeController get to => Get.find();

  //改变循环模式
  changeRepeatMode() {
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
        break;
      case AudioServiceRepeatMode.none:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.one;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.none;
        break;
    }
    audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
  }

  //改变随机模式
  changeShuffleMode() {
    // switch (audioServiceShuffleMode.value) {
    //   case AudioServiceShuffleMode.none:
    //     audioServiceShuffleMode.value = AudioServiceShuffleMode.all;
    //     break;
    //   case AudioServiceShuffleMode.all:
    //   case AudioServiceShuffleMode.group:
    //     audioServiceShuffleMode.value = AudioServiceShuffleMode.none;
    //     break;
    // }
    // audioServeHandler.setShuffleMode(audioServiceShuffleMode.value);
  }

  //获取当前循环icon
  IconData getRepeatIcon() {
    IconData icon;
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.none:
        icon = TablerIcons.repeatOff;
        break;
      case AudioServiceRepeatMode.one:
        icon = TablerIcons.repeatOnce;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        icon = TablerIcons.repeat;
        break;
    }
    return icon;
  }

  //获取是否随机图标
  IconData getShuffleIcon() {
    IconData icon;
    switch (audioServiceShuffleMode.value) {
      case AudioServiceShuffleMode.none:
        icon = TablerIcons.arrowsShuffle;
        break;
      case AudioServiceShuffleMode.all:
      case AudioServiceShuffleMode.group:
        icon = Icons.shuffle_on;
        break;
    }
    return icon;
  }

  //播放 or 暂停
  void playOrPause() async {
    if (playing.value) {
      await audioServeHandler.pause();
    } else {
      await audioServeHandler.play();
    }
  }

  //改变panel位置
  void changeSlidePosition(value) {
    slidePosition.value = value;
    // if (second.value) second.value = false;
  }

  //当按下返回键
  Future<bool> onWillPop() async {
    if (panelController.isPanelOpen) {
      panelController.close();
      return false;
    }
    if (weSlideController.isOpened) {
      weSlideController.hide();
      return false;
    }
    if (myDrawerController.isOpen!()) {
      myDrawerController.close!();
      return false;
    }
    return true;
  }

  //动态设置获取Header颜色
  Color getHeaderColor() {
    return Theme.of(buildContext).bottomAppBarColor.withOpacity(second.value
        ? 0
        : slidePosition.value > 0
            ? 0
            : 1);
  }

  Color getLeftMenuColor() {
    return Theme.of(buildContext).bottomAppBarColor;
  }

  //获取图片亮色背景下文字显示的颜色
  Color getLightTextColor() {
    if (slidePosition.value == 0 && second.value) {
      return rx.value.main?.bodyTextColor ?? Colors.transparent;
    } else {
      return Theme.of(buildContext).iconTheme.color ?? Colors.transparent;
    }
  }

  //获取Header的padding
  EdgeInsets getHeaderPadding() {
    return EdgeInsets.only(
      left: 30.w,
      right: 30.w,
      top: MediaQuery.of(buildContext).padding.top * (second.value ? (1 - slidePosition.value) : slidePosition.value),
    );
  }

  //获取panel页面顶部的高度
  double getTopHeight() {
    return topBarHeight * (slidePosition.value);
  }

  getHomeBottomPadding() {
    return (panelHeaderSize * .5);
  }

  //外层panel的高度和颜色
  double getPanelMinSize() {
    return panelHeaderSize * (1 + slidePosition.value * 5.6);
  }

  //获取图片的宽高
  double getImageSize() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 5.4);
  }

  //获取图片离左侧的间距
  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }

  //获取歌词和列表Header的高度
  double getSecondPanelMinSize() {
    return secondPanelHeaderSize + MediaQuery.of(buildContext).padding.bottom;
  }

  //当路由发生变化时调用
  void changeRoute(String? route) {
    if ((route == '/home/index' || route == '/home/user' || route == '/home/search')) {
      return;
    }
  }

  List<FlutterSliderHatchMarkLabel> updateEffects(double leftPercent, double rightPercent) {
    List<FlutterSliderHatchMarkLabel> newLabels = mEffects.map((e) => FlutterSliderHatchMarkLabel()).toList();
    return newLabels;
  }

  @override
  void onClose() {
    super.onClose();
    weSlideController.dispose();
    print('object=====Close');
    scrollController.dispose();
    autoRouterDelegate?.removeListener(listenRouter);
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
  void onResumed() {}
}
