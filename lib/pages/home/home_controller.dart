import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:dio/dio.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../common/constants/colors.dart';
import '../../widget/weslide/weslide_controller.dart';

class HomeController extends SuperController {
  final String weSlideUpdate = 'weSlide';
  double panelHeaderSize = 100.w;
  double secondPanelHeaderSize = 120.w;
  double bottomBarHeight = 60;
  double panelMobileMinSize = 0;
  double topBarHeight = 90.w;

  //是否折叠
  RxBool isCollapsed = true.obs;
  WeSlideController weSlideController = WeSlideController();
  WeSlideController weSlideController1 = WeSlideController();
  RxBool isCollapsedAfterSec = true.obs;
  PageController pageController = PageController();
  RxString lyric = ''.obs;
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
  Rx<MediaItem> mediaItem = const MediaItem(id: 'id', title: '暂无', duration: Duration(seconds: 10)).obs;
  RxBool playing = false.obs;
  PageController secondPageController = PageController();
  final OnAudioQuery audioQuery = OnAudioQuery();
  late BuildContext buildContext;
  final AudioServeHandler audioServeHandler = GetIt.instance<AudioServeHandler>();
  Rx<Duration> duration = Duration.zero.obs;
  var dio = http.Dio();

  @override
  void onInit() {
    panelMobileMinSize = panelHeaderSize + bottomBarHeight;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    audioServeHandler.mediaItem.listen((value) async {
      if (value == null) return;
      // Directory directory = await getTemporaryDirectory();
      // String path = '${directory.path}/${value.id}-lyric';
      // File file = File(path);
      // if(await file.exists()){
      //   String lyric = await file.readAsString();
      //   log('exists == lyric=====$lyric');
      // }else {
      //   dio.get('https://mobileservice.kugou.com/api/v3/lyric/search?version=9108&highlight=1&plat=0&pagesize=20&area_code=1&page=1&with_res_tag=1',
      //       queryParameters: {'keyword': value.title}).then((value1) {
      //     String dataStr = value1.data.toString().replaceAll("<!--KG_TAG_RES_END-->", '').replaceAll('<!--KG_TAG_RES_START-->', '');
      //     LyricHashEntity? lyricHashEntity = JsonConvert.fromJsonAsT<LyricHashEntity>(jsonDecode(dataStr));
      //     if (lyricHashEntity != null && lyricHashEntity.status == 1) {
      //       dio.get('http://krcs.kugou.com/search?ver=1&man=yes&client=mobi&keyword=&duration=&album_audio_id=',
      //           queryParameters: {'hash': lyricHashEntity.data?.info?[0].hash}).then((value2) {
      //         LyricKeyEntity? lyricKeyEntity =JsonConvert.fromJsonAsT<LyricKeyEntity>(jsonDecode(jsonEncode(value2.data)));
      //         if(lyricKeyEntity!=null&&lyricKeyEntity.status ==200&&lyricKeyEntity.candidates!.isNotEmpty){
      //           String  id = lyricKeyEntity.candidates?[0].id??'';
      //           String key = lyricKeyEntity.candidates?[0].accesskey??'';
      //           dio.get('http://lyrics.kugou.com/download?ver=1&client=pc&fmt=krc&charset=utf8',
      //               queryParameters: {'id': id,'accesskey':key}).then((value3) async{
      //             LyricContentEntity? lyricContentEntity =  JsonConvert.fromJsonAsT<LyricContentEntity>(jsonDecode(jsonEncode(value3.data)));
      //             if(lyricContentEntity!=null&&lyricContentEntity.status==200){
      //               Uint8List uint8list = base64Decode(lyricContentEntity.content??'');
      //               File file1 = await file.writeAsBytes(uint8list);
      //               String lyric = await file1.readAsString();
      //               log('lyric=====$lyric');
      //             }
      //
      //           });
      //         }
      //       });
      //     }
      //   });
      // }

      //
      mediaItem.value = value;
      ImageUtils.getImageColor(value.artUri?.path ?? '', (paletteColorData) {
        rx.value = paletteColorData;
        textColor.value = paletteColorData.light?.titleTextColor ?? AppTheme.onPrimary;
      });
    });
    audioServeHandler.playbackState.listen((value) => playing.value = value.playing);
    AudioService.position.listen((event) => duration.value = event);

    // audioServeHandler.queue.listen((value) {
    //   print('audioServeHandler.queue.listen=====${value.length}');
    // });
    // assetsAudioPlayer.current.listen((event) {
    //   if (event == null) {
    //     assetsAudioPlayer.next();
    //     return;
    //   }
    //   ImageUtils.getImageColor(event.audio.audio.metas.image?.path ?? '', (paletteColorData) {
    //     rx.value = paletteColorData;
    //     textColor.value = paletteColorData.light?.titleTextColor ?? AppTheme.onPrimary;
    //   });
    // });
    // assetsAudioPlayer.currentPosition.listen((event) {});
    requestPermission();
  }

  static HomeController get to => Get.find();

  requestPermission() async {
    // Web platform don't support permissions methods.
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
  }

  void playOrPause() async {
    if (playing.value) {
      await audioServeHandler.pause();
    } else {
      await audioServeHandler.play();
    }

    // await assetsAudioPlayer.playOrPause();
  }

  void changeSlidePosition(value, {bool second = false}) {
    slidePosition.value = value;
    if (this.second.value != second || (second && value == 1)) {
      this.second.value = second && value < 1;
    }
    if (this.second.value) {
      firstSlideIsDownSlide = value > 0;
    }

    // if (!this.second.value) {
    //   if (value >= .98) {
    //     changeSystemNavigationBarColor(rx.value.dark?.color ?? AppTheme.onPrimary);
    //   } else {
    //     if (systemUiOverlayStyle.systemNavigationBarColor != AppTheme.onPrimary) {
    //       changeSystemNavigationBarColor(Get.isPlatformDarkMode ? ThemeData.dark().bottomAppBarColor : ThemeData.light().bottomAppBarColor);
    //     }
    //   }
    // }
  }

  void changeSystemNavigationBarColor(Color color) {
    if (Platform.isAndroid) {
      systemUiOverlayStyle = SystemUiOverlayStyle(systemNavigationBarColor: color);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

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
    return panelHeaderSize * (1 + slidePosition.value * 6.6);
  }

  double getPanelAdd() {
    return MediaQuery.of(buildContext).padding.top * (second.value ? 1 : slidePosition.value) + getTopHeight() + (isRoot.value ? 0 : MediaQuery.of(buildContext).padding.bottom);
  }

  double getImageSize() {
    return (panelHeaderSize * .8) * (1 + slidePosition.value * 6.6);
  }

  double getImageLeft() {
    return ((Get.width - 60.w) - getImageSize()) / 2 * slidePosition.value;
  }

  double getTitleLeft() {
    return ((Get.width - 60.w) - getPanelMinSize()) / 2 * slidePosition.value + getPanelMinSize();
  }

  Color getHeaderColor() {
    return Theme.of(buildContext).bottomAppBarColor.withOpacity((second.value ? (1 - slidePosition.value) : slidePosition.value) > 0 ? 0 : 1);
    // return Color.fromRGBO(255, 255, 255, (second.value ? (1 - slidePosition.value) : slidePosition.value) > 0 ? 0 : 1);
  }

  Color getLightTextColor() {
    if (!second.value && slidePosition.value == 1) {
      return textColor.value;
    } else {
      if (second.value && slidePosition.value == 0) {
        return textColor.value;
      }
      return Theme.of(buildContext).colorScheme.onPrimary;
    }
  }

  double getTopHeight() {
    return topBarHeight * slidePosition.value;
  }

  EdgeInsets getHeaderPadding() {
    return EdgeInsets.only(left: 30.w, right: 30.w, top: MediaQuery.of(buildContext).padding.top * (second.value ? 1 : slidePosition.value));
  }

  //
  double getSecondPanelMinSize() {
    return secondPanelHeaderSize + MediaQuery.of(buildContext).padding.bottom;
  }

  void changeSelectIndex(int index) {
    selectIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeRoute(String? route) async {
    isRoot1 = route == '/';
    if (!isRoot1) {
      first = false;
      await Future.delayed(const Duration(milliseconds: 120));
    }
    isRoot.value = route == '/';
    if (!first) update([weSlideUpdate]);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    // Future.delayed(const Duration(seconds: 1),() =>
    //     changeSystemNavigationBarColor(Theme.of(Get.context!).bottomAppBarColor));
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
