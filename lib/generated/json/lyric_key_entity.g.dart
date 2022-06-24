import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/lyric_key_entity.dart';

LyricKeyEntity $LyricKeyEntityFromJson(Map<String, dynamic> json) {
	final LyricKeyEntity lyricKeyEntity = LyricKeyEntity();
	final List<dynamic>? ugccandidates = jsonConvert.convertListNotNull<dynamic>(json['ugccandidates']);
	if (ugccandidates != null) {
		lyricKeyEntity.ugccandidates = ugccandidates;
	}
	final String? info = jsonConvert.convert<String>(json['info']);
	if (info != null) {
		lyricKeyEntity.info = info;
	}
	final int? errcode = jsonConvert.convert<int>(json['errcode']);
	if (errcode != null) {
		lyricKeyEntity.errcode = errcode;
	}
	final String? keyword = jsonConvert.convert<String>(json['keyword']);
	if (keyword != null) {
		lyricKeyEntity.keyword = keyword;
	}
	final int? expire = jsonConvert.convert<int>(json['expire']);
	if (expire != null) {
		lyricKeyEntity.expire = expire;
	}
	final String? companys = jsonConvert.convert<String>(json['companys']);
	if (companys != null) {
		lyricKeyEntity.companys = companys;
	}
	final int? ugc = jsonConvert.convert<int>(json['ugc']);
	if (ugc != null) {
		lyricKeyEntity.ugc = ugc;
	}
	final int? hasCompleteRight = jsonConvert.convert<int>(json['has_complete_right']);
	if (hasCompleteRight != null) {
		lyricKeyEntity.hasCompleteRight = hasCompleteRight;
	}
	final int? ugccount = jsonConvert.convert<int>(json['ugccount']);
	if (ugccount != null) {
		lyricKeyEntity.ugccount = ugccount;
	}
	final String? errmsg = jsonConvert.convert<String>(json['errmsg']);
	if (errmsg != null) {
		lyricKeyEntity.errmsg = errmsg;
	}
	final String? proposal = jsonConvert.convert<String>(json['proposal']);
	if (proposal != null) {
		lyricKeyEntity.proposal = proposal;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		lyricKeyEntity.status = status;
	}
	final List<LyricKeyCandidates>? candidates = jsonConvert.convertListNotNull<LyricKeyCandidates>(json['candidates']);
	if (candidates != null) {
		lyricKeyEntity.candidates = candidates;
	}
	final List<dynamic>? artists = jsonConvert.convertListNotNull<dynamic>(json['artists']);
	if (artists != null) {
		lyricKeyEntity.artists = artists;
	}
	return lyricKeyEntity;
}

Map<String, dynamic> $LyricKeyEntityToJson(LyricKeyEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['ugccandidates'] =  entity.ugccandidates;
	data['info'] = entity.info;
	data['errcode'] = entity.errcode;
	data['keyword'] = entity.keyword;
	data['expire'] = entity.expire;
	data['companys'] = entity.companys;
	data['ugc'] = entity.ugc;
	data['has_complete_right'] = entity.hasCompleteRight;
	data['ugccount'] = entity.ugccount;
	data['errmsg'] = entity.errmsg;
	data['proposal'] = entity.proposal;
	data['status'] = entity.status;
	data['candidates'] =  entity.candidates?.map((v) => v.toJson()).toList();
	data['artists'] =  entity.artists;
	return data;
}

LyricKeyCandidates $LyricKeyCandidatesFromJson(Map<String, dynamic> json) {
	final LyricKeyCandidates lyricKeyCandidates = LyricKeyCandidates();
	final String? soundname = jsonConvert.convert<String>(json['soundname']);
	if (soundname != null) {
		lyricKeyCandidates.soundname = soundname;
	}
	final int? krctype = jsonConvert.convert<int>(json['krctype']);
	if (krctype != null) {
		lyricKeyCandidates.krctype = krctype;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		lyricKeyCandidates.id = id;
	}
	final String? originame = jsonConvert.convert<String>(json['originame']);
	if (originame != null) {
		lyricKeyCandidates.originame = originame;
	}
	final String? accesskey = jsonConvert.convert<String>(json['accesskey']);
	if (accesskey != null) {
		lyricKeyCandidates.accesskey = accesskey;
	}
	final List<List>? parinfo = jsonConvert.convertListNotNull<List>(json['parinfo']);
	if (parinfo != null) {
		lyricKeyCandidates.parinfo = parinfo;
	}
	final String? origiuid = jsonConvert.convert<String>(json['origiuid']);
	if (origiuid != null) {
		lyricKeyCandidates.origiuid = origiuid;
	}
	final String? transuid = jsonConvert.convert<String>(json['transuid']);
	if (transuid != null) {
		lyricKeyCandidates.transuid = transuid;
	}
	final int? score = jsonConvert.convert<int>(json['score']);
	if (score != null) {
		lyricKeyCandidates.score = score;
	}
	final int? hitlayer = jsonConvert.convert<int>(json['hitlayer']);
	if (hitlayer != null) {
		lyricKeyCandidates.hitlayer = hitlayer;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		lyricKeyCandidates.duration = duration;
	}
	final int? adjust = jsonConvert.convert<int>(json['adjust']);
	if (adjust != null) {
		lyricKeyCandidates.adjust = adjust;
	}
	final bool? canScore = jsonConvert.convert<bool>(json['can_score']);
	if (canScore != null) {
		lyricKeyCandidates.canScore = canScore;
	}
	final String? transname = jsonConvert.convert<String>(json['transname']);
	if (transname != null) {
		lyricKeyCandidates.transname = transname;
	}
	final String? uid = jsonConvert.convert<String>(json['uid']);
	if (uid != null) {
		lyricKeyCandidates.uid = uid;
	}
	final List<dynamic>? lyricCommentMark = jsonConvert.convertListNotNull<dynamic>(json['lyric_comment_mark']);
	if (lyricCommentMark != null) {
		lyricKeyCandidates.lyricCommentMark = lyricCommentMark;
	}
	final String? song = jsonConvert.convert<String>(json['song']);
	if (song != null) {
		lyricKeyCandidates.song = song;
	}
	final String? productFrom = jsonConvert.convert<String>(json['product_from']);
	if (productFrom != null) {
		lyricKeyCandidates.productFrom = productFrom;
	}
	final String? sounduid = jsonConvert.convert<String>(json['sounduid']);
	if (sounduid != null) {
		lyricKeyCandidates.sounduid = sounduid;
	}
	final List<LyricKeyCandidatesParinfoExt>? parinfoExt = jsonConvert.convertListNotNull<LyricKeyCandidatesParinfoExt>(json['parinfoExt']);
	if (parinfoExt != null) {
		lyricKeyCandidates.parinfoExt = parinfoExt;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		lyricKeyCandidates.nickname = nickname;
	}
	final int? contenttype = jsonConvert.convert<int>(json['contenttype']);
	if (contenttype != null) {
		lyricKeyCandidates.contenttype = contenttype;
	}
	final String? singer = jsonConvert.convert<String>(json['singer']);
	if (singer != null) {
		lyricKeyCandidates.singer = singer;
	}
	final String? language = jsonConvert.convert<String>(json['language']);
	if (language != null) {
		lyricKeyCandidates.language = language;
	}
	return lyricKeyCandidates;
}

Map<String, dynamic> $LyricKeyCandidatesToJson(LyricKeyCandidates entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['soundname'] = entity.soundname;
	data['krctype'] = entity.krctype;
	data['id'] = entity.id;
	data['originame'] = entity.originame;
	data['accesskey'] = entity.accesskey;
	data['parinfo'] =  entity.parinfo;
	data['origiuid'] = entity.origiuid;
	data['transuid'] = entity.transuid;
	data['score'] = entity.score;
	data['hitlayer'] = entity.hitlayer;
	data['duration'] = entity.duration;
	data['adjust'] = entity.adjust;
	data['can_score'] = entity.canScore;
	data['transname'] = entity.transname;
	data['uid'] = entity.uid;
	data['lyric_comment_mark'] =  entity.lyricCommentMark;
	data['song'] = entity.song;
	data['product_from'] = entity.productFrom;
	data['sounduid'] = entity.sounduid;
	data['parinfoExt'] =  entity.parinfoExt?.map((v) => v.toJson()).toList();
	data['nickname'] = entity.nickname;
	data['contenttype'] = entity.contenttype;
	data['singer'] = entity.singer;
	data['language'] = entity.language;
	return data;
}

LyricKeyCandidatesParinfoExt $LyricKeyCandidatesParinfoExtFromJson(Map<String, dynamic> json) {
	final LyricKeyCandidatesParinfoExt lyricKeyCandidatesParinfoExt = LyricKeyCandidatesParinfoExt();
	final String? entry = jsonConvert.convert<String>(json['entry']);
	if (entry != null) {
		lyricKeyCandidatesParinfoExt.entry = entry;
	}
	return lyricKeyCandidatesParinfoExt;
}

Map<String, dynamic> $LyricKeyCandidatesParinfoExtToJson(LyricKeyCandidatesParinfoExt entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['entry'] = entity.entry;
	return data;
}