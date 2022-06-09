import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/personalized_entity.g.dart';

@JsonSerializable()
class PersonalizedEntity {

	bool? hasTaste;
	int? code;
	int? category;
	List<PersonalizedResult>? result;
  
  PersonalizedEntity();

  factory PersonalizedEntity.fromJson(Map<String, dynamic> json) => $PersonalizedEntityFromJson(json);

  Map<String, dynamic> toJson() => $PersonalizedEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PersonalizedResult {

	int? id;
	int? type;
	String? name;
	String? copywriter;
	String? picUrl;
	bool? canDislike;
	int? trackNumberUpdateTime;
	double? playCount;
	int? trackCount;
	bool? highQuality;
	String? alg;
  
  PersonalizedResult();

  factory PersonalizedResult.fromJson(Map<String, dynamic> json) => $PersonalizedResultFromJson(json);

  Map<String, dynamic> toJson() => $PersonalizedResultToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}