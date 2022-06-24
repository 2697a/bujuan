import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/lyric_hash_entity.dart';

LyricHashEntity $LyricHashEntityFromJson(Map<String, dynamic> json) {
	final LyricHashEntity lyricHashEntity = LyricHashEntity();
	final LyricHashData? data = jsonConvert.convert<LyricHashData>(json['data']);
	if (data != null) {
		lyricHashEntity.data = data;
	}
	final int? errcode = jsonConvert.convert<int>(json['errcode']);
	if (errcode != null) {
		lyricHashEntity.errcode = errcode;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		lyricHashEntity.status = status;
	}
	final String? error = jsonConvert.convert<String>(json['error']);
	if (error != null) {
		lyricHashEntity.error = error;
	}
	return lyricHashEntity;
}

Map<String, dynamic> $LyricHashEntityToJson(LyricHashEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] = entity.data?.toJson();
	data['errcode'] = entity.errcode;
	data['status'] = entity.status;
	data['error'] = entity.error;
	return data;
}

LyricHashData $LyricHashDataFromJson(Map<String, dynamic> json) {
	final LyricHashData lyricHashData = LyricHashData();
	final int? timestamp = jsonConvert.convert<int>(json['timestamp']);
	if (timestamp != null) {
		lyricHashData.timestamp = timestamp;
	}
	final List<LyricHashDataInfo>? info = jsonConvert.convertListNotNull<LyricHashDataInfo>(json['info']);
	if (info != null) {
		lyricHashData.info = info;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		lyricHashData.total = total;
	}
	return lyricHashData;
}

Map<String, dynamic> $LyricHashDataToJson(LyricHashData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['timestamp'] = entity.timestamp;
	data['info'] =  entity.info?.map((v) => v.toJson()).toList();
	data['total'] = entity.total;
	return data;
}

LyricHashDataInfo $LyricHashDataInfoFromJson(Map<String, dynamic> json) {
	final LyricHashDataInfo lyricHashDataInfo = LyricHashDataInfo();
	final String? x320hash = jsonConvert.convert<String>(json['320hash']);
	if (x320hash != null) {
		lyricHashDataInfo.x320hash = x320hash;
	}
	final String? hash = jsonConvert.convert<String>(json['hash']);
	if (hash != null) {
		lyricHashDataInfo.hash = hash;
	}
	final int? sqfilesize = jsonConvert.convert<int>(json['sqfilesize']);
	if (sqfilesize != null) {
		lyricHashDataInfo.sqfilesize = sqfilesize;
	}
	final int? sqprivilege = jsonConvert.convert<int>(json['sqprivilege']);
	if (sqprivilege != null) {
		lyricHashDataInfo.sqprivilege = sqprivilege;
	}
	final int? oldCpy = jsonConvert.convert<int>(json['old_cpy']);
	if (oldCpy != null) {
		lyricHashDataInfo.oldCpy = oldCpy;
	}
	final int? bitrate = jsonConvert.convert<int>(json['bitrate']);
	if (bitrate != null) {
		lyricHashDataInfo.bitrate = bitrate;
	}
	final int? ownercount = jsonConvert.convert<int>(json['ownercount']);
	if (ownercount != null) {
		lyricHashDataInfo.ownercount = ownercount;
	}
	final int? x320filesize = jsonConvert.convert<int>(json['320filesize']);
	if (x320filesize != null) {
		lyricHashDataInfo.x320filesize = x320filesize;
	}
	final int? paytype = jsonConvert.convert<int>(json['paytype']);
	if (paytype != null) {
		lyricHashDataInfo.paytype = paytype;
	}
	final String? filename = jsonConvert.convert<String>(json['filename']);
	if (filename != null) {
		lyricHashDataInfo.filename = filename;
	}
	final LyricHashDataInfoTransParam? transParam = jsonConvert.convert<LyricHashDataInfoTransParam>(json['trans_param']);
	if (transParam != null) {
		lyricHashDataInfo.transParam = transParam;
	}
	final int? privilege = jsonConvert.convert<int>(json['privilege']);
	if (privilege != null) {
		lyricHashDataInfo.privilege = privilege;
	}
	final String? lyric = jsonConvert.convert<String>(json['lyric']);
	if (lyric != null) {
		lyricHashDataInfo.lyric = lyric;
	}
	final String? sqhash = jsonConvert.convert<String>(json['sqhash']);
	if (sqhash != null) {
		lyricHashDataInfo.sqhash = sqhash;
	}
	final int? failprocess = jsonConvert.convert<int>(json['failprocess']);
	if (failprocess != null) {
		lyricHashDataInfo.failprocess = failprocess;
	}
	final int? x320privilege = jsonConvert.convert<int>(json['320privilege']);
	if (x320privilege != null) {
		lyricHashDataInfo.x320privilege = x320privilege;
	}
	final int? albumAudioId = jsonConvert.convert<int>(json['album_audio_id']);
	if (albumAudioId != null) {
		lyricHashDataInfo.albumAudioId = albumAudioId;
	}
	final String? albumId = jsonConvert.convert<String>(json['album_id']);
	if (albumId != null) {
		lyricHashDataInfo.albumId = albumId;
	}
	final String? extname = jsonConvert.convert<String>(json['extname']);
	if (extname != null) {
		lyricHashDataInfo.extname = extname;
	}
	final int? filesize = jsonConvert.convert<int>(json['filesize']);
	if (filesize != null) {
		lyricHashDataInfo.filesize = filesize;
	}
	final int? m4afilesize = jsonConvert.convert<int>(json['m4afilesize']);
	if (m4afilesize != null) {
		lyricHashDataInfo.m4afilesize = m4afilesize;
	}
	final String? mvhash = jsonConvert.convert<String>(json['mvhash']);
	if (mvhash != null) {
		lyricHashDataInfo.mvhash = mvhash;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		lyricHashDataInfo.duration = duration;
	}
	final String? singername = jsonConvert.convert<String>(json['singername']);
	if (singername != null) {
		lyricHashDataInfo.singername = singername;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		lyricHashDataInfo.type = type;
	}
	return lyricHashDataInfo;
}

Map<String, dynamic> $LyricHashDataInfoToJson(LyricHashDataInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['320hash'] = entity.x320hash;
	data['hash'] = entity.hash;
	data['sqfilesize'] = entity.sqfilesize;
	data['sqprivilege'] = entity.sqprivilege;
	data['old_cpy'] = entity.oldCpy;
	data['bitrate'] = entity.bitrate;
	data['ownercount'] = entity.ownercount;
	data['320filesize'] = entity.x320filesize;
	data['paytype'] = entity.paytype;
	data['filename'] = entity.filename;
	data['trans_param'] = entity.transParam?.toJson();
	data['privilege'] = entity.privilege;
	data['lyric'] = entity.lyric;
	data['sqhash'] = entity.sqhash;
	data['failprocess'] = entity.failprocess;
	data['320privilege'] = entity.x320privilege;
	data['album_audio_id'] = entity.albumAudioId;
	data['album_id'] = entity.albumId;
	data['extname'] = entity.extname;
	data['filesize'] = entity.filesize;
	data['m4afilesize'] = entity.m4afilesize;
	data['mvhash'] = entity.mvhash;
	data['duration'] = entity.duration;
	data['singername'] = entity.singername;
	data['type'] = entity.type;
	return data;
}

LyricHashDataInfoTransParam $LyricHashDataInfoTransParamFromJson(Map<String, dynamic> json) {
	final LyricHashDataInfoTransParam lyricHashDataInfoTransParam = LyricHashDataInfoTransParam();
	final int? payBlockTpl = jsonConvert.convert<int>(json['pay_block_tpl']);
	if (payBlockTpl != null) {
		lyricHashDataInfoTransParam.payBlockTpl = payBlockTpl;
	}
	final LyricHashDataInfoTransParamClassmap? classmap = jsonConvert.convert<LyricHashDataInfoTransParamClassmap>(json['classmap']);
	if (classmap != null) {
		lyricHashDataInfoTransParam.classmap = classmap;
	}
	final int? cpyLevel = jsonConvert.convert<int>(json['cpy_level']);
	if (cpyLevel != null) {
		lyricHashDataInfoTransParam.cpyLevel = cpyLevel;
	}
	final int? cpyGrade = jsonConvert.convert<int>(json['cpy_grade']);
	if (cpyGrade != null) {
		lyricHashDataInfoTransParam.cpyGrade = cpyGrade;
	}
	final int? cid = jsonConvert.convert<int>(json['cid']);
	if (cid != null) {
		lyricHashDataInfoTransParam.cid = cid;
	}
	final String? appidBlock = jsonConvert.convert<String>(json['appid_block']);
	if (appidBlock != null) {
		lyricHashDataInfoTransParam.appidBlock = appidBlock;
	}
	final int? cpyAttr0 = jsonConvert.convert<int>(json['cpy_attr0']);
	if (cpyAttr0 != null) {
		lyricHashDataInfoTransParam.cpyAttr0 = cpyAttr0;
	}
	final String? hashMultitrack = jsonConvert.convert<String>(json['hash_multitrack']);
	if (hashMultitrack != null) {
		lyricHashDataInfoTransParam.hashMultitrack = hashMultitrack;
	}
	final LyricHashDataInfoTransParamHashOffset? hashOffset = jsonConvert.convert<LyricHashDataInfoTransParamHashOffset>(json['hash_offset']);
	if (hashOffset != null) {
		lyricHashDataInfoTransParam.hashOffset = hashOffset;
	}
	final int? musicpackAdvance = jsonConvert.convert<int>(json['musicpack_advance']);
	if (musicpackAdvance != null) {
		lyricHashDataInfoTransParam.musicpackAdvance = musicpackAdvance;
	}
	final int? display = jsonConvert.convert<int>(json['display']);
	if (display != null) {
		lyricHashDataInfoTransParam.display = display;
	}
	final int? displayRate = jsonConvert.convert<int>(json['display_rate']);
	if (displayRate != null) {
		lyricHashDataInfoTransParam.displayRate = displayRate;
	}
	return lyricHashDataInfoTransParam;
}

Map<String, dynamic> $LyricHashDataInfoTransParamToJson(LyricHashDataInfoTransParam entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['pay_block_tpl'] = entity.payBlockTpl;
	data['classmap'] = entity.classmap?.toJson();
	data['cpy_level'] = entity.cpyLevel;
	data['cpy_grade'] = entity.cpyGrade;
	data['cid'] = entity.cid;
	data['appid_block'] = entity.appidBlock;
	data['cpy_attr0'] = entity.cpyAttr0;
	data['hash_multitrack'] = entity.hashMultitrack;
	data['hash_offset'] = entity.hashOffset?.toJson();
	data['musicpack_advance'] = entity.musicpackAdvance;
	data['display'] = entity.display;
	data['display_rate'] = entity.displayRate;
	return data;
}

LyricHashDataInfoTransParamClassmap $LyricHashDataInfoTransParamClassmapFromJson(Map<String, dynamic> json) {
	final LyricHashDataInfoTransParamClassmap lyricHashDataInfoTransParamClassmap = LyricHashDataInfoTransParamClassmap();
	final int? attr0 = jsonConvert.convert<int>(json['attr0']);
	if (attr0 != null) {
		lyricHashDataInfoTransParamClassmap.attr0 = attr0;
	}
	return lyricHashDataInfoTransParamClassmap;
}

Map<String, dynamic> $LyricHashDataInfoTransParamClassmapToJson(LyricHashDataInfoTransParamClassmap entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['attr0'] = entity.attr0;
	return data;
}

LyricHashDataInfoTransParamHashOffset $LyricHashDataInfoTransParamHashOffsetFromJson(Map<String, dynamic> json) {
	final LyricHashDataInfoTransParamHashOffset lyricHashDataInfoTransParamHashOffset = LyricHashDataInfoTransParamHashOffset();
	final String? clipHash = jsonConvert.convert<String>(json['clip_hash']);
	if (clipHash != null) {
		lyricHashDataInfoTransParamHashOffset.clipHash = clipHash;
	}
	final int? startByte = jsonConvert.convert<int>(json['start_byte']);
	if (startByte != null) {
		lyricHashDataInfoTransParamHashOffset.startByte = startByte;
	}
	final int? endMs = jsonConvert.convert<int>(json['end_ms']);
	if (endMs != null) {
		lyricHashDataInfoTransParamHashOffset.endMs = endMs;
	}
	final int? endByte = jsonConvert.convert<int>(json['end_byte']);
	if (endByte != null) {
		lyricHashDataInfoTransParamHashOffset.endByte = endByte;
	}
	final int? fileType = jsonConvert.convert<int>(json['file_type']);
	if (fileType != null) {
		lyricHashDataInfoTransParamHashOffset.fileType = fileType;
	}
	final int? startMs = jsonConvert.convert<int>(json['start_ms']);
	if (startMs != null) {
		lyricHashDataInfoTransParamHashOffset.startMs = startMs;
	}
	final String? offsetHash = jsonConvert.convert<String>(json['offset_hash']);
	if (offsetHash != null) {
		lyricHashDataInfoTransParamHashOffset.offsetHash = offsetHash;
	}
	return lyricHashDataInfoTransParamHashOffset;
}

Map<String, dynamic> $LyricHashDataInfoTransParamHashOffsetToJson(LyricHashDataInfoTransParamHashOffset entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['clip_hash'] = entity.clipHash;
	data['start_byte'] = entity.startByte;
	data['end_ms'] = entity.endMs;
	data['end_byte'] = entity.endByte;
	data['file_type'] = entity.fileType;
	data['start_ms'] = entity.startMs;
	data['offset_hash'] = entity.offsetHash;
	return data;
}