import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/lyric_content_entity.g.dart';

@JsonSerializable()
class LyricContentEntity {

	String? info;
	String? fmt;
	String? charset;
	String? content;
	int? status;
	@JSONField(name: "error_code")
	int? errorCode;
  
  LyricContentEntity();

  factory LyricContentEntity.fromJson(Map<String, dynamic> json) => $LyricContentEntityFromJson(json);

  Map<String, dynamic> toJson() => $LyricContentEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}