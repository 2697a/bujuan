import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/song_details_entity.dart';

SongDetailsEntity $SongDetailsEntityFromJson(Map<String, dynamic> json) {
	final SongDetailsEntity songDetailsEntity = SongDetailsEntity();
	final List<SongDetailsSongs>? songs = jsonConvert.convertListNotNull<SongDetailsSongs>(json['songs']);
	if (songs != null) {
		songDetailsEntity.songs = songs;
	}
	return songDetailsEntity;
}

Map<String, dynamic> $SongDetailsEntityToJson(SongDetailsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['songs'] =  entity.songs?.map((v) => v.toJson()).toList();
	return data;
}

SongDetailsSongs $SongDetailsSongsFromJson(Map<String, dynamic> json) {
	final SongDetailsSongs songDetailsSongs = SongDetailsSongs();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		songDetailsSongs.name = name;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		songDetailsSongs.id = id;
	}
	final int? pst = jsonConvert.convert<int>(json['pst']);
	if (pst != null) {
		songDetailsSongs.pst = pst;
	}
	final int? t = jsonConvert.convert<int>(json['t']);
	if (t != null) {
		songDetailsSongs.t = t;
	}
	final List<SongDetailsSongsAr>? ar = jsonConvert.convertListNotNull<SongDetailsSongsAr>(json['ar']);
	if (ar != null) {
		songDetailsSongs.ar = ar;
	}
	final List<dynamic>? alia = jsonConvert.convertListNotNull<dynamic>(json['alia']);
	if (alia != null) {
		songDetailsSongs.alia = alia;
	}
	final double? pop = jsonConvert.convert<double>(json['pop']);
	if (pop != null) {
		songDetailsSongs.pop = pop;
	}
	final int? st = jsonConvert.convert<int>(json['st']);
	if (st != null) {
		songDetailsSongs.st = st;
	}
	final String? rt = jsonConvert.convert<String>(json['rt']);
	if (rt != null) {
		songDetailsSongs.rt = rt;
	}
	final int? fee = jsonConvert.convert<int>(json['fee']);
	if (fee != null) {
		songDetailsSongs.fee = fee;
	}
	final int? v = jsonConvert.convert<int>(json['v']);
	if (v != null) {
		songDetailsSongs.v = v;
	}
	final dynamic? crbt = jsonConvert.convert<dynamic>(json['crbt']);
	if (crbt != null) {
		songDetailsSongs.crbt = crbt;
	}
	final String? cf = jsonConvert.convert<String>(json['cf']);
	if (cf != null) {
		songDetailsSongs.cf = cf;
	}
	final SongDetailsSongsAl? al = jsonConvert.convert<SongDetailsSongsAl>(json['al']);
	if (al != null) {
		songDetailsSongs.al = al;
	}
	final int? dt = jsonConvert.convert<int>(json['dt']);
	if (dt != null) {
		songDetailsSongs.dt = dt;
	}
	final SongDetailsSongsH? h = jsonConvert.convert<SongDetailsSongsH>(json['h']);
	if (h != null) {
		songDetailsSongs.h = h;
	}
	final SongDetailsSongsM? m = jsonConvert.convert<SongDetailsSongsM>(json['m']);
	if (m != null) {
		songDetailsSongs.m = m;
	}
	final SongDetailsSongsL? l = jsonConvert.convert<SongDetailsSongsL>(json['l']);
	if (l != null) {
		songDetailsSongs.l = l;
	}
	final SongDetailsSongsSq? sq = jsonConvert.convert<SongDetailsSongsSq>(json['sq']);
	if (sq != null) {
		songDetailsSongs.sq = sq;
	}
	final SongDetailsSongsHr? hr = jsonConvert.convert<SongDetailsSongsHr>(json['hr']);
	if (hr != null) {
		songDetailsSongs.hr = hr;
	}
	final dynamic? a = jsonConvert.convert<dynamic>(json['a']);
	if (a != null) {
		songDetailsSongs.a = a;
	}
	final String? cd = jsonConvert.convert<String>(json['cd']);
	if (cd != null) {
		songDetailsSongs.cd = cd;
	}
	final int? no = jsonConvert.convert<int>(json['no']);
	if (no != null) {
		songDetailsSongs.no = no;
	}
	final dynamic? rtUrl = jsonConvert.convert<dynamic>(json['rtUrl']);
	if (rtUrl != null) {
		songDetailsSongs.rtUrl = rtUrl;
	}
	final int? ftype = jsonConvert.convert<int>(json['ftype']);
	if (ftype != null) {
		songDetailsSongs.ftype = ftype;
	}
	final List<dynamic>? rtUrls = jsonConvert.convertListNotNull<dynamic>(json['rtUrls']);
	if (rtUrls != null) {
		songDetailsSongs.rtUrls = rtUrls;
	}
	final int? djId = jsonConvert.convert<int>(json['djId']);
	if (djId != null) {
		songDetailsSongs.djId = djId;
	}
	final int? copyright = jsonConvert.convert<int>(json['copyright']);
	if (copyright != null) {
		songDetailsSongs.copyright = copyright;
	}
	final int? sId = jsonConvert.convert<int>(json['s_id']);
	if (sId != null) {
		songDetailsSongs.sId = sId;
	}
	final int? mark = jsonConvert.convert<int>(json['mark']);
	if (mark != null) {
		songDetailsSongs.mark = mark;
	}
	final int? originCoverType = jsonConvert.convert<int>(json['originCoverType']);
	if (originCoverType != null) {
		songDetailsSongs.originCoverType = originCoverType;
	}
	final SongDetailsSongsOriginSongSimpleData? originSongSimpleData = jsonConvert.convert<SongDetailsSongsOriginSongSimpleData>(json['originSongSimpleData']);
	if (originSongSimpleData != null) {
		songDetailsSongs.originSongSimpleData = originSongSimpleData;
	}
	final dynamic? tagPicList = jsonConvert.convert<dynamic>(json['tagPicList']);
	if (tagPicList != null) {
		songDetailsSongs.tagPicList = tagPicList;
	}
	final bool? resourceState = jsonConvert.convert<bool>(json['resourceState']);
	if (resourceState != null) {
		songDetailsSongs.resourceState = resourceState;
	}
	final int? version = jsonConvert.convert<int>(json['version']);
	if (version != null) {
		songDetailsSongs.version = version;
	}
	final dynamic? songJumpInfo = jsonConvert.convert<dynamic>(json['songJumpInfo']);
	if (songJumpInfo != null) {
		songDetailsSongs.songJumpInfo = songJumpInfo;
	}
	final dynamic? entertainmentTags = jsonConvert.convert<dynamic>(json['entertainmentTags']);
	if (entertainmentTags != null) {
		songDetailsSongs.entertainmentTags = entertainmentTags;
	}
	final int? single = jsonConvert.convert<int>(json['single']);
	if (single != null) {
		songDetailsSongs.single = single;
	}
	final SongDetailsSongsNoCopyrightRcmd? noCopyrightRcmd = jsonConvert.convert<SongDetailsSongsNoCopyrightRcmd>(json['noCopyrightRcmd']);
	if (noCopyrightRcmd != null) {
		songDetailsSongs.noCopyrightRcmd = noCopyrightRcmd;
	}
	final int? rtype = jsonConvert.convert<int>(json['rtype']);
	if (rtype != null) {
		songDetailsSongs.rtype = rtype;
	}
	final dynamic? rurl = jsonConvert.convert<dynamic>(json['rurl']);
	if (rurl != null) {
		songDetailsSongs.rurl = rurl;
	}
	final int? mst = jsonConvert.convert<int>(json['mst']);
	if (mst != null) {
		songDetailsSongs.mst = mst;
	}
	final int? cp = jsonConvert.convert<int>(json['cp']);
	if (cp != null) {
		songDetailsSongs.cp = cp;
	}
	final int? mv = jsonConvert.convert<int>(json['mv']);
	if (mv != null) {
		songDetailsSongs.mv = mv;
	}
	final int? publishTime = jsonConvert.convert<int>(json['publishTime']);
	if (publishTime != null) {
		songDetailsSongs.publishTime = publishTime;
	}
	final List<String>? tns = jsonConvert.convertListNotNull<String>(json['tns']);
	if (tns != null) {
		songDetailsSongs.tns = tns;
	}
	return songDetailsSongs;
}

Map<String, dynamic> $SongDetailsSongsToJson(SongDetailsSongs entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['pst'] = entity.pst;
	data['t'] = entity.t;
	data['ar'] =  entity.ar?.map((v) => v.toJson()).toList();
	data['alia'] =  entity.alia;
	data['pop'] = entity.pop;
	data['st'] = entity.st;
	data['rt'] = entity.rt;
	data['fee'] = entity.fee;
	data['v'] = entity.v;
	data['crbt'] = entity.crbt;
	data['cf'] = entity.cf;
	data['al'] = entity.al?.toJson();
	data['dt'] = entity.dt;
	data['h'] = entity.h?.toJson();
	data['m'] = entity.m?.toJson();
	data['l'] = entity.l?.toJson();
	data['sq'] = entity.sq?.toJson();
	data['hr'] = entity.hr?.toJson();
	data['a'] = entity.a;
	data['cd'] = entity.cd;
	data['no'] = entity.no;
	data['rtUrl'] = entity.rtUrl;
	data['ftype'] = entity.ftype;
	data['rtUrls'] =  entity.rtUrls;
	data['djId'] = entity.djId;
	data['copyright'] = entity.copyright;
	data['s_id'] = entity.sId;
	data['mark'] = entity.mark;
	data['originCoverType'] = entity.originCoverType;
	data['originSongSimpleData'] = entity.originSongSimpleData?.toJson();
	data['tagPicList'] = entity.tagPicList;
	data['resourceState'] = entity.resourceState;
	data['version'] = entity.version;
	data['songJumpInfo'] = entity.songJumpInfo;
	data['entertainmentTags'] = entity.entertainmentTags;
	data['single'] = entity.single;
	data['noCopyrightRcmd'] = entity.noCopyrightRcmd?.toJson();
	data['rtype'] = entity.rtype;
	data['rurl'] = entity.rurl;
	data['mst'] = entity.mst;
	data['cp'] = entity.cp;
	data['mv'] = entity.mv;
	data['publishTime'] = entity.publishTime;
	data['tns'] =  entity.tns;
	return data;
}

SongDetailsSongsAr $SongDetailsSongsArFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsAr songDetailsSongsAr = SongDetailsSongsAr();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		songDetailsSongsAr.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		songDetailsSongsAr.name = name;
	}
	final List<dynamic>? tns = jsonConvert.convertListNotNull<dynamic>(json['tns']);
	if (tns != null) {
		songDetailsSongsAr.tns = tns;
	}
	final List<dynamic>? alias = jsonConvert.convertListNotNull<dynamic>(json['alias']);
	if (alias != null) {
		songDetailsSongsAr.alias = alias;
	}
	return songDetailsSongsAr;
}

Map<String, dynamic> $SongDetailsSongsArToJson(SongDetailsSongsAr entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['tns'] =  entity.tns;
	data['alias'] =  entity.alias;
	return data;
}

SongDetailsSongsAl $SongDetailsSongsAlFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsAl songDetailsSongsAl = SongDetailsSongsAl();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		songDetailsSongsAl.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		songDetailsSongsAl.name = name;
	}
	final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
	if (picUrl != null) {
		songDetailsSongsAl.picUrl = picUrl;
	}
	final List<dynamic>? tns = jsonConvert.convertListNotNull<dynamic>(json['tns']);
	if (tns != null) {
		songDetailsSongsAl.tns = tns;
	}
	final String? picStr = jsonConvert.convert<String>(json['pic_str']);
	if (picStr != null) {
		songDetailsSongsAl.picStr = picStr;
	}
	final int? pic = jsonConvert.convert<int>(json['pic']);
	if (pic != null) {
		songDetailsSongsAl.pic = pic;
	}
	return songDetailsSongsAl;
}

Map<String, dynamic> $SongDetailsSongsAlToJson(SongDetailsSongsAl entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['picUrl'] = entity.picUrl;
	data['tns'] =  entity.tns;
	data['pic_str'] = entity.picStr;
	data['pic'] = entity.pic;
	return data;
}

SongDetailsSongsH $SongDetailsSongsHFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsH songDetailsSongsH = SongDetailsSongsH();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		songDetailsSongsH.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		songDetailsSongsH.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		songDetailsSongsH.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		songDetailsSongsH.vd = vd;
	}
	final int? sr = jsonConvert.convert<int>(json['sr']);
	if (sr != null) {
		songDetailsSongsH.sr = sr;
	}
	return songDetailsSongsH;
}

Map<String, dynamic> $SongDetailsSongsHToJson(SongDetailsSongsH entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	data['sr'] = entity.sr;
	return data;
}

SongDetailsSongsM $SongDetailsSongsMFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsM songDetailsSongsM = SongDetailsSongsM();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		songDetailsSongsM.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		songDetailsSongsM.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		songDetailsSongsM.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		songDetailsSongsM.vd = vd;
	}
	final int? sr = jsonConvert.convert<int>(json['sr']);
	if (sr != null) {
		songDetailsSongsM.sr = sr;
	}
	return songDetailsSongsM;
}

Map<String, dynamic> $SongDetailsSongsMToJson(SongDetailsSongsM entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	data['sr'] = entity.sr;
	return data;
}

SongDetailsSongsL $SongDetailsSongsLFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsL songDetailsSongsL = SongDetailsSongsL();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		songDetailsSongsL.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		songDetailsSongsL.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		songDetailsSongsL.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		songDetailsSongsL.vd = vd;
	}
	final int? sr = jsonConvert.convert<int>(json['sr']);
	if (sr != null) {
		songDetailsSongsL.sr = sr;
	}
	return songDetailsSongsL;
}

Map<String, dynamic> $SongDetailsSongsLToJson(SongDetailsSongsL entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	data['sr'] = entity.sr;
	return data;
}

SongDetailsSongsSq $SongDetailsSongsSqFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsSq songDetailsSongsSq = SongDetailsSongsSq();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		songDetailsSongsSq.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		songDetailsSongsSq.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		songDetailsSongsSq.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		songDetailsSongsSq.vd = vd;
	}
	final int? sr = jsonConvert.convert<int>(json['sr']);
	if (sr != null) {
		songDetailsSongsSq.sr = sr;
	}
	return songDetailsSongsSq;
}

Map<String, dynamic> $SongDetailsSongsSqToJson(SongDetailsSongsSq entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	data['sr'] = entity.sr;
	return data;
}

SongDetailsSongsHr $SongDetailsSongsHrFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsHr songDetailsSongsHr = SongDetailsSongsHr();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		songDetailsSongsHr.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		songDetailsSongsHr.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		songDetailsSongsHr.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		songDetailsSongsHr.vd = vd;
	}
	final int? sr = jsonConvert.convert<int>(json['sr']);
	if (sr != null) {
		songDetailsSongsHr.sr = sr;
	}
	return songDetailsSongsHr;
}

Map<String, dynamic> $SongDetailsSongsHrToJson(SongDetailsSongsHr entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	data['sr'] = entity.sr;
	return data;
}

SongDetailsSongsOriginSongSimpleData $SongDetailsSongsOriginSongSimpleDataFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsOriginSongSimpleData songDetailsSongsOriginSongSimpleData = SongDetailsSongsOriginSongSimpleData();
	final int? songId = jsonConvert.convert<int>(json['songId']);
	if (songId != null) {
		songDetailsSongsOriginSongSimpleData.songId = songId;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		songDetailsSongsOriginSongSimpleData.name = name;
	}
	final List<SongDetailsSongsOriginSongSimpleDataArtists>? artists = jsonConvert.convertListNotNull<SongDetailsSongsOriginSongSimpleDataArtists>(json['artists']);
	if (artists != null) {
		songDetailsSongsOriginSongSimpleData.artists = artists;
	}
	final SongDetailsSongsOriginSongSimpleDataAlbumMeta? albumMeta = jsonConvert.convert<SongDetailsSongsOriginSongSimpleDataAlbumMeta>(json['albumMeta']);
	if (albumMeta != null) {
		songDetailsSongsOriginSongSimpleData.albumMeta = albumMeta;
	}
	return songDetailsSongsOriginSongSimpleData;
}

Map<String, dynamic> $SongDetailsSongsOriginSongSimpleDataToJson(SongDetailsSongsOriginSongSimpleData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['songId'] = entity.songId;
	data['name'] = entity.name;
	data['artists'] =  entity.artists?.map((v) => v.toJson()).toList();
	data['albumMeta'] = entity.albumMeta?.toJson();
	return data;
}

SongDetailsSongsOriginSongSimpleDataArtists $SongDetailsSongsOriginSongSimpleDataArtistsFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsOriginSongSimpleDataArtists songDetailsSongsOriginSongSimpleDataArtists = SongDetailsSongsOriginSongSimpleDataArtists();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		songDetailsSongsOriginSongSimpleDataArtists.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		songDetailsSongsOriginSongSimpleDataArtists.name = name;
	}
	return songDetailsSongsOriginSongSimpleDataArtists;
}

Map<String, dynamic> $SongDetailsSongsOriginSongSimpleDataArtistsToJson(SongDetailsSongsOriginSongSimpleDataArtists entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}

SongDetailsSongsOriginSongSimpleDataAlbumMeta $SongDetailsSongsOriginSongSimpleDataAlbumMetaFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsOriginSongSimpleDataAlbumMeta songDetailsSongsOriginSongSimpleDataAlbumMeta = SongDetailsSongsOriginSongSimpleDataAlbumMeta();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		songDetailsSongsOriginSongSimpleDataAlbumMeta.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		songDetailsSongsOriginSongSimpleDataAlbumMeta.name = name;
	}
	return songDetailsSongsOriginSongSimpleDataAlbumMeta;
}

Map<String, dynamic> $SongDetailsSongsOriginSongSimpleDataAlbumMetaToJson(SongDetailsSongsOriginSongSimpleDataAlbumMeta entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}

SongDetailsSongsNoCopyrightRcmd $SongDetailsSongsNoCopyrightRcmdFromJson(Map<String, dynamic> json) {
	final SongDetailsSongsNoCopyrightRcmd songDetailsSongsNoCopyrightRcmd = SongDetailsSongsNoCopyrightRcmd();
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		songDetailsSongsNoCopyrightRcmd.type = type;
	}
	final String? typeDesc = jsonConvert.convert<String>(json['typeDesc']);
	if (typeDesc != null) {
		songDetailsSongsNoCopyrightRcmd.typeDesc = typeDesc;
	}
	final dynamic? songId = jsonConvert.convert<dynamic>(json['songId']);
	if (songId != null) {
		songDetailsSongsNoCopyrightRcmd.songId = songId;
	}
	return songDetailsSongsNoCopyrightRcmd;
}

Map<String, dynamic> $SongDetailsSongsNoCopyrightRcmdToJson(SongDetailsSongsNoCopyrightRcmd entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['type'] = entity.type;
	data['typeDesc'] = entity.typeDesc;
	data['songId'] = entity.songId;
	return data;
}