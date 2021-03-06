import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:starry/song_info.dart';

typedef Future<String> GetSongUrl(String id);
enum PlayState { PLAYING, PAUSE, STOP, ERROR }

class SongUrl {
  GetSongUrl getSongUrl;

  SongUrl({this.getSongUrl});
}

class Starry {
  static const MethodChannel _channel = const MethodChannel('starry');
  static SongUrl songUrl;

  ///歌曲播放状态
  static final StreamController<PlayState> _playerStateController =
      StreamController<PlayState>.broadcast();

  static Stream<PlayState> get onPlayerStateChanged =>
      _playerStateController.stream;

  ///当前播放歌曲
  static final StreamController<SongInfo> _playerSongController =
      StreamController<SongInfo>.broadcast();

  static Stream<SongInfo> get onPlayerSongChanged =>
      _playerSongController.stream;

  ///当前播放歌曲进度
  static final StreamController<double> _playerSongPosController =
      StreamController<double>.broadcast();

  static Stream<num> get onPlayerSongPosChanged =>
      _playerSongPosController.stream;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///初始化
  static Future<void> init({SongUrl url}) async {
    songUrl = url;
    _channel.setMethodCallHandler((call) => _platformCallHandler(call));
  }

  ///add播放类表并根据下标播放
  static Future<void> playMusic(List song, int index) async {
    var jsonEncode2 = jsonEncode(song);
    await _channel
        .invokeMethod('PLAY_MUSIC', {"PLAY_LIST": jsonEncode2, "INDEX": index});
  }

  ///根据下标播放歌曲
  static Future<void> playMusicById(String id) async {
    await _channel.invokeMethod('PLAY_BY_ID', {"ID": id});
  }

  ///暂停
  static Future<void> pauseMusic() async {
    await _channel.invokeMethod("PAUSE");
  }

  ///恢复播放
  static Future<void> restoreMusic() async {
    await _channel.invokeMethod("RESTORE");
  }

  ///上一首
  static Future<void> skipToPrevious() async {
    await _channel.invokeMethod("PREVIOUS");
  }

  ///下一首
  static Future<void> skipToNext() async {
    await _channel.invokeMethod("NEXT");
  }

  static Future<dynamic> _platformCallHandler(MethodCall call) async {
    var method = call.method;
    var arguments = call.arguments;
    if (method == 'GET_SONG_URL') {
      var future = songUrl?.getSongUrl(arguments);
      return future;
    } else if (method == 'PLAYING_SONG_INFO') {
      //当前播放歌曲
      _playerStateController.add(PlayState.PLAYING);
    } else if (method == 'SWITCH_SONG_INFO') {
      //切歌
      var songMap = jsonDecode(arguments);
      var songInfo = SongInfo.fromJson(songMap);
      _playerSongController.add(songInfo);
    } else if (method == 'PAUSE_OR_IDEA_SONG_INFO') {
      //暂停或初始化
      _playerStateController.add(PlayState.PAUSE);
    } else if (method == 'PLAT_ERROR') {
      //播放错误
      _playerStateController.add(PlayState.ERROR);
    } else if (method == 'PLAT_PROGRESS') {
      //播放错误
      _playerSongPosController.add(arguments);
    }
  }
}
