import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/common/lyric_parser/parser_lrc.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/home/view/z_comment_view.dart';
import 'package:bujuan/pages/home/view/z_lyric_view.dart';
import 'package:bujuan/pages/home/view/z_playlist_view.dart';
import 'package:bujuan/pages/home/view/z_recommend_view.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../common/lyric_parser/lyrics_reader_model.dart';
import '../../common/netease_api/src/api/bean.dart';
import '../../common/bujuan_audio_handler.dart';
import '../../routes/router.dart';
import '../../widget/wheel_slider.dart';
import 'view/home_view.dart';
import 'package:auto_route/auto_route.dart';

Future<PaletteGenerator> getColor(MediaItem mediaItem) async {
  return await OtherUtils.getImageColor('${mediaItem.extras?['image'] ?? ''}?param=500y500');
}

class Home extends SuperController with GetSingleTickerProviderStateMixin {
  double panelHeaderSize = 100.w;
  double panelMobileMinSize = 85.w; //折叠起来时播放栏的高度
  double panelTopSize = 110.w; //折叠起来时播放栏的高度
  double panelAlbumPadding = 15.w; //专辑图片左右上下的边距

  //是否是横屏
  bool landscape = PlatformUtils.isMacOS || PlatformUtils.isWindows || OtherUtils.isPad();

  final List<LeftMenu> leftMenus = [
    LeftMenu('个人中心', TablerIcons.user, Routes.user, '/home/user'),
    LeftMenu('推荐歌单', TablerIcons.smart_home, Routes.index, '/home/index'),
    // LeftMenu('本地歌曲', TablerIcons.file_music, Routes.local, '/home/local'),
    LeftMenu('个性设置', TablerIcons.settings, Routes.settingL, '/home/settingL'),
    LeftMenu('捐赠', TablerIcons.coffee, Routes.coffee, ''),
  ];

  List<Widget> pages = [
    const RecommendView(),
    const ZPlayListView(),
    const LyricView(),
    const CommentView(),
  ];

  RxString currPathUrl = '/home/user'.obs;

  RxString currLyric = ''.obs;

  //歌词、播放列表PageView的下标
  RxInt selectIndex = 0.obs;

  //歌词、播放列表PageView控制器
  PageController pageController = PageController();
  Box box = GetIt.instance<Box>();

  //第一层滑动高度0-1
  RxDouble slidePosition = 0.0.obs;

  //第一层滑动高度0-1
  RxDouble slideSecondPosition = 0.0.obs;

  //专辑颜色数据
  Rx<PaletteGenerator> rx = PaletteGenerator.fromColors([]).obs;

  //是否第二层
  RxBool second = false.obs;

  //是否第二层
  RxBool panelOpenPositionThan1 = false.obs;

  //是否第二层
  RxBool panelOpenPositionThan8 = false.obs;

  //当前播放歌曲
  Rx<MediaItem> mediaItem = const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10)).obs;

  //当前播放列表
  RxList<MediaItem> mediaItems = <MediaItem>[].obs;

  //是否播放中
  RxBool playing = false.obs;

  RxBool fm = false.obs;

  //是否渐变播放背景
  RxBool gradientBackground = false.obs;

  //是否开启顶部歌词
  RxBool topLyric = true.obs;

  //是否开启圆形专辑
  RxBool roundAlbum = false.obs;

  //是否开启缓存
  RxBool cache = false.obs;

  //是否开启高音质
  RxBool high = false.obs;

  //是否开启高音质
  RxString background = ''.obs;

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

  RxInt currLyricIndex = 0.obs;

  //相似歌单
  RxList<Play> simiSongs = <Play>[].obs;

  //歌曲评论
  RxList<CommentItem> comments = <CommentItem>[].obs;

  //路由相关
  AutoRouterDelegate? autoRouterDelegate;

  Rx<Color> bodyColor = Colors.white.obs;

  RxInt sleepMin = 0.obs;
  int sleepMinTo = 0;

  var lastPopTime = DateTime.now();

  var lastSleepTime = DateTime.now();

  RxBool sleepSlide = false.obs;
  late AnimationController animationController;
  late Animation<double> animationPanel;
  late Animation<double> animationScalePanel;

  bool intervalClick(int needTime) {
    // 防重复提交
    if (DateTime.now().difference(lastPopTime) > const Duration(milliseconds: 800)) {
      lastPopTime = DateTime.now();
      return true;
    } else {
      return false;
    }
  }

  AndroidIntent androidHomeIntent = const AndroidIntent(
    action: 'android.intent.action.MAIN',
    flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    category: 'android.intent.category.HOME',
  );

  //用户信息
  RxList<int> likeIds = <int>[].obs;
  Rx<LoginStatus> loginStatus = LoginStatus.noLogin.obs;
  Rx<NeteaseAccountInfoWrap> userData = NeteaseAccountInfoWrap().obs;


  RxDouble scrollDown = 0.0.obs;
  RxBool canScroll = true.obs;

  //进度
  @override
  void onInit() async {
    // panelMobileMinSize = landscape ? 58.h : 85.w;
    // panelAlbumPadding = landscape ? 20.h : 15.w;
    animationController = AnimationController(vsync: this, value: 0);
    animationPanel = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationScalePanel = Tween(begin: 1.1, end: 1.0).animate(animationController);
    var rng = Random();
    for (double i = 0; i < (landscape ? 100 : 50); i++) {
      mEffects.add({"percent": i, "size": 3 + rng.nextInt(30 - 2).toDouble()});
    }
    box.get(noFirstOpen, defaultValue: false);
    background.value = box.get(backgroundSp, defaultValue: '');
    cache.value = box.get(cacheSp, defaultValue: false);
    gradientBackground.value = box.get(gradientBackgroundSp, defaultValue: true);
    topLyric.value = box.get(topLyricSp, defaultValue: false);
    fm.value = box.get(fmSp, defaultValue: false);
    high.value = box.get(highSong, defaultValue: false);
    roundAlbum.value = box.get(roundAlbumSp, defaultValue: false);
    String repeatMode = box.get(repeatModeSp, defaultValue: 'all');
    audioServiceRepeatMode.value = AudioServiceRepeatMode.values.firstWhereOrNull((element) => element.name == repeatMode) ?? AudioServiceRepeatMode.all;
    // audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
    super.onInit();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initUserData();
      _initHomeData();
    });
    super.onReady();
  }

  _initUserData() {
    String userDataStr = box.get(loginData) ?? '';
    if (userDataStr.isNotEmpty) {
      loginStatus.value = LoginStatus.login;
      userData.value = NeteaseAccountInfoWrap.fromJson(jsonDecode(userDataStr));
    }
  }

  _initHomeData() {
    autoRouterDelegate = AutoRouterDelegate.of(buildContext);

    //监听路由变化
    autoRouterDelegate?.addListener(listenRouter);

    // if (leftImage.value) {
    //   bodyColor.value = Theme.of(buildContext).cardColor.withOpacity(.7);
    // }
    // audioServeHandler.setRepeatMode(audioServiceRepeatMode.value);
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
        _getSongTalk();
      }
    });
    //监听实时进度变化
    AudioService.createPositionStream(minPeriod: const Duration(microseconds: 800), steps: 1000).listen((event) {
      //如果没有展示播放页面就先不监听（节省资源）
      if (!landscape && !second.value && slidePosition.value != 1) return;
      //如果监听到的毫秒大于歌曲的总时长 置0并stop
      if (event.inMilliseconds > (mediaItem.value.duration?.inMilliseconds ?? 0)) {
        duration.value = Duration.zero;
        return;
      }
      // if(lastDuration.inSeconds != event.inSeconds){
      duration.value = event;
      // }
      //   lastDuration = event;
      if (!onMove.value && lyricsLineModels.isNotEmpty) {
        int index = lyricsLineModels.indexOf(lyricsLineModels.firstWhere((element) => element.startTime! >= duration.value.inMilliseconds));
        if (index != -1 && index != lastIndex) {
          lyricScrollController.animateToItem((index > 0 ? index - 1 : index), duration: const Duration(milliseconds: 500), curve: Curves.linear);
          lastIndex = index;
          if (topLyric.value) currLyric.value = lyricsLineModels[(index > 0 ? index - 1 : index)].mainText ?? '';
        }
      }
    });
    audioServeHandler.playbackState.listen((value) {
      playing.value = value.playing;
    });
  }

  jumpLyric({bool animate = true}) {}

  //获取歌词
  _getLyric() async {
    //获取歌词
    hasTran.value = false;
    String lyric = box.get('lyric_${mediaItem.value.id}') ?? '';
    String lyricTran = box.get('lyricTran_${mediaItem.value.id}') ?? '';
    if (lyric.isEmpty) {
      SongLyricWrap songLyricWrap = await NeteaseMusicApi().songLyric(mediaItem.value.id);
      lyric = songLyricWrap.lrc.lyric ?? "";
      lyricTran = songLyricWrap.tlyric.lyric ?? "";
      box.put('lyric_${mediaItem.value.id}', lyric);
      box.put('lyricTran_${mediaItem.value.id}', lyricTran);
    }
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
  }

  //获取专辑颜色
  _getAlbumColor() async {
    OtherUtils.getImageColor('${mediaItem.value.extras?['image'] ?? ''}?param=500y500').then((value) {
      rx.value = value;
      if (slidePosition.value == 1 || second.value) {
        changeStatusIconColor(true);
      } else {
        _getColor();
      }
    });
  }

  changeStatusIconColor(bool changedToAlbum) {
    var color = rx.value.darkMutedColor?.color ?? rx.value.darkVibrantColor?.color ?? rx.value.dominantColor?.color ?? Colors.white;
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    bool isLight = brightness == Brightness.light;
    if (!changedToAlbum) {
      isLight = !Get.isPlatformDarkMode;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ));
    _getColor();
  }

  _getColor() {
    var color = rx.value.darkMutedColor?.color ?? rx.value.darkVibrantColor?.color ?? rx.value.dominantColor?.color ?? Colors.white;
    Brightness brightness = ThemeData.estimateBrightnessForColor(color);
    // bodyColor.value = rx.value.darkVibrantColor?.bodyTextColor??rx.value.darkMutedColor?.bodyTextColor??rx.value.lightVibrantColor?.bodyTextColor??Colors.white;
    bodyColor.value = brightness == Brightness.light ? Colors.black.withOpacity(.6) : Colors.white.withOpacity(.7);
  }

  //获取相似歌单
  // _getSimiSheet() async {
  //   //获取相似歌曲
  //   MultiPlayListWrap songListWrap = await NeteaseMusicApi().playListSimiList(mediaItem.value.id);
  //   simiSongs
  //     ..clear()
  //     ..addAll(songListWrap.playlists ?? []);
  // }

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
    if (path == '/home/user' || path == '/home/index' || path == '/home/local' || path == '/home/settingL') {
      currPathUrl.value = path;
    }
  }

  static Home get to => Get.find();

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
    box.put(repeatModeSp, audioServiceRepeatMode.value.name);
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
    bool isLiked = likeIds.contains(int.parse(mediaItem.value.id));
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
        likeIds.remove(int.parse(mediaItem.value.id));
      } else {
        likeIds.add(int.parse(mediaItem.value.id));
      }
    }
  }

  //改变panel位置
  void changeSlidePosition(double value, {bool status = true}) {
    if (value == 2.086162576020456e-9) {
      return;
    }
    animationController.value = value;
    slidePosition.value = value;
    if (value > 0.1) {
      if (!panelOpenPositionThan1.value) {
        panelOpenPositionThan1.value = true;
        if (status) changeStatusIconColor(true);
      }
    } else {
      if (panelOpenPositionThan1.value) {
        panelOpenPositionThan1.value = false;
        if (status) changeStatusIconColor(false);
      }
    }
    if (value >= .8) {
      if (!panelOpenPositionThan8.value) {
        panelOpenPositionThan8.value = true;
      }
    } else {
      if (panelOpenPositionThan8.value) {
        panelOpenPositionThan8.value = false;
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

  bool get isDarkMode => Theme.of(buildContext).brightness == Brightness.dark;

  //当按下返回键
  Future<bool> onWillPop() async {
    if (!landscape) {
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
    }

    if (PlatformUtils.isAndroid && (autoRouterDelegate?.currentConfiguration?.path ?? '').contains(Routes.index) ||
        (autoRouterDelegate?.currentConfiguration?.path ?? '').contains(Routes.user)) {
      androidHomeIntent.launch();
      return false;
    }
    return true;
  }

  //播放歌曲根据下标
  playByIndex(int index, String queueTitle, {List<MediaItem>? mediaItem}) async {
    audioServeHandler.queueTitle.value = queueTitle;
    audioServeHandler.changeQueueLists(mediaItem ?? [], index: index);
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
                'liked': likeIds.contains(int.tryParse(e.id)),
                'artist': (e.artists ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / '),
                'type': MediaType.fm.name,
                'size': ''
              },
              title: e.name ?? "",
              album: e.album?.name ?? '',
              artist: (e.artists ?? []).map((e) => e.name).toList().join(' / ')))
          .toList();
      audioServeHandler.addFmItems(medias, false);
    }
  }

  //获取图片亮色背景下文字显示的颜色
  Color getLightTextColor(context) {
    return Theme.of(context).cardColor.withOpacity(.7);
  }

  //添加/删除歌曲到指定的歌单
  addOrDelSongToPlaylist(String playlistId, String songId, bool add) async{
    NeteaseMusicApi().playlistManipulateTracks(playlistId, songId, add);
  }

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
    // if (leftImage.value) {
    //   bodyColor.value = Get.isPlatformDarkMode ? Colors.white : Colors.black;
    // }
    if (second.value || slidePosition.value == 1) return;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      statusBarBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isDarkMode ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
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
              'liked': likeIds.contains(int.tryParse(e.id)),
              'artist': (e.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / '),
              'album': jsonEncode(e.al?.toJson()),
              'mv': e.mv,
              'fee': e.fee
            },
            title: e.name ?? "",
            album: e.al?.name,
            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
        .toList();
  }

  // changePlayUi(context) {
  //   leftImage.value = !leftImage.value;
  //   if (leftImage.value) {
  //     bodyColor.value = Theme.of(context).iconTheme.color ?? Colors.transparent;
  //   } else {
  //     _getAlbumColor();
  //   }
  // }

  void sleep(BuildContext context) {
    if (lastSleepTime.add(Duration(minutes: sleepMinTo)).difference(DateTime.now()).abs().inSeconds > 0) sleepSlide.value = false;
    sleepMin.value = sleepMinTo;
    showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) => Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 60.w),
                      child: Text(
                        '睡眠定时器',
                        style: TextStyle(color: Colors.white, fontSize: 42.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Obx(() => WheelSlider(
                            totalCount: 150,
                            initValue: sleepMin.value,
                            lineColor: Colors.white,
                            pointerColor: Colors.white,
                            isVibrate: false,
                            perspective: 0.006,
                            onValueChanged: (val) {
                              sleepMin.value = val;
                              sleepSlide.value = true;
                            },
                            hapticFeedbackType: HapticFeedbackType.vibrate,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.w, bottom: 20.w),
                      child: Obx(() => Text(
                            '${sleepMin.value}分钟',
                            style: TextStyle(color: Colors.white, fontSize: 36.sp),
                          )),
                    ),
                    Obx(() => Visibility(
                        visible: sleepMin.value != 0 && !sleepSlide.value,
                        replacement: const SizedBox.shrink(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.w, bottom: 40.w),
                          child: SlideCountdown(
                            decoration: const BoxDecoration(color: Colors.white),
                            icon: const Text('剩余 '),
                            textStyle: const TextStyle(color: Colors.black),
                            duration: lastSleepTime.add(Duration(minutes: sleepMinTo)).difference(DateTime.now()).abs(),
                          ),
                        ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              sleepMin.value = 0;
                              sleepMinTo = 0;
                              audioServeHandler.customAction('cancelSleep');
                            },
                            child: Text(
                              '归零',
                              style: TextStyle(color: Colors.white, fontSize: 32.sp),
                            )),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 40.w)),
                        TextButton(
                            onPressed: () {
                              if (sleepMin.value == 0) {
                                WidgetUtil.showToast('睡眠时间不能小于0分钟');
                                return;
                              }
                              sleepMinTo = sleepMin.value;
                              lastSleepTime = DateTime.now();
                              audioServeHandler.customAction('sleep', {'time': sleepMinTo * 60 - 2}).then((value) {
                                sleepSlide.value = false;
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text(
                              '确定',
                              style: TextStyle(color: Colors.white, fontSize: 32.sp),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ));
    // List<SleepDate> sleeps = [
    //   SleepDate('5分钟', 5),
    //   SleepDate('10分钟', 10),
    //   SleepDate('15分钟', 15),
    //   SleepDate('30分钟', 30),
    //   SleepDate('45分钟', 45),
    //   SleepDate('1小时', 60),
    // ];
    // showModalActionSheet(
    //   context: context,
    //   title: '睡眠定时器',
    //   message: '音频停止时刻',
    //   actions: sleeps.map((e) => SheetAction<SleepDate>(label: '${e.title}后停止', key: e)).toList(),
    // ).then((value) {
    //   if (value != null) {
    //     WidgetUtil.showToast(value.title);
    //     audioServeHandler.customAction('sleep', {'time': value.value});
    //   }
    // });
  }
}

class SleepDate {
  String title;
  int value;

  SleepDate(this.title, this.value);
}
