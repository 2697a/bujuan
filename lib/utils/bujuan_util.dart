import 'dart:convert';
import 'dart:io';

import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:starry/music_item.dart';
import 'package:starry/starry.dart';

import '../main.dart';

class BuJuanUtil {
  static String unix2Time(unix) {
    // unix = unix ~/ 1000;
    var hourStr, minStr, secStr;
    var hour = unix ~/ (60 * 60);
    var min = (unix - hour * (60 * 60)) ~/ 60;
    var sec = unix - hour * (60 * 60) - min * 60;
    hourStr = '$hour';
    minStr = '$min';
    secStr = '$sec';
    if (hour < 10) hourStr = '0$hour';
    if (min < 10) minStr = '0$min';
    if (sec < 10) secStr = '0$sec';
    return '${hourStr == '00' ? '' : '$hourStr:'}$minStr:$secStr';
  }

  static String unix2TimeTo(unix) {
    unix = unix ~/ 1000;
    var minStr, secStr;
    var min = unix ~/ 60;
    var sec = (unix - min * 60);
    minStr = '$min';
    secStr = '$sec';
    if (min < 10) minStr = '0$min';
    if (sec < 10) secStr = '0$sec';
    return '$minStr:$secStr';
  }

  static String dateToString(DateTime dateTime, type) {
    var monthStr, dayStr;
    var month = dateTime.month;
    monthStr = '$month';
    var day = dateTime.day;
    dayStr = '$day';
    if (month < 10) monthStr = '0$month';
    if (day < 10) dayStr = '0$day';
    if (type == 1) return '$dayStr';
    return '$monthStr / ';
  }

  /// 设置沉浸式导航栏文字颜色
  ///
  /// [light] 状态栏文字是否为白色
  static SystemUiOverlayStyle setNavigationBarTextColor(bool dark) {
    return !dark
        ? SystemUiOverlayStyle(
            systemNavigationBarColor: lightTheme.canvasColor,
            systemNavigationBarDividerColor: lightTheme.canvasColor,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          )
        : SystemUiOverlayStyle(
            systemNavigationBarColor: darkTheme.canvasColor,
            systemNavigationBarDividerColor: darkTheme.canvasColor,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          );
  }

  static List<Lyric> getLyric(String lyric) {
    var split = lyric.split('\n');
    split.forEach((str) {});
  }

  static List<Lyric> analysisLyric(lyric) {
    List<Lyric> lyricList = new List();
    List<String> list = lyric.split('\n');
    list.forEach((String str) {
      if (str != '') {
        if ((str.indexOf('[ar:') != -1) ||
            (str.indexOf('[ti:') != -1) ||
            (str.indexOf('[by:') != -1) ||
            (str.indexOf('[al:') != -1) ||
            str == ' ') {
          return;
        }
        int pos1 = str.indexOf('[');
        int pos2 = str.indexOf(']');
        if (pos1 == 0 && pos2 != -1) {
          var substring = str
              .substring(pos1, pos2 + 1)
              .replaceAll('[', '')
              .replaceAll(']', '');
          var text = str.substring(pos2 + 1, str.length);
          int str2millisecond = str2Millisecond(substring);
          Lyric lyricBeanEntity = Lyric(str2millisecond, text);
          lyricList.add(lyricBeanEntity);
        } else {
          return;
        }
      }
    });

    return lyricList;
  }

  static TextStyle getLyricStyle(
      List<Lyric> lyricBean, int index, int currPos) {
    TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300);
    if (lyricBean[index].time <= currPos) {
      textStyle = TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.blue);
    }
    return textStyle;
  }

  static int str2Millisecond(str) {
    if (str.length == 9 || str.length == 8) {
      str = str.replaceAll(':', '.'); //00.40.57
      str = str.replaceAll('.', '@'); //00@40@57
      var timeData = str.split('@'); //[00, 40, 57]
      int minute = int.parse(timeData[0]); //数组里的第1个数据是分0
      int second = int.parse(timeData[1]); //数组里的第2个数据是秒40
      int millisecond = int.parse(timeData[2]); //数组里的第3个数据是秒57
      return (minute * 60 * 1000 +
          second * 1000 +
          millisecond); //40000+570=40570
    }
    return 0;
  }

  ///检查文件是否存在
  static Future<bool> checkFileExists(path) async {
    var directory = Get.find<FileService>().directory.value;
    File file = File('${directory.path}$path');
    return await file.exists();
  }

  ///读取文件并转成map
  static Future<dynamic> readStringFile(path) async {
    var directory = Get.find<FileService>().directory.value;
    File file = File('${directory.path}$path');
    return jsonDecode(await file.readAsString());
  }

  static playSongByIndex(
      List<MusicItem> playlist, index, PlayListMode playListMode) async {
    SpUtil.putInt(PLAY_LIST_MODE, playListMode.index);
    GlobalController.to.playListMode.value = playListMode;
    if (playlist.length > 0) {
      await Starry.playMusic(playlist, index);
    } else {
      await Starry.playMusicByIndex(index);
    }
  }

  static String getPlayListModeStr(PlayListMode playListMode) {
    switch (playListMode) {
      case PlayListMode.SONG:
        return "Song";
        break;
      case PlayListMode.FM:
        return "FM";
        break;
      case PlayListMode.RADIO:
        return "电台";
        break;
    }
    return '';
  }
}

class Lyric {
  int time;
  String lyricStr;

  Lyric(this.time, this.lyricStr);
}
