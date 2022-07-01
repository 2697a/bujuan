import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/index/album_view.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/index/main_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:dio/dio.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:jaudiotagger/jaudiotagger.dart';
// import 'package:jaudiotagger/jaudiotagger.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tabler_icons/tabler_icons.dart';
import 'package:tuna_flutter_range_slider/tuna_flutter_range_slider.dart';

import '../../common/storage.dart';
import '../../widget/weslide/weslide_controller.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  final String weSlideUpdate = 'weSlide';
  double panelHeaderSize = 90.h;
  double secondPanelHeaderSize = 120.w;
  double bottomBarHeight = 55;
  double panelMobileMinSize = 0;
  double topBarHeight = 50.h;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  RxInt selectIndex = 0.obs;

  RxDouble slidePosition = 0.0.obs;
  RxDouble slidePosition1 = 0.0.obs;
  Rx<PaletteColorData> rx = PaletteColorData().obs;
  RxBool isRoot = true.obs;
  bool isRoot1 = true;
  bool first = true;
  Rx<MediaItem> mediaItem = const MediaItem(id: 'no', title: '暂无', duration: Duration(seconds: 10)).obs;
  RxBool playing = false.obs;
  PageController secondPageController = PageController();
  final OnAudioQuery audioQuery = GetIt.instance<OnAudioQuery>();
  late BuildContext buildContext;
  final AudioServeHandler audioServeHandler = GetIt.instance<AudioServeHandler>();
  Rx<Duration> duration = Duration.zero.obs;

  Jaudiotagger audioTagger = Jaudiotagger();
  var dio = http.Dio();
  ScrollController scrollController = ScrollController();
  RxString lyricList = ''.obs;

  Rx<AudioServiceRepeatMode> audioServiceRepeatMode = AudioServiceRepeatMode.all.obs;
  Rx<AudioServiceShuffleMode> audioServiceShuffleMode = AudioServiceShuffleMode.none.obs;

  List<FlutterSliderHatchMarkLabel> effects = [];
  List<Map<dynamic, dynamic>> mEffects = [];
  double ellv = 30;
  double euuv = 60;
  AnimationController? animationController;
  List<Widget> pages = [const MainView(), const AlbumView(), const IndexView(), const UserView()];
  RxInt sleep = 0.obs;
  String directoryPath = '';

  Rx<LyricsReaderModel>? lyricModel;

  //进度
  @override
  void onInit() async {
    Directory directory = await getTemporaryDirectory();
    directoryPath = directory.path;
    setHeaderHeight();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    var rng = Random();
    for (double i = 0; i < 100; i++) {
      mEffects.add({"percent": i, "size": 5 + rng.nextInt(30 - 5).toDouble()});
    }
    effects = updateEffects(ellv * 100 / mEffects.length, euuv * 100 / mEffects.length);
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    String title = StorageUtil().getString('queueTitle');
    var index = StorageUtil().getInt('index');
    var position = StorageUtil().getInt('position');
    print('object========$title=====$index========$position');
    if(title.isNotEmpty){
      List<SongModel> songs = await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, title);
      final List<MediaItem> mediaItems = [];
      for (var songModel in songs) {
        String path = '$directoryPath/${songModel.id}';
        File file = File(path);
        if (!await file.exists()) {
          Uint8List? a = await audioQuery.queryArtwork(songModel.id, ArtworkType.AUDIO, size: 800);
          await file.writeAsBytes(a!);
        }
        MediaItem mediaItem = MediaItem(
            id: '${songModel.id}',
            duration: Duration(milliseconds: songModel.duration ?? 0),
            artUri: Uri.file(path),
            extras: {'url': songModel.uri, 'data': songModel.data, 'type': songModel.fileExtension, 'albumId': songModel.albumId},
            title: songModel.title,
            artist: songModel.artist);
        mediaItems.add(mediaItem);
      }

      String title1 = audioServeHandler.queueTitle.value;
      if (title.isEmpty || title1 != title) {
        await audioServeHandler.addQueueItems(mediaItems);
        audioServeHandler.queueTitle.value = title;
      }
      duration.value = Duration(milliseconds: position);
      audioServeHandler
        ..skipToQueueItem(index)
        ..seek(Duration(milliseconds: position));
    }

    animationController?.addListener(() {
      slidePosition1.value = animationController?.value ?? 0;
    });
    audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
    audioServeHandler.mediaItem.listen((value) async {
      if (value == null) return;
      setHeaderHeight();
      //获取歌词
      audioTagger.getPlatformVersion(value.extras?['data'] ?? '').then((value) {
        print('object===========$value');
        lyricList.value = value ?? '';
        // lyricModel?.value = LyricsModelBuilder.create().bindLyricToMain(value ?? '').getModel();
      });
      mediaItem.value = value;
      ImageUtils.getImageColor(mediaItem.value.artUri?.path ?? '', (paletteColorData) {
        rx.value = paletteColorData;
      });
    });
    //监听实时进度变化
    AudioService.position.listen((event) {
      if (!weSlideController.isOpened) return;
      if (event.inMilliseconds > (mediaItem.value.duration?.inMilliseconds ?? 0)) {
        duration.value = Duration.zero;
        return;
      }
      duration.value = event;
    });
    audioServeHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });
  }

  static HomeController get to => Get.find();

  //动态设置Header高度
  setHeaderHeight() {
    if (mediaItem.value.id == 'no' && panelHeaderSize > 0) {
      panelHeaderSize = 0;
      panelMobileMinSize = panelHeaderSize + bottomBarHeight;
    } else {
      if (panelHeaderSize == 90.h) return;
      panelHeaderSize = 90.h;
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
  }

  //当按下返回键
  Future<bool> onWillPop() async {
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
    return Theme.of(buildContext).bottomAppBarColor.withOpacity(slidePosition.value > 0 ? 0 : 1);
  }

  //获取图片亮色背景下文字显示的颜色
  Color getLightTextColor() {
    if (slidePosition.value == 1) {
      return rx.value.light?.bodyTextColor ?? Colors.transparent;
    } else {
      return Theme.of(buildContext).iconTheme.color ?? Colors.transparent;
    }
  }

  //获取panel页面顶部的高度
  double getTopHeight() {
    return topBarHeight * slidePosition.value;
  }

  //获取Header的padding
  EdgeInsets getHeaderPadding() {
    return EdgeInsets.only(left: 30.w, right: 30.w, top: MediaQuery.of(buildContext).padding.top * slidePosition.value);
  }

  //获取歌词和列表Header的高度
  double getSecondPanelMinSize() {
    return secondPanelHeaderSize + MediaQuery.of(buildContext).padding.bottom;
  }

  //改变pageView和底部导航栏下标
  void changeSelectIndex(int index) {
    selectIndex.value = index;
    // pageController.jumpToPage(index);
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
    return (mediaItem.value.id == 'no' ? bottomBarHeight : bottomBarHeight + panelHeaderSize) + 20.w;
  }

  List<FlutterSliderHatchMarkLabel> updateEffects(double leftPercent, double rightPercent) {
    List<FlutterSliderHatchMarkLabel> newLabels = [];
    for (Map<dynamic, dynamic> label in mEffects) {
      newLabels.add(FlutterSliderHatchMarkLabel(
          percent: label['percent'],
          label: Container(
            height: label['size'],
            width: 1,
            color: rx.value.dark?.bodyTextColor ?? Colors.white.withOpacity(.3),
          )));
    }
    return newLabels;
  }
}
