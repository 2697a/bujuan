import 'package:flutter/cupertino.dart';

class SongInfo {
  String songId;
  String songName;
  String artist;
  String songCover;
  String songUrl;
  int duration;
  bool isLike;

  SongInfo({@required this.songId, @required this.duration,this.songUrl, this.songName, this.artist, this.songCover,this.isLike});

  SongInfo.fromJson(Map<String, dynamic> json) {
    songId = json['songId'];
    duration = json['duration']??0;
    songName = json['songName'];
    artist = json['artist'];
    songCover = json['songCover'] ?? '';
    songUrl = json['songUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['songId'] = this.songId;
    data['duration'] = this.duration;
    data['songName'] = this.songName;
    data['artist'] = this.artist ?? '';
    data['songCover'] = this.songCover ?? '';
    data['songUrl'] = this.songUrl;
    return data;
  }
}
