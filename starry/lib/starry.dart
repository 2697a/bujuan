import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:starry/song_info.dart';

typedef Future<String> GetSongUrl(String id);

class SongUrl {
  GetSongUrl getSongUrl;

  SongUrl({this.getSongUrl});
}

class Starry {
  static const MethodChannel _channel = const MethodChannel('starry');
  static SongUrl songUrl;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> init({SongUrl url}) async {
    songUrl = url;
    _channel.setMethodCallHandler((call) => _platformCallHandler(call));
  }

  static Future<void> playMusic(List<SongInfo> song, int index) async {
    var jsonEncode2 = jsonEncode(song);
    await _channel.invokeMethod('PLAY_MUSIC', {"PLAY_LIST": jsonEncode2, "INDEX": index});
  }

  static Future<dynamic> _platformCallHandler(MethodCall call) async {
    var method = call.method;
    var arguments = call.arguments;
    if (method == 'currSong') {
      return songUrl?.getSongUrl(arguments);
    }
  }
}
