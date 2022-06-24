import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/lyric_key_entity.g.dart';

@JsonSerializable()
class LyricKeyEntity {

	List<dynamic>? ugccandidates;
	String? info;
	int? errcode;
	String? keyword;
	int? expire;
	String? companys;
	int? ugc;
	@JSONField(name: "has_complete_right")
	int? hasCompleteRight;
	int? ugccount;
	String? errmsg;
	String? proposal;
	int? status;
	List<LyricKeyCandidates>? candidates;
	List<dynamic>? artists;
  
  LyricKeyEntity();

  factory LyricKeyEntity.fromJson(Map<String, dynamic> json) => $LyricKeyEntityFromJson(json);

  Map<String, dynamic> toJson() => $LyricKeyEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricKeyCandidates {

	String? soundname;
	int? krctype;
	String? id;
	String? originame;
	String? accesskey;
	List<List>? parinfo;
	String? origiuid;
	String? transuid;
	int? score;
	int? hitlayer;
	int? duration;
	int? adjust;
	@JSONField(name: "can_score")
	bool? canScore;
	String? transname;
	String? uid;
	@JSONField(name: "lyric_comment_mark")
	List<dynamic>? lyricCommentMark;
	String? song;
	@JSONField(name: "product_from")
	String? productFrom;
	String? sounduid;
	List<LyricKeyCandidatesParinfoExt>? parinfoExt;
	String? nickname;
	int? contenttype;
	String? singer;
	String? language;
  
  LyricKeyCandidates();

  factory LyricKeyCandidates.fromJson(Map<String, dynamic> json) => $LyricKeyCandidatesFromJson(json);

  Map<String, dynamic> toJson() => $LyricKeyCandidatesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricKeyCandidatesParinfoExt {

	String? entry;
  
  LyricKeyCandidatesParinfoExt();

  factory LyricKeyCandidatesParinfoExt.fromJson(Map<String, dynamic> json) => $LyricKeyCandidatesParinfoExtFromJson(json);

  Map<String, dynamic> toJson() => $LyricKeyCandidatesParinfoExtToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}