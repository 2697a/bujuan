import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/lyric_hash_entity.g.dart';

@JsonSerializable()
class LyricHashEntity {
  LyricHashData? data;
  int? errcode;
  int? status;
  String? error;

  LyricHashEntity();

  factory LyricHashEntity.fromJson(Map<String, dynamic> json) => $LyricHashEntityFromJson(json);

  Map<String, dynamic> toJson() => $LyricHashEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricHashData {
  int? timestamp;
  List<LyricHashDataInfo>? info;
  int? total;

  LyricHashData();

  factory LyricHashData.fromJson(Map<String, dynamic> json) => $LyricHashDataFromJson(json);

  Map<String, dynamic> toJson() => $LyricHashDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricHashDataInfo {
  @JSONField(name: "320hash")
  String? x320hash;
  String? hash;
  int? sqfilesize;
  int? sqprivilege;
  @JSONField(name: "old_cpy")
  int? oldCpy;
  int? bitrate;
  int? ownercount;
  @JSONField(name: "320filesize")
  int? x320filesize;
  int? paytype;
  String? filename;
  @JSONField(name: "trans_param")
  LyricHashDataInfoTransParam? transParam;
  int? privilege;
  String? lyric;
  String? sqhash;
  int? failprocess;
  @JSONField(name: "320privilege")
  int? x320privilege;
  @JSONField(name: "album_audio_id")
  int? albumAudioId;
  @JSONField(name: "album_id")
  String? albumId;
  String? extname;
  int? filesize;
  int? m4afilesize;
  String? mvhash;
  int? duration;
  String? singername;
  String? type;

  LyricHashDataInfo();

  factory LyricHashDataInfo.fromJson(Map<String, dynamic> json) => $LyricHashDataInfoFromJson(json);

  Map<String, dynamic> toJson() => $LyricHashDataInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricHashDataInfoTransParam {
  @JSONField(name: "pay_block_tpl")
  int? payBlockTpl;
  LyricHashDataInfoTransParamClassmap? classmap;
  @JSONField(name: "cpy_level")
  int? cpyLevel;
  @JSONField(name: "cpy_grade")
  int? cpyGrade;
  int? cid;
  @JSONField(name: "appid_block")
  String? appidBlock;
  @JSONField(name: "cpy_attr0")
  int? cpyAttr0;
  @JSONField(name: "hash_multitrack")
  String? hashMultitrack;
  @JSONField(name: "hash_offset")
  LyricHashDataInfoTransParamHashOffset? hashOffset;
  @JSONField(name: "musicpack_advance")
  int? musicpackAdvance;
  int? display;
  @JSONField(name: "display_rate")
  int? displayRate;

  LyricHashDataInfoTransParam();

  factory LyricHashDataInfoTransParam.fromJson(Map<String, dynamic> json) => $LyricHashDataInfoTransParamFromJson(json);

  Map<String, dynamic> toJson() => $LyricHashDataInfoTransParamToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricHashDataInfoTransParamClassmap {
  int? attr0;

  LyricHashDataInfoTransParamClassmap();

  factory LyricHashDataInfoTransParamClassmap.fromJson(Map<String, dynamic> json) => $LyricHashDataInfoTransParamClassmapFromJson(json);

  Map<String, dynamic> toJson() => $LyricHashDataInfoTransParamClassmapToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class LyricHashDataInfoTransParamHashOffset {
  @JSONField(name: "clip_hash")
  String? clipHash;
  @JSONField(name: "start_byte")
  int? startByte;
  @JSONField(name: "end_ms")
  int? endMs;
  @JSONField(name: "end_byte")
  int? endByte;
  @JSONField(name: "file_type")
  int? fileType;
  @JSONField(name: "start_ms")
  int? startMs;
  @JSONField(name: "offset_hash")
  String? offsetHash;

  LyricHashDataInfoTransParamHashOffset();

  factory LyricHashDataInfoTransParamHashOffset.fromJson(Map<String, dynamic> json) => $LyricHashDataInfoTransParamHashOffsetFromJson(json);

  Map<String, dynamic> toJson() => $LyricHashDataInfoTransParamHashOffsetToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
