import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/song_url_entity.g.dart';

@JsonSerializable()
class SongUrlEntity {

	List<SongUrlData>? data;
	int? code;
  
  SongUrlEntity();

  factory SongUrlEntity.fromJson(Map<String, dynamic> json) => $SongUrlEntityFromJson(json);

  Map<String, dynamic> toJson() => $SongUrlEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongUrlData {

	int? id;
	String? url;
	int? br;
	int? size;
	String? md5;
	int? code;
	int? expi;
	String? type;
	double? gain;
	int? fee;
	dynamic uf;
	int? payed;
	int? flag;
	bool? canExtend;
	SongUrlDataFreeTrialInfo? freeTrialInfo;
	String? level;
	String? encodeType;
	SongUrlDataFreeTrialPrivilege? freeTrialPrivilege;
	SongUrlDataFreeTimeTrialPrivilege? freeTimeTrialPrivilege;
	int? urlSource;
  
  SongUrlData();

  factory SongUrlData.fromJson(Map<String, dynamic> json) => $SongUrlDataFromJson(json);

  Map<String, dynamic> toJson() => $SongUrlDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongUrlDataFreeTrialInfo {

	int? start;
	int? end;
  
  SongUrlDataFreeTrialInfo();

  factory SongUrlDataFreeTrialInfo.fromJson(Map<String, dynamic> json) => $SongUrlDataFreeTrialInfoFromJson(json);

  Map<String, dynamic> toJson() => $SongUrlDataFreeTrialInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongUrlDataFreeTrialPrivilege {

	bool? resConsumable;
	bool? userConsumable;
	dynamic listenType;
  
  SongUrlDataFreeTrialPrivilege();

  factory SongUrlDataFreeTrialPrivilege.fromJson(Map<String, dynamic> json) => $SongUrlDataFreeTrialPrivilegeFromJson(json);

  Map<String, dynamic> toJson() => $SongUrlDataFreeTrialPrivilegeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SongUrlDataFreeTimeTrialPrivilege {

	bool? resConsumable;
	bool? userConsumable;
	int? type;
	int? remainTime;
  
  SongUrlDataFreeTimeTrialPrivilege();

  factory SongUrlDataFreeTimeTrialPrivilege.fromJson(Map<String, dynamic> json) => $SongUrlDataFreeTimeTrialPrivilegeFromJson(json);

  Map<String, dynamic> toJson() => $SongUrlDataFreeTimeTrialPrivilegeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}