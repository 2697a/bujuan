import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/song_details_entity.g.dart';

@JsonSerializable()
class SongDetailsEntity {

	List<SongDetailsSongs>? songs;
  
  SongDetailsEntity();

  factory SongDetailsEntity.fromJson(Map<String, dynamic> json) => $SongDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongs {

	String? name;
	int? id;
	int? pst;
	int? t;
	List<SongDetailsSongsAr>? ar;
	List<dynamic>? alia;
	double? pop;
	int? st;
	String? rt;
	int? fee;
	int? v;
	dynamic crbt;
	String? cf;
	SongDetailsSongsAl? al;
	int? dt;
	SongDetailsSongsH? h;
	SongDetailsSongsM? m;
	SongDetailsSongsL? l;
	SongDetailsSongsSq? sq;
	SongDetailsSongsHr? hr;
	dynamic a;
	String? cd;
	int? no;
	dynamic rtUrl;
	int? ftype;
	List<dynamic>? rtUrls;
	int? djId;
	int? copyright;
	@JSONField(name: "s_id")
	int? sId;
	int? mark;
	int? originCoverType;
	SongDetailsSongsOriginSongSimpleData? originSongSimpleData;
	dynamic tagPicList;
	bool? resourceState;
	int? version;
	dynamic songJumpInfo;
	dynamic entertainmentTags;
	int? single;
	SongDetailsSongsNoCopyrightRcmd? noCopyrightRcmd;
	int? rtype;
	dynamic rurl;
	int? mst;
	int? cp;
	int? mv;
	int? publishTime;
	List<String>? tns;
  
  SongDetailsSongs();

  factory SongDetailsSongs.fromJson(Map<String, dynamic> json) => $SongDetailsSongsFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsAr {

	int? id;
	String? name;
	List<dynamic>? tns;
	List<dynamic>? alias;
  
  SongDetailsSongsAr();

  factory SongDetailsSongsAr.fromJson(Map<String, dynamic> json) => $SongDetailsSongsArFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsArToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsAl {

	int? id;
	String? name;
	String? picUrl;
	List<dynamic>? tns;
	@JSONField(name: "pic_str")
	String? picStr;
	int? pic;
  
  SongDetailsSongsAl();

  factory SongDetailsSongsAl.fromJson(Map<String, dynamic> json) => $SongDetailsSongsAlFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsAlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsH {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  SongDetailsSongsH();

  factory SongDetailsSongsH.fromJson(Map<String, dynamic> json) => $SongDetailsSongsHFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsHToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsM {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  SongDetailsSongsM();

  factory SongDetailsSongsM.fromJson(Map<String, dynamic> json) => $SongDetailsSongsMFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsMToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsL {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  SongDetailsSongsL();

  factory SongDetailsSongsL.fromJson(Map<String, dynamic> json) => $SongDetailsSongsLFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsLToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsSq {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  SongDetailsSongsSq();

  factory SongDetailsSongsSq.fromJson(Map<String, dynamic> json) => $SongDetailsSongsSqFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsSqToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsHr {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  SongDetailsSongsHr();

  factory SongDetailsSongsHr.fromJson(Map<String, dynamic> json) => $SongDetailsSongsHrFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsHrToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsOriginSongSimpleData {

	int? songId;
	String? name;
	List<SongDetailsSongsOriginSongSimpleDataArtists>? artists;
	SongDetailsSongsOriginSongSimpleDataAlbumMeta? albumMeta;
  
  SongDetailsSongsOriginSongSimpleData();

  factory SongDetailsSongsOriginSongSimpleData.fromJson(Map<String, dynamic> json) => $SongDetailsSongsOriginSongSimpleDataFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsOriginSongSimpleDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsOriginSongSimpleDataArtists {

	int? id;
	String? name;
  
  SongDetailsSongsOriginSongSimpleDataArtists();

  factory SongDetailsSongsOriginSongSimpleDataArtists.fromJson(Map<String, dynamic> json) => $SongDetailsSongsOriginSongSimpleDataArtistsFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsOriginSongSimpleDataArtistsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsOriginSongSimpleDataAlbumMeta {

	int? id;
	String? name;
  
  SongDetailsSongsOriginSongSimpleDataAlbumMeta();

  factory SongDetailsSongsOriginSongSimpleDataAlbumMeta.fromJson(Map<String, dynamic> json) => $SongDetailsSongsOriginSongSimpleDataAlbumMetaFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsOriginSongSimpleDataAlbumMetaToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongDetailsSongsNoCopyrightRcmd {

	int? type;
	String? typeDesc;
	dynamic songId;
  
  SongDetailsSongsNoCopyrightRcmd();

  factory SongDetailsSongsNoCopyrightRcmd.fromJson(Map<String, dynamic> json) => $SongDetailsSongsNoCopyrightRcmdFromJson(json);

  Map<String, dynamic> toJson() => $SongDetailsSongsNoCopyrightRcmdToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}