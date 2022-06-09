import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/personalized_entity.dart';

PersonalizedEntity $PersonalizedEntityFromJson(Map<String, dynamic> json) {
	final PersonalizedEntity personalizedEntity = PersonalizedEntity();
	final bool? hasTaste = jsonConvert.convert<bool>(json['hasTaste']);
	if (hasTaste != null) {
		personalizedEntity.hasTaste = hasTaste;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		personalizedEntity.code = code;
	}
	final int? category = jsonConvert.convert<int>(json['category']);
	if (category != null) {
		personalizedEntity.category = category;
	}
	final List<PersonalizedResult>? result = jsonConvert.convertListNotNull<PersonalizedResult>(json['result']);
	if (result != null) {
		personalizedEntity.result = result;
	}
	return personalizedEntity;
}

Map<String, dynamic> $PersonalizedEntityToJson(PersonalizedEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['hasTaste'] = entity.hasTaste;
	data['code'] = entity.code;
	data['category'] = entity.category;
	data['result'] =  entity.result?.map((v) => v.toJson()).toList();
	return data;
}

PersonalizedResult $PersonalizedResultFromJson(Map<String, dynamic> json) {
	final PersonalizedResult personalizedResult = PersonalizedResult();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		personalizedResult.id = id;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		personalizedResult.type = type;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		personalizedResult.name = name;
	}
	final String? copywriter = jsonConvert.convert<String>(json['copywriter']);
	if (copywriter != null) {
		personalizedResult.copywriter = copywriter;
	}
	final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
	if (picUrl != null) {
		personalizedResult.picUrl = picUrl;
	}
	final bool? canDislike = jsonConvert.convert<bool>(json['canDislike']);
	if (canDislike != null) {
		personalizedResult.canDislike = canDislike;
	}
	final int? trackNumberUpdateTime = jsonConvert.convert<int>(json['trackNumberUpdateTime']);
	if (trackNumberUpdateTime != null) {
		personalizedResult.trackNumberUpdateTime = trackNumberUpdateTime;
	}
	final double? playCount = jsonConvert.convert<double>(json['playCount']);
	if (playCount != null) {
		personalizedResult.playCount = playCount;
	}
	final int? trackCount = jsonConvert.convert<int>(json['trackCount']);
	if (trackCount != null) {
		personalizedResult.trackCount = trackCount;
	}
	final bool? highQuality = jsonConvert.convert<bool>(json['highQuality']);
	if (highQuality != null) {
		personalizedResult.highQuality = highQuality;
	}
	final String? alg = jsonConvert.convert<String>(json['alg']);
	if (alg != null) {
		personalizedResult.alg = alg;
	}
	return personalizedResult;
}

Map<String, dynamic> $PersonalizedResultToJson(PersonalizedResult entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['type'] = entity.type;
	data['name'] = entity.name;
	data['copywriter'] = entity.copywriter;
	data['picUrl'] = entity.picUrl;
	data['canDislike'] = entity.canDislike;
	data['trackNumberUpdateTime'] = entity.trackNumberUpdateTime;
	data['playCount'] = entity.playCount;
	data['trackCount'] = entity.trackCount;
	data['highQuality'] = entity.highQuality;
	data['alg'] = entity.alg;
	return data;
}