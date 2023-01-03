import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../common/constants/other.dart';
import '../../../common/test_audio_handler.dart';
import '../../../widget/weslide/weslide_controller.dart';

class BodyModel extends ChangeNotifier{
  double panelHeaderSize = 90.h;
  double secondPanelHeaderSize = 120.w;
  double panelMobileMinSize = 90.h;
  double topBarHeight = 110.h;

  WeSlideController weSlideController = WeSlideController();

  final TextAudioHandler audioServeHandler = GetIt.instance<TextAudioHandler>();

  //当前播放歌曲
  MediaItem mediaItem = const MediaItem(id: '', title: '暂无', duration: Duration(seconds: 10));

  //当前歌曲的色调
  PaletteColorData paletteColorData = PaletteColorData();

  List<MediaItem> mediaItems = <MediaItem>[];

  double weSlidePosition = 0;
  double headColorOpacity = 1;
  double headPaddingTop = 0;

  double panelPosition = 0;


}