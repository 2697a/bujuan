import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'music_item.dart';

typedef Future<String> GetSongUrl(String id);
enum PlayState { PLAYING, PAUSE, STOP, ERROR }

class SongUrl {
  GetSongUrl getSongUrl;

  SongUrl({this.getSongUrl});
}

class Starry {
  static const MethodChannel _channel = const MethodChannel('starry');
  static SongUrl songUrl;
  static const EventChannel eventChannel = const EventChannel('starry/event');

  ///歌曲播放状态
  static final StreamController<PlayState> _playerStateController =
      StreamController<PlayState>.broadcast();

  static Stream<PlayState> get onPlayerStateChanged =>
      _playerStateController.stream;

  ///当前播放歌曲
  static final StreamController<MusicItem> _playerSongController =
      StreamController<MusicItem>.broadcast();

  static Stream<MusicItem> get onPlayerSongChanged =>
      _playerSongController.stream;

  ///当前播放歌曲进度
  static final StreamController<int> _playerSongPosController =
      StreamController<int>.broadcast();

  static Stream<int> get onPlayerSongPosChanged =>
      _playerSongPosController.stream;

  ///播放列表发生变化
  static final StreamController<List<MusicItem>> _playerSongListController =
      StreamController<List<MusicItem>>.broadcast();

  static Stream<List<MusicItem>> get onPlayerSongListChanged =>
      _playerSongListController.stream;

  ///初始化
  static Future<void> init({SongUrl url}) async {
    await _channel.invokeMethod('INIT');
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
  static Future<void> playMusicByIndex(int index) async {
    await _channel.invokeMethod('PLAY_BY_INDEX', {"INDEX": index});
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

  ///下一首
  static Future<MusicItem> getNowPlaying() async {
    var musicItemStr = await _channel.invokeMethod("NOW_PLAYING");
    if (musicItemStr != null && musicItemStr != "") {
      return MusicItem.fromJson(jsonDecode(musicItemStr));
    }
    return null;
  }

  ///切换歌曲播放进度
  static Future<void> changeSongSeek(seek) async {
    await _channel.invokeMethod("CHANGE_SEEK", {"SEEK": seek});
  }

  ///获取播放列表
  static Future<List<MusicItem>> getPlayList() async {
    var musicItemStr = await _channel.invokeMethod("PLAY_LIST");
    if (musicItemStr != null && musicItemStr != "") {
      List jsonDecode2 = jsonDecode(musicItemStr);
      var list = jsonDecode2.map((e) => MusicItem.fromJson(e)).toList();
      return list;
    }
    return null;
  }

  static Future<dynamic> _platformCallHandler(MethodCall call) async {
    var method = call.method;
    var arguments = call.arguments;
    if (method == 'GET_SONG_URL') {
      var future = songUrl?.getSongUrl(arguments);
      return future;
    } else if (method == 'PLAYING_SONG_INFO') {
      //当前播放歌曲
      _playerSongPosController.add(arguments);
      _playerStateController.add(PlayState.PLAYING);
    } else if (method == 'SWITCH_SONG_INFO') {
      //切歌
      var songMap = jsonDecode(arguments);
      var musicItem = MusicItem.fromJson(songMap);
      _playerSongController.add(musicItem);
    } else if (method == 'PAUSE_OR_IDEA_SONG_INFO') {
      //暂停或初始化
      _playerStateController.add(PlayState.PAUSE);
    } else if (method == 'PLAY_ERROR') {
      //播放错误
      _playerStateController.add(PlayState.ERROR);
    } else if (method == 'PLAY_PROGRESS') {
      //播放进度
      _playerSongPosController.add(arguments);
    } else if (method == 'PLAY_LIST_CHANGE') {
      //播放列表发生变化
      List list = jsonDecode(arguments);
      var playList = list.map((e) => MusicItem.fromJson(e)).toList();
      _playerSongListController.add(playList);
    }
  }
}
