import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/lyric_entity.dart';

LyricEntity $LyricEntityFromJson(Map<String, dynamic> json) {
	final LyricEntity lyricEntity = LyricEntity();
	final bool? sgc = jsonConvert.convert<bool>(json['sgc']);
	if (sgc != null) {
		lyricEntity.sgc = sgc;
	}
	final bool? sfy = jsonConvert.convert<bool>(json['sfy']);
	if (sfy != null) {
		lyricEntity.sfy = sfy;
	}
	final bool? qfy = jsonConvert.convert<bool>(json['qfy']);
	if (qfy != null) {
		lyricEntity.qfy = qfy;
	}
	final LyricLrc? lrc = jsonConvert.convert<LyricLrc>(json['lrc']);
	if (lrc != null) {
		lyricEntity.lrc = lrc;
	}
	final LyricKlyric? klyric = jsonConvert.convert<LyricKlyric>(json['klyric']);
	if (klyric != null) {
		lyricEntity.klyric = klyric;
	}
	final LyricTlyric? tlyric = jsonConvert.convert<LyricTlyric>(json['tlyric']);
	if (tlyric != null) {
		lyricEntity.tlyric = tlyric;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		lyricEntity.code = code;
	}
	return lyricEntity;
}

Map<String, dynamic> $LyricEntityToJson(LyricEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['sgc'] = entity.sgc;
	data['sfy'] = entity.sfy;
	data['qfy'] = entity.qfy;
	data['lrc'] = entity.lrc?.toJson();
	data['klyric'] = entity.klyric?.toJson();
	data['tlyric'] = entity.tlyric?.toJson();
	data['code'] = entity.code;
	return data;
}

LyricLrc $LyricLrcFromJson(Map<String, dynamic> json) {
	final LyricLrc lyricLrc = LyricLrc();
	final int? version = jsonConvert.convert<int>(json['version']);
	if (version != null) {
		lyricLrc.version = version;
	}
	final String? lyric = jsonConvert.convert<String>(json['lyric']);
	if (lyric != null) {
		lyricLrc.lyric = lyric;
	}
	return lyricLrc;
}

Map<String, dynamic> $LyricLrcToJson(LyricLrc entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['version'] = entity.version;
	data['lyric'] = entity.lyric;
	return data;
}

LyricKlyric $LyricKlyricFromJson(Map<String, dynamic> json) {
	final LyricKlyric lyricKlyric = LyricKlyric();
	final int? version = jsonConvert.convert<int>(json['version']);
	if (version != null) {
		lyricKlyric.version = version;
	}
	final String? lyric = jsonConvert.convert<String>(json['lyric']);
	if (lyric != null) {
		lyricKlyric.lyric = lyric;
	}
	return lyricKlyric;
}

Map<String, dynamic> $LyricKlyricToJson(LyricKlyric entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['version'] = entity.version;
	data['lyric'] = entity.lyric;
	return data;
}

LyricTlyric $LyricTlyricFromJson(Map<String, dynamic> json) {
	final LyricTlyric lyricTlyric = LyricTlyric();
	final int? version = jsonConvert.convert<int>(json['version']);
	if (version != null) {
		lyricTlyric.version = version;
	}
	final String? lyric = jsonConvert.convert<String>(json['lyric']);
	if (lyric != null) {
		lyricTlyric.lyric = lyric;
	}
	return lyricTlyric;
}

Map<String, dynamic> $LyricTlyricToJson(LyricTlyric entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['version'] = entity.version;
	data['lyric'] = entity.lyric;
	return data;
}