import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/common/lyric_parser/parser_lrc.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/pages/home/view/z_comment_view.dart';
import 'package:bujuan/pages/home/view/z_lyric_view.dart';
import 'package:bujuan/pages/home/view/z_playlist_view.dart';
import 'package:bujuan/pages/home/view/z_recommend_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_edit/on_audio_edit.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/lyric_parser/lyrics_reader_model.dart';
import '../../common/netease_api/src/api/bean.dart';
import '../../common/bujuan_audio_handler.dart';
import '../../routes/router.dart';
import 'view/home_view.dart';

Future<PaletteGenerator> getColor(MediaItem mediaItem) async {
  return await OtherUtils.getImageColor('${mediaItem.extras?['image'] ?? ''}?param=500y500');
}

class HomeController extends SuperController with GetSingleTickerProviderStateMixin {
  double panelHeaderSize = 100.w;
  double panelMobileMinSize = 100.w;
  final List<LeftMenu> leftMenus = [
    LeftMenu('个人中心', TablerIcons.user, Routes.user, '/home/user'),
    LeftMenu('推荐歌单', TablerIcons.smart_home, Routes.index, '/home/index'),
    LeftMenu('本地歌曲', TablerIcons.file_music, Routes.local, '/home/local'),
    LeftMenu('个性设置', TablerIcons.settings, Routes.setting, '/setting'),
  ];

  List<Widget> pages = [
    const RecommendView(),
    const PlayListView(),
    const LyricView(),
    const CommentView(),
  ];

  RxString currPathUrl = '/home/user'.obs;

  RxString currLyric = ''.obs;

  //歌词、播放列表PageView的下标
  RxInt selectHomeIndex = 0.obs;

  //歌词、播放列表PageView的下标
  RxInt selectIndex = 0.obs;

  //歌词、播放列表PageView控制器
  PreloadPageController pageController = PreloadPageController();

  //第一层滑动高度0-1
  RxDouble slidePosition = 0.0.obs;

  //第二层滑动高度0-1
  RxDouble slidePosition1 = 0.0.obs;

  //专辑颜色数据
  Rx<PaletteGenerator> rx = PaletteGenerator.fromColors([]).obs;

  //是否第二层
  RxBool second = false.obs;

  //是否第二层
  RxBool isDraggable = false.obs;

  //是否第二层
  RxBool panelOpenPositionThan1 = false.obs;

  //当前播放歌曲
  Rx<MediaItem> mediaItem = const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10)).obs;

  //当前播放列表
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;

  //是否播放中
  RxBool playing = false.obs;
  //是否播放中
  RxBool isMobile = true.obs;

  RxBool fm = false.obs;

  RxBool leftImage = true.obs;

  //是否渐变播放背景
  RxBool gradientBackground = false.obs;

  //是否开启顶部歌词
  RxBool topLyric = true.obs;

  //是否开启高音质
  RxBool high = false.obs;

  //上下文
  late BuildContext buildContext;

  //播放器handler
  final BujuanAudioHandler audioServeHandler = GetIt.instance<BujuanAudioHandler>();

  //当前播放进度
  Rx<Duration> duration = Duration.zero.obs;
  Duration lastDuration = Duration.zero;

  //第一层
  PanelController panelControllerHome = PanelController();

  //第二层
  PanelController panelController = PanelController();

  //循环方式
  Rx<AudioServiceRepeatMode> audioServiceRepeatMode = AudioServiceRepeatMode.all.obs;
  Rx<AudioServiceShuffleMode> audioServiceShuffleMode = AudioServiceShuffleMode.none.obs;

  //进度条数组
  List<Map<dynamic, dynamic>> mEffects = [];

  //歌词滚动控制器
  FixedExtentScrollController lyricScrollController = FixedExtentScrollController();

  //播放列表滚动控制器
  ScrollController playListScrollController = ScrollController();

  //侧滑控制器
  ZoomDrawerController myDrawerController = GetIt.instance<ZoomDrawerController>();

  //解析后的歌词数组
  List<LyricsLineModel> lyricsLineModels = <LyricsLineModel>[].obs;

  //是否有翻译歌词
  RxBool hasTran = false.obs;

  //歌词是否被用户滚动中
  RxBool onMove = false.obs;

  //当前歌词下标
  int lastIndex = 0;

  //相似歌单
  RxList<Play> simiSongs = <Play>[].obs;

  //歌曲评论
  RxList<CommentItem> comments = <CommentItem>[].obs;

  //路由相关
  AutoRouterDelegate? autoRouterDelegate;

  OnAudioEdit onAudioEdit = GetIt.instance<OnAudioEdit>();

  RxBool isAurora = false.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<Color> bodyColor = Colors.white.obs;

  var lastPopTime = DateTime.now();

  var lyricModel;

  bool intervalClick(int needTime) {
    // 防重复提交
    if (DateTime.now().difference(lastPopTime) > const Duration(milliseconds: 800)) {
      lastPopTime = DateTime.now();
      return true;
    } else {
      return false;
    }
  }

  //进度
  @override
  void onInit() async {
    StorageUtil().setBool(noFirstOpen, true);
    leftImage.value = StorageUtil().getBool(leftImageSp);
    gradientBackground.value = StorageUtil().getBool(gradientBackgroundSp);
    topLyric.value = StorageUtil().getBool(topLyricSp);
    fm.value = StorageUtil().getBool(fmSp);
    high.value = StorageUtil().getBool(highSong);
    super.onInit();
  }

  @override
  void onReady() {
    autoRouterDelegate = AutoRouterDelegate.of(buildContext);

    if (leftImage.value) {
      bodyColor.value = Theme.of(buildContext).cardColor.withOpacity(.7);
    }
    var rng = Random();
    for (double i = 0; i < 100; i++) {
      mEffects.add({"percent": i, "size": 3 + rng.nextInt(30 - 5).toDouble()});
    }
    audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
    audioServeHandler.queue.listen((value) => mediaItems
      ..clear()
      ..addAll(value));
    audioServeHandler.mediaItem.listen((value) async {
      lyricsLineModels.clear();
      duration.value = Duration.zero;
      currLyric.value = '';
      if (value == null) return;
      mediaItem.value = value;
      _getAlbumColor();
      _getLyric();
      _setPlayListOffset();
      if (value.extras?['type'] == MediaType.playlist.name) {
        // _getSimiSheet();
        _getSongTalk();
      }
    });
    //监听实时进度变化
    AudioService.position.listen((event) {
      //如果没有展示播放页面就先不监听（节省资源）
      if (!second.value && slidePosition.value != 1) return;
      //如果监听到的毫秒大于歌曲的总时长 置0并stop
      if (event.inMilliseconds > (mediaItem.value.duration?.inMilliseconds ?? 0)) {
        duration.value = Duration.zero;
        return;
      }
      duration.value = event;
      if(lastDuration.inSeconds != event.inSeconds){
        if (!onMove.value) {
          int index = lyricsLineModels.indexWhere((element) => (element.startTime ?? 0) >= event.inMilliseconds && (element.endTime ?? 0) <= event.inMilliseconds);
          if (index != -1) currLyric.value = lyricsLineModels[index > 0 ? index - 1 : index].mainText ?? '';
          if (index != -1 && index != lastIndex) {
            lyricScrollController.animateToItem((index > 0 ? index - 1 : index), duration: const Duration(milliseconds: 500), curve: Curves.linear);
            lastIndex = index;
          }
        }
      }
      lastDuration = event;
      //如果歌词列表没有滑动，根据歌词的开始时间自动滚动歌词列表

    });
    audioServeHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });

    //监听路由变化
    autoRouterDelegate?.addListener(listenRouter);
    // myDrawerController.stateNotifier?.addListener(() {
    //   if (myDrawerController.isOpen!()) {
    //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //       statusBarBrightness: Get.isPlatformDarkMode ? Brightness.light : Brightness.dark,
    //       statusBarIconBrightness: Get.isPlatformDarkMode ? Brightness.dark : Brightness.light,
    //     ));
    //   }
    //   if (!myDrawerController.isOpen!()) {
    //     didChangePlatformBrightness();
    //   }
    // });
    super.onReady();
  }

  //获取歌词
  _getLyric() async {
    //获取歌词
    hasTran.value = false;
    if (mediaItem.value.extras?['type'] != MediaType.local.name) {
      SongLyricWrap songLyricWrap = await NeteaseMusicApi().songLyric(mediaItem.value.id);
      String lyric = songLyricWrap.lrc.lyric ?? "";
      String lyricTran = songLyricWrap.tlyric.lyric ?? "";
      if (lyric.isNotEmpty) {
        var list = ParserLrc(lyric).parseLines();
        var listTran = ParserLrc(lyricTran).parseLines();
        if (lyricTran.isNotEmpty) {
          hasTran.value = true;
          lyricsLineModels.addAll(list.map((e) {
            int index = listTran.indexWhere((element) => element.startTime == e.startTime);
            if (index != -1) e.extText = listTran[index].mainText;
            return e;
          }).toList());
        } else {
          lyricsLineModels.addAll(list);
        }
      }
    } else {
      AudioModel audioModel = await onAudioEdit.readAudio(mediaItem.value.extras?['url']);
      var list = ParserLrc(audioModel.lyrics ?? '').parseLines();
      lyricsLineModels.addAll(list);
    }
  }

  //获取专辑颜色
  _getAlbumColor() async {
    if (leftImage.value) {
      return;
    }
    rx.value = await OtherUtils.getImageColor('${mediaItem.value.extras?['image'] ?? ''}?param=500y500');
    if (slidePosition.value == 1 || second.value) {
      changeStatusIconColor(true);
    } else {
      _getColor();
    }
  }

  changeStatusIconColor(bool changed) {
    if (leftImage.value) return;
    var color = rx.value.dominantColor?.color ?? Colors.white;
    var grayscale = (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: changed
          ? grayscale > 128
              ? Brightness.light
              : Brightness.dark
          : Get.isPlatformDarkMode
              ? Brightness.dark
              : Brightness.light,
      statusBarIconBrightness: changed
          ? grayscale > 128
              ? Brightness.dark
              : Brightness.light
          : Get.isPlatformDarkMode
              ? Brightness.light
              : Brightness.dark,
    ));
    _getColor(grayscale: grayscale);
  }

  _getColor({grayscale}) {
    if (grayscale == null) {
      var color = rx.value.dominantColor?.color ?? Colors.white;
      grayscale = (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);
    }
    if (grayscale > 128 && bodyColor.value == Colors.black.withOpacity(.5)) {
      return;
    }
    if (grayscale <= 128 && bodyColor.value == Colors.white.withOpacity(.65)) {
      return;
    }
    bodyColor.value = grayscale > 128 ? Colors.black.withOpacity(.6) : Colors.white.withOpacity(.8);
  }

  //获取相似歌单
  _getSimiSheet() async {
    //获取相似歌曲
    MultiPlayListWrap songListWrap = await NeteaseMusicApi().playListSimiList(mediaItem.value.id);
    simiSongs
      ..clear()
      ..addAll(songListWrap.playlists ?? []);
  }

  //获取歌曲评论
  _getSongTalk() async {
    CommentList2Wrap commentListWrap = await NeteaseMusicApi().commentList2(mediaItem.value.id, 'song', pageSize: 3, sortType: 2);
    if (commentListWrap.code == 200) {
      comments
        ..clear()
        ..addAll(commentListWrap.data.comments ?? []);
    }
  }

  listenRouter() {
    String path = autoRouterDelegate?.urlState.url ?? '';
    if (path == '/home/user' || path == '/home/index' || path == '/home/local') {
      currPathUrl.value = path;
    }
  }

  static HomeController get to => Get.find();

  //改变循环模式
  changeRepeatMode() {
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.none;
        break;
      case AudioServiceRepeatMode.none:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.all;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        audioServiceRepeatMode.value = AudioServiceRepeatMode.one;
        break;
    }
    audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
  }

  //获取当前循环icon
  IconData getRepeatIcon() {
    IconData icon;
    switch (audioServiceRepeatMode.value) {
      case AudioServiceRepeatMode.one:
        icon = TablerIcons.repeat_once;
        break;
      case AudioServiceRepeatMode.none:
        icon = TablerIcons.arrows_shuffle;
        break;
      case AudioServiceRepeatMode.all:
      case AudioServiceRepeatMode.group:
        icon = TablerIcons.repeat;
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

  //喜欢歌曲
  likeSong({bool? liked}) async {
    bool isLiked = UserController.to.likeIds.contains(int.parse(mediaItem.value.id));
    if (liked != null) {
      isLiked = liked;
    }
    ServerStatusBean serverStatusBean = await NeteaseMusicApi().likeSong(mediaItem.value.id, !isLiked);
    if (serverStatusBean.code == 200) {
      await audioServeHandler.updateMediaItem(mediaItem.value..extras?['liked'] = !isLiked);
      if (PlatformUtils.isAndroid) {
        audioServeHandler.playbackState.add(audioServeHandler.playbackState.value.copyWith(
          controls: [
            (mediaItem.value.extras?['liked'] ?? false)
                ? const MediaControl(label: 'fastForward', action: MediaAction.fastForward, androidIcon: 'drawable/audio_service_like')
                : const MediaControl(label: 'rewind', action: MediaAction.rewind, androidIcon: 'drawable/audio_service_unlike'),
            MediaControl.skipToPrevious,
            if (playing.value) MediaControl.pause else MediaControl.play,
            MediaControl.skipToNext,
            MediaControl.stop
          ],
          systemActions: {MediaAction.playPause, MediaAction.seek, MediaAction.skipToPrevious, MediaAction.skipToNext},
          androidCompactActionIndices: [1, 2, 3],
          processingState: AudioProcessingState.completed,
        ));
      }
      WidgetUtil.showToast(isLiked ? '取消喜欢成功' : '喜欢成功');
      if (isLiked) {
        UserController.to.likeIds.remove(int.parse(mediaItem.value.id));
      } else {
        UserController.to.likeIds.add(int.parse(mediaItem.value.id));
      }
    }
  }

  //改变panel位置
  void changeSlidePosition(double value) {
    if (value == 2.086162576020456e-9) {
      return;
    }
    slidePosition.value = value;
    if (value == 1) {
      if (!isDraggable.value) isDraggable.value = true;
    } else {
      if (isDraggable.value) isDraggable.value = false;
    }

    if (value > 0.1) {
      if (!panelOpenPositionThan1.value) {
        panelOpenPositionThan1.value = true;
      }
    } else {
      if (panelOpenPositionThan1.value) {
        panelOpenPositionThan1.value = false;
      }
    }
    // _setPlayListOffset();
  }

  //设置歌词列表偏移量
  Future<void> _setPlayListOffset() async {
    if (fm.value) return;
    if (slidePosition.value < 1 && !second.value) return;
    // bool maxOffset = playListScrollController.position.pixels >= playListScrollController.position.maxScrollExtent;
    // int index = mediaItems.indexWhere((element) => element.id == mediaItem.value.id);
    // if (index != -1 && !maxOffset) {
    //   double offset = 110.w * index;
    //   await playListScrollController.animateTo(offset, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    // }
  }

  //当按下返回键
  Future<bool> onWillPop() async {
    if (panelController.isPanelOpen) {
      panelController.close();
      return false;
    }
    if (panelControllerHome.isPanelOpen) {
      panelControllerHome.close();
      return false;
    }
    if (myDrawerController.isOpen!()) {
      myDrawerController.close!();
      return false;
    }
    return true;
  }

  //播放歌曲根据下标
  playByIndex(int index, String queueTitle, {List<MediaItem>? mediaItem}) async {
    // String title = audioServeHandler.queueTitle.value;
    // if ((title.isEmpty || title != queueTitle) && (mediaItem??[]).length != mediaItems.length) {
    audioServeHandler.queueTitle.value = queueTitle;
    audioServeHandler
      ..changeQueueLists(mediaItem ?? [], index: index)
      ..playIndex(index);
    // } else {
    //   audioServeHandler.playIndex(index);
    // }
  }

  getFmSongList() async {
    SongListWrap2 songListWrap2 = await NeteaseMusicApi().userRadio();
    if (songListWrap2.code == 200) {
      List<Song> songs = songListWrap2.data ?? [];
      List<MediaItem> medias = songs
          .map((e) => MediaItem(
              id: e.id,
              duration: Duration(milliseconds: e.duration ?? 0),
              artUri: Uri.parse('${e.album?.picUrl ?? ''}?param=500y500'),
              extras: {
                'image': e.album?.picUrl ?? '',
                'liked': UserController.to.likeIds.contains(int.tryParse(e.id)),
                'artist': (e.artists ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / '),
                'type': MediaType.fm.name
              },
              title: e.name ?? "",
              album: jsonEncode(e.album!.toJson()),
              artist: (e.artists ?? []).map((e) => e.name).toList().join(' / ')))
          .toList();
      audioServeHandler.addFmItems(medias, false);
    }
  }

  //获取图片亮色背景下文字显示的颜色
  Color getLightTextColor(context) {
    return Theme.of(context).cardColor.withOpacity(.7);
  }

  //获取Header的padding
  EdgeInsets getHeaderPadding(context) {
    return EdgeInsets.only(
      left: 30.w,
      right: 30.w,
      top: (MediaQuery.of(context).padding.top + 70.h * (slidePosition.value)) * (second.value ? (1 - slidePosition.value) : slidePosition.value),
    );
  }

  getHomeBottomPadding() {
    return (panelHeaderSize * .5);
  }

  //外层panel的高度和颜色
  double getPanelMinSize() {
    return panelHeaderSize * (1 + slidePosition.value * 6);
  }

  //获取图片的宽高
  double getImageSize() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 6.77);
  }
  //获取图片的宽高
  double getImageSizeL() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 6);
  }

  //获取图片离左侧的间距
  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }

  // Color getPlayPageTheme(BuildContext context) {
  //   var color = rx.value.dominantColor?.color ?? Colors.white;
  //   var grayscale = (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);
  //   return grayscale > 128 ? Colors.black.withOpacity(.5) : Colors.white.withOpacity(.7);
  // }

  @override
  void onClose() {
    super.onClose();
    // panelControllerHome.d();
    lyricScrollController.dispose();
    autoRouterDelegate?.removeListener(listenRouter);
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    // WidgetUtil.showToast('onDetached');
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    // WidgetUtil.showToast('onInactive');
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    // WidgetUtil.showToast('onPaused');
  }

  @override
  void onResumed() {
    // WidgetUtil.showToast('onResumed');
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    // print('objectdidChangeMetrics');
  }

  @override
  void didChangePlatformBrightness() {
    if (leftImage.value) {
      bodyColor.value = Get.isPlatformDarkMode ? Colors.white : Colors.black;
    }
    if (second.value || slidePosition.value == 1) return;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Get.isPlatformDarkMode ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: Get.isPlatformDarkMode ? Brightness.light : Brightness.dark,
    ));
    super.didChangePlatformBrightness();
  }

  List<MediaItem> song2ToMedia(List<Song2> songs) {
    return songs
        .map((e) => MediaItem(
            id: e.id,
            duration: Duration(milliseconds: e.dt ?? 0),
            artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=500y500'),
            extras: {
              'type': MediaType.playlist.name,
              'image': e.al?.picUrl ?? '',
              'liked': UserController.to.likeIds.contains(int.tryParse(e.id)),
              'artist': (e.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / '),
              'album': jsonEncode(e.al?.toJson()),
              'mv': e.mv
            },
            title: e.name ?? "",
            album: e.al?.name,
            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
        .toList();
  }

  changePlayUi(context) {
    leftImage.value = !leftImage.value;
    if (leftImage.value) {
      bodyColor.value = Theme.of(context).cardColor.withOpacity(.7);
    } else {
      _getAlbumColor();
    }
  }
}
