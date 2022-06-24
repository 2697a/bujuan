import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/lyric_content_entity.dart';

LyricContentEntity $LyricContentEntityFromJson(Map<String, dynamic> json) {
	final LyricContentEntity lyricContentEntity = LyricContentEntity();
	final String? info = jsonConvert.convert<String>(json['info']);
	if (info != null) {
		lyricContentEntity.info = info;
	}
	final String? fmt = jsonConvert.convert<String>(json['fmt']);
	if (fmt != null) {
		lyricContentEntity.fmt = fmt;
	}
	final String? charset = jsonConvert.convert<String>(json['charset']);
	if (charset != null) {
		lyricContentEntity.charset = charset;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		lyricContentEntity.content = content;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		lyricContentEntity.status = status;
	}
	final int? errorCode = jsonConvert.convert<int>(json['error_code']);
	if (errorCode != null) {
		lyricContentEntity.errorCode = errorCode;
	}
	return lyricContentEntity;
}

Map<String, dynamic> $LyricContentEntityToJson(LyricContentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['info'] = entity.info;
	data['fmt'] = entity.fmt;
	data['charset'] = entity.charset;
	data['content'] = entity.content;
	data['status'] = entity.status;
	data['error_code'] = entity.errorCode;
	return data;
}