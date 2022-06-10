import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/lyric_entity.g.dart';

@JsonSerializable()
class LyricEntity {

	bool? sgc;
	bool? sfy;
	bool? qfy;
	LyricLrc? lrc;
	LyricKlyric? klyric;
	LyricTlyric? tlyric;
	int? code;
  
  LyricEntity();

  factory LyricEntity.fromJson(Map<String, dynamic> json) => $LyricEntityFromJson(json);

  Map<String, dynamic> toJson() => $LyricEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricLrc {

	int? version;
	String? lyric;
  
  LyricLrc();

  factory LyricLrc.fromJson(Map<String, dynamic> json) => $LyricLrcFromJson(json);

  Map<String, dynamic> toJson() => $LyricLrcToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricKlyric {

	int? version;
	String? lyric;
  
  LyricKlyric();

  factory LyricKlyric.fromJson(Map<String, dynamic> json) => $LyricKlyricFromJson(json);

  Map<String, dynamic> toJson() => $LyricKlyricToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricTlyric {

	int? version;
	String? lyric;
  
  LyricTlyric();

  factory LyricTlyric.fromJson(Map<String, dynamic> json) => $LyricTlyricFromJson(json);

  Map<String, dynamic> toJson() => $LyricTlyricToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}