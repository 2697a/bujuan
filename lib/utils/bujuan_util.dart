import 'package:flutter/material.dart';

class BuJuanUtil {
  static String unix2Time(unix) {
    var minStr, secStr;
    var min = unix ~/ 60;
    var sec = unix - min * 60;
    minStr = '$min';
    secStr = '$sec';
    if (min < 10) minStr = '0$min';
    if (sec < 10) secStr = '0$sec';
    return '$minStr:$secStr';
  }

  static String dateToString(DateTime dateTime,type){
    var monthStr, dayStr;
    var month = dateTime.month;
    monthStr = '$month';
    var day = dateTime.day;
    dayStr = '$day';
    if (month < 10) monthStr = '0$month';
    if (day < 10) dayStr = '0$day';
    if(type ==1) return '$dayStr';
    return '$monthStr / ';
  }
  static isEmail(String email) {
    return new RegExp(r'^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$').hasMatch(email);
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


  static showToast(msg) {
//    Fluttertoast.showToast(
//        msg: msg,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.white,
//        textColor: Colors.black,
//        fontSize: 14.0);
  }
}

class Lyric {
  int time;
  String lyricStr;

  Lyric(this.time, this.lyricStr);
}
