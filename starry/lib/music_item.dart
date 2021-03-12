import 'package:flutter/cupertino.dart';

class MusicItem {
  String musicId;
  String title;
  String artist;
  String iconUri;
  String uri;
  int duration;

  MusicItem({@required this.musicId, @required this.duration,this.uri, this.title, this.artist, this.iconUri});

  MusicItem.fromJson(Map<String, dynamic> json) {
    musicId = json['musicId'];
    duration = json['duration']??0;
    title = json['title'];
    artist = json['artist'];
    iconUri = json['iconUri']+"?param=300y300" ?? '';
    uri = json['uri']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['musicId'] = this.musicId;
    data['duration'] = this.duration;
    data['title'] = this.title;
    data['artist'] = this.artist ?? '';
    data['iconUri'] = this.iconUri ?? '';
    data['uri'] = this.uri;
    return data;
  }
}
