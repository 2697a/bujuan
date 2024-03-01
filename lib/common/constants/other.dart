import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:palette_generator/palette_generator.dart';

import '../netease_api/src/api/play/bean.dart';
import 'enmu.dart';
import 'images.dart';

class OtherUtils {
  OtherUtils._();

  static Future<PaletteGenerator> getImageColor(String url) async {
    if (url.replaceAll('?param=500y500', '').isEmpty) {
      ExtendedAssetImageProvider imageProvider = const ExtendedAssetImageProvider(placeholderImage);
      return await getImageColorByProvider(imageProvider);
    }
    if (url.startsWith('http')) {
      CachedNetworkImageProvider imageProvider = CachedNetworkImageProvider(url,headers: const {'User-Agent':'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.35'});
      return await getImageColorByProvider(imageProvider);
    } else {
      ExtendedFileImageProvider imageProvider = ExtendedFileImageProvider(File(url.split('?').first));
      return await getImageColorByProvider(imageProvider);
    }
  }

  static Future<PaletteGenerator> getImageColorByProvider(ImageProvider imageProvider) async {
    return await PaletteGenerator.fromImageProvider(imageProvider, size: const Size(300, 300));
  }

  static String getTimeStamp(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  static String formatDate2Str(int time) {
    if (time <= 0) return '';
    return formatDate(DateTime.fromMillisecondsSinceEpoch(time), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
  }

  static bool isPad(){
      final data = MediaQueryData.fromView(PlatformDispatcher.instance.implicitView!);
      return data.size.shortestSide >= 600;
  }

  static List<MediaItem> song2ToMedia(List<Song2> songs) {
    return songs
        .map((e) => MediaItem(
        id: e.id,
        duration: Duration(milliseconds: e.dt ?? 0),
        artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=500y500'),
        extras: {
          'type': MediaType.playlist.name,
          'image': e.al?.picUrl ?? '',
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
}

class PaletteColorData {
  PaletteColor? light;
  PaletteColor? light1;
  PaletteColor? dark;
  PaletteColor? main;
  PaletteColor? main1;

  PaletteColorData({this.light, this.dark, this.main, this.light1, this.main1});
}

class WidgetUtil {
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Lottie.asset(
                'assets/lottie/empty_status.json',
                width: 750.w / 4,
                height: 750.w / 4,
                fit: BoxFit.fitWidth,
                // filterQuality: FilterQuality.low,
              ),
            ));
  }
}
