import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:dio/dio.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
// import 'package:jaudiotagger/jaudiotagger.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/constants/colors.dart';
import '../../widget/lyric/lyric_parser/parser_lrc.dart';
import '../../widget/lyric/lyrics_reader_model.dart';
import '../../widget/weslide/weslide_controller.dart';

class HomeController extends GetxController {
  final String weSlideUpdate = 'weSlide';
  double panelHeaderSize = 110.w;
  double secondPanelHeaderSize = 120.w;
  double bottomBarHeight = 55;
  double panelMobileMinSize = 0;
  double topBarHeight = 90.w;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  WeSlideController weSlideController1 = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  PageController pageController = PageController(viewportFraction: .99);
  Rx<Color> textColor = const Color(0xFFFFFFFF).obs;
  double offset = 0;
  double down = 0;
  RxBool isScroll = true.obs;

  RxInt selectIndex = 0.obs;

  RxDouble slidePosition = 0.0.obs;
  Rx<PaletteColorData> rx = PaletteColorData().obs;
  RxBool second = false.obs;
  bool firstSlideIsDownSlide = true;
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(systemNavigationBarColor: AppTheme.onPrimary);
  RxBool isRoot = true.obs;
  bool isRoot1 = true;
  bool first = true;
  Rx<MediaItem> mediaItem = const MediaItem(id: 'no', title: '暂无', duration: Duration(seconds: 10)).obs;
  RxBool playing = false.obs;
  PageController secondPageController = PageController();
  final OnAudioQuery audioQuery = OnAudioQuery();
  late BuildContext buildContext;
  final AudioServeHandler audioServeHandler = GetIt.instance<AudioServeHandler>();
  Rx<Duration> duration = Duration.zero.obs;
  // Jaudiotagger audioTagger = Jaudiotagger();
  var dio = http.Dio();
  ScrollController scrollController = ScrollController();
  RxList<LyricsLineModel> lyricList = <LyricsLineModel>[].obs;

  Rx<AudioServiceRepeatMode> audioServiceRepeatMode = AudioServiceRepeatMode.all.obs;
  Rx<AudioServiceShuffleMode> audioServiceShuffleMode = AudioServiceShuffleMode.none.obs;

  @override
  void onInit() {
    setHeaderHeight();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
    audioServeHandler.mediaItem.listen((value) async {
      if (value == null) return;
      setHeaderHeight();
      //获取歌词
      // audioTagger.getPlatformVersion(value.extras?['data'] ?? '').then((value) {
      //   if (value == null || value.isEmpty) return;
      //   lyricList.value = ParserLrc(value).parseLines();
      // });
      mediaItem.value = value;
      ImageUtils.getImageColor(value.artUri?.path ?? '', (paletteColorData) {
        rx.value = paletteColorData;
        textColor.value = paletteColorData.light?.titleTextColor ?? AppTheme.onPrimary;
      });
    });
    //监听实时进度变化
    AudioService.position.listen((event) {
      if (event.inMilliseconds > (mediaItem.value.duration?.inMilliseconds ?? 0)) {
        duration.value = Duration.zero;
        return;
      }
      duration.value = event;
    });
    audioServeHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });
    requestPermission();
  }

  static HomeController get to => Get.find();

  //动态设置Header高度
  setHeaderHeight() {
    if (mediaItem.value.id == 'no' && panelHeaderSize > 0) {
      panelHeaderSize = 0;
      panelMobileMinSize = panelHeaderSize + bottomBarHeight;
    } else {
      if (panelHeaderSize == 110.w) return;
      panelHeaderSize = 110.w;
      panelMobileMinSize = panelHeaderSize + bottomBarHeight;
      update([weSlideUpdate]);
    }
  }

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
        icon = Icons.link_off_outlined;
        break;
      case AudioServiceRepeatMode.one:
        icon = Icons.repeat_one;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        icon = Icons.repeat;
        break;
    }
    return icon;
  }

  //获取是否随机图标
  IconData getShuffleIcon() {
    IconData icon;
    switch (audioServiceShuffleMode.value) {
      case AudioServiceShuffleMode.none:
        icon = Icons.shuffle;
        break;
      case AudioServiceShuffleMode.all:
      case AudioServiceShuffleMode.group:
        icon = Icons.shuffle_on;
        break;
    }
    return icon;
  }

  //请求权限
  requestPermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
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
  void changeSlidePosition(value, {bool second = false}) {
    slidePosition.value = value;
    if (this.second.value != second || (second && value == 1)) {
      this.second.value = second && value < 1;
    }
    if (this.second.value) {
      firstSlideIsDownSlide = value > 0;
      update([weSlideUpdate]);
    }
  }

  //当按下返回键
  Future<bool> onWillPop() async {
    if (weSlideController1.isOpened) {
      weSlideController1.hide();
      return false;
    }
    if (weSlideController.isOpened) {
      weSlideController.hide();
      return false;
    }
    return true;
  }

  //外层panel的高度和颜色
  double getPanelMinSize() {
    return panelHeaderSize * (1 + slidePosition.value * 5.6);
  }

  //获取图片的宽高
  double getImageSize() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 5.6);
  }

  //获取图片离左侧的间距
  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }

  //动态设置获取Header颜色
  Color getHeaderColor() {
    return Theme.of(buildContext).bottomAppBarColor.withOpacity((second.value ? (1 - slidePosition.value) : slidePosition.value) > 0 ? 0 : 1);
  }

  //获取图片亮色背景下文字显示的颜色
  Color getLightTextColor() {
    if (!second.value && slidePosition.value == 1) {
      return textColor.value;
    } else {
      if (second.value && slidePosition.value == 0) {
        return textColor.value;
      }
      return Theme.of(buildContext).iconTheme.color ?? Colors.transparent;
    }
  }

  //获取panel页面顶部的高度
  double getTopHeight() {
    return topBarHeight * slidePosition.value;
  }

  //获取Header的padding
  EdgeInsets getHeaderPadding() {
    return EdgeInsets.only(left: 30.w, right: 30.w, top: MediaQuery.of(buildContext).padding.top * (second.value ? 1 : slidePosition.value));
  }

  //获取歌词和列表Header的高度
  double getSecondPanelMinSize() {
    return secondPanelHeaderSize + MediaQuery.of(buildContext).padding.bottom;
  }

  //改变pageView和底部导航栏下标
  void changeSelectIndex(int index) {
    selectIndex.value = index;
    pageController.jumpToPage(index);
  }

  //当路由发生变化时调用
  void changeRoute(String? route) async {
    isRoot1 = route == '/';
    if (!isRoot1) {
      first = false;
      await Future.delayed(const Duration(milliseconds: 120));
    }
    isRoot.value = route == '/';
    if (!first) update([weSlideUpdate]);
  }

  getHomeBottomPadding() {
    return (mediaItem.value.id == 'no' ? bottomBarHeight : bottomBarHeight + panelHeaderSize)+20.w;
  }
}
