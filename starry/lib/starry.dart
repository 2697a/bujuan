import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'music_item.dart';

typedef Future<String> GetSongUrl(String id);
enum PlayState { PLAYING, PAUSE, STOP, ERROR }
enum PlayListMode { SONG, FM, RADIO }
class SongUrl {
  GetSongUrl getSongUrl;

  SongUrl({this.getSongUrl});
}

class Starry {
  static const MethodChannel _channel = const MethodChannel('starry');
  static SongUrl songUrl;
  static const EventChannel eventChannel = const EventChannel('starry/event');
  static const EventChannel timingChannel = const EventChannel('starry/timing');

  ///歌曲播放状态
  static final StreamController<PlayState> _playerStateController = StreamController<PlayState>.broadcast();

  static Stream<PlayState> get onPlayerStateChanged => _playerStateController.stream;

  ///当前播放歌曲
  static final StreamController<PlayMusicInfo> _playerSongController = StreamController<PlayMusicInfo>.broadcast();

  static Stream<PlayMusicInfo> get onPlayerSongChanged => _playerSongController.stream;

  ///当前播放模式
  static final StreamController<int> _playerModeController = StreamController<int>.broadcast();

  static Stream<int> get onPlayerModeChanged => _playerModeController.stream;

  ///播放列表发生变化
  static final StreamController<PlayListInfo> _playerSongListController = StreamController<PlayListInfo>.broadcast();

  static Stream<PlayListInfo> get onPlayerSongListChanged => _playerSongListController.stream;

  ///初始化
  static Future<void> init({SongUrl url}) async {
    await _channel.invokeMethod('INIT');
    songUrl = url;
    _channel.setMethodCallHandler((call) => _platformCallHandler(call));
  }

  ///add播放类表并根据下标播放
  static Future<void> playMusic(List song, int index) async {
    var jsonEncode2 = jsonEncode(song);
    await _channel.invokeMethod('PLAY_MUSIC', {'PLAY_LIST': jsonEncode2, 'INDEX': index});
  }
  ///add播放类表并根据下标播放
  static Future<void> setPlayList(List song) async {
    var jsonEncode2 = jsonEncode(song);
    await _channel.invokeMethod('SET_PLAYLIST', {'PLAY_LIST': jsonEncode2});
  }

  ///add播放类表并根据下标播放
  static Future<void> addSong(List song) async {
    var jsonEncode2 = jsonEncode(song);
    await _channel.invokeMethod('ADD_SONG', {'ADD_PLAY_LIST': jsonEncode2});
  }


  ///add播放类表并根据下标播放
  static Future<void> removeSong(int size) async {
    await _channel.invokeMethod('REMOVE_SONG', {'SIZE': size});
  }

  ///根据下标播放歌曲
  static Future<void> playMusicByIndex(int index) async {
    await _channel.invokeMethod('PLAY_BY_INDEX', {'INDEX': index});
  }

  ///暂停
  static Future<void> pauseMusic() async {
    await _channel.invokeMethod('PAUSE');
  }

  ///恢复播放
  static Future<void> restoreMusic() async {
    await _channel.invokeMethod('RESTORE');
  }

  ///上一首
  static Future<void> skipToPrevious() async {
    await _channel.invokeMethod('PREVIOUS');
  }

  ///下一首
  static Future<void> skipToNext() async {
    await _channel.invokeMethod('NEXT');
  }

  ///获取正在播放
  static Future<MusicItem> getNowPlaying() async {
    var musicItemStr = await _channel.invokeMethod('NOW_PLAYING');
    if (musicItemStr != null && musicItemStr != '') {
      return MusicItem.fromJson(jsonDecode(musicItemStr));
    }
    return null;
  }

  ///开启计时器
  static Future<void> startTiming(int value) async{
    await _channel.invokeMethod('START_TIMING',{"VALUE":value});
  }

  ///关闭计时器
  static Future<void> stopTiming() async{
    await _channel.invokeMethod('STOP_TIMING');
  }

  ///切换歌曲播放进度
  static Future<void> changeSongSeek(seek) async {
    await _channel.invokeMethod('CHANGE_SEEK', {'SEEK': seek});
  }

  ///获取播放列表
  static Future<List<MusicItem>> getPlayList() async {
    var musicItemStr = await _channel.invokeMethod('PLAY_LIST');
    if (musicItemStr != null && musicItemStr != '') {
      List jsonDecode2 = jsonDecode(musicItemStr);
      var list = jsonDecode2.map((e) => MusicItem.fromJson(e)).toList();
      return list;
    }
    return null;
  }

  static Future<void> audioEffect() async {
    await _channel.invokeMethod('AUDIO_EFFECT');
  }

  ///是否开启抢占焦点
  static Future<int> toggleAudioFocus(bool value) async {
   return await _channel.invokeMethod('TOGGLE_IGNORE_AUDIO_FOCUS', {'IS_IGNORE': value});
  }

  ///设置循环方式
  static Future<int> setPlayMode(int value) async {
    return await _channel.invokeMethod('SET_PLAY_MODE', {'VALUE': value});
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
      var songMap = jsonDecode(arguments['MUSIC']);
      var musicItem = MusicItem.fromJson(songMap);
      _playerSongController.add(PlayMusicInfo(musicItem,arguments['POSITION']));
    } else if (method == 'PAUSE_OR_IDEA_SONG_INFO') {
      //暂停或初始化
      _playerStateController.add(PlayState.PAUSE);
    } else if (method == 'PLAY_ERROR') {
      //播放错误
      _playerStateController.add(PlayState.ERROR);
    } else if (method == 'PLAY_MODE_CHANGE') {
      //播放进度
      _playerModeController.add(arguments);
    } else if (method == 'PLAY_LIST_CHANGE') {
      //播放列表发生变化
      List list = jsonDecode(arguments['LIST']);
      int position = arguments['POSITION'];
      var playlist = list.map((e) => MusicItem.fromJson(e)).toList();
      _playerSongListController.add(PlayListInfo(playlist, position));
    }
  }
}

class PlayListInfo{
  final List<MusicItem> playlist;
  final int position;

  PlayListInfo(this.playlist, this.position);
}


class PlayMusicInfo{
  final MusicItem musicItem;
  final int position;

  PlayMusicInfo(this.musicItem, this.position);
}
