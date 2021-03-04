import 'package:bujuan/entity/sheet_details_entity.dart';

class TopEntity {
	List<TopSongPrivilege> privileges;
	num code;
	TopSongPlaylist playlist;

	TopEntity({this.privileges, this.code, this.playlist});

	TopEntity.fromJson(Map<String, dynamic> json) {
		if (json['privileges'] != null) {
			privileges = new List<TopSongPrivilege>();(json['privileges'] as List).forEach((v) { privileges.add(new TopSongPrivilege.fromJson(v)); });
		}
		code = json['code'];
		playlist = json['playlist'] != null ? new TopSongPlaylist.fromJson(json['playlist']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.privileges != null) {
      data['privileges'] =  this.privileges.map((v) => v.toJson()).toList();
    }
		data['code'] = this.code;
		if (this.playlist != null) {
      data['playlist'] = this.playlist.toJson();
    }
		return data;
	}
}

class TopSongPrivilege {
	num st;
	num flag;
	num subp;
	num fl;
	num fee;
	num dl;
	num cp;
	bool preSell;
	bool cs;
	bool toast;
	num maxbr;
	num id;
	num pl;
	num sp;
	num payed;

	TopSongPrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.preSell, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	TopSongPrivilege.fromJson(Map<String, dynamic> json) {
		st = json['st'];
		flag = json['flag'];
		subp = json['subp'];
		fl = json['fl'];
		fee = json['fee'];
		dl = json['dl'];
		cp = json['cp'];
		preSell = json['preSell'];
		cs = json['cs'];
		toast = json['toast'];
		maxbr = json['maxbr'];
		id = json['id'];
		pl = json['pl'];
		sp = json['sp'];
		payed = json['payed'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['st'] = this.st;
		data['flag'] = this.flag;
		data['subp'] = this.subp;
		data['fl'] = this.fl;
		data['fee'] = this.fee;
		data['dl'] = this.dl;
		data['cp'] = this.cp;
		data['preSell'] = this.preSell;
		data['cs'] = this.cs;
		data['toast'] = this.toast;
		data['maxbr'] = this.maxbr;
		data['id'] = this.id;
		data['pl'] = this.pl;
		data['sp'] = this.sp;
		data['payed'] = this.payed;
		return data;
	}
}

class TopSongPlaylist {
	String description;
	num privacy;
	num trackNumberUpdateTime;
	bool subscribed;
	num shareCount;
	num adType;
	num trackCount;
	String coverimgidStr;
	num specialType;
	List<TopSongPlaylistTrackid> trackIds;
	num id;
	bool ordered;
	TopSongPlaylistCreator creator;
	String toplistType;
	List<Null> subscribers;
	dynamic backgroundCoverUrl;
	bool highQuality;
	String commentThreadId;
	num updateTime;
	num trackUpdateTime;
	num userId;
	List<SheetDetailsPlaylistTrack> tracks;
	List<Null> tags;
	num commentCount;
	num cloudTrackCount;
	String coverImgUrl;
	num playCount;
	num coverImgId;
	num createTime;
	String name;
	num backgroundCoverId;
	num subscribedCount;
	dynamic updateFrequency;
	num status;
	bool newImported;

	TopSongPlaylist({this.description, this.privacy, this.trackNumberUpdateTime, this.subscribed, this.shareCount, this.adType, this.trackCount, this.coverimgidStr, this.specialType, this.trackIds, this.id, this.ordered, this.creator, this.toplistType, this.subscribers, this.backgroundCoverUrl, this.highQuality, this.commentThreadId, this.updateTime, this.trackUpdateTime, this.userId, this.tracks, this.tags, this.commentCount, this.cloudTrackCount, this.coverImgUrl, this.playCount, this.coverImgId, this.createTime, this.name, this.backgroundCoverId, this.subscribedCount, this.updateFrequency, this.status, this.newImported});

	TopSongPlaylist.fromJson(Map<String, dynamic> json) {
		description = json['description'];
		privacy = json['privacy'];
		trackNumberUpdateTime = json['trackNumberUpdateTime'];
		subscribed = json['subscribed'];
		shareCount = json['shareCount'];
		adType = json['adType'];
		trackCount = json['trackCount'];
		coverimgidStr = json['coverImgId_str'];
		specialType = json['specialType'];
		if (json['trackIds'] != null) {
			trackIds = new List<TopSongPlaylistTrackid>();(json['trackIds'] as List).forEach((v) { trackIds.add(new TopSongPlaylistTrackid.fromJson(v)); });
		}
		id = json['id'];
		ordered = json['ordered'];
		creator = json['creator'] != null ? new TopSongPlaylistCreator.fromJson(json['creator']) : null;
		toplistType = json['ToplistType'];
		if (json['subscribers'] != null) {
			subscribers = new List<Null>();
		}
		backgroundCoverUrl = json['backgroundCoverUrl'];
		highQuality = json['highQuality'];
		commentThreadId = json['commentThreadId'];
		updateTime = json['updateTime'];
		trackUpdateTime = json['trackUpdateTime'];
		userId = json['userId'];
		if (json['tracks'] != null) {
			tracks = new List<SheetDetailsPlaylistTrack>();(json['tracks'] as List).forEach((v) { tracks.add(new SheetDetailsPlaylistTrack.fromJson(v)); });
		}
		if (json['tags'] != null) {
			tags = new List<Null>();
		}
		commentCount = json['commentCount'];
		cloudTrackCount = json['cloudTrackCount'];
		coverImgUrl = json['coverImgUrl'];
		playCount = json['playCount'];
		coverImgId = json['coverImgId'];
		createTime = json['createTime'];
		name = json['name'];
		backgroundCoverId = json['backgroundCoverId'];
		subscribedCount = json['subscribedCount'];
		updateFrequency = json['updateFrequency'];
		status = json['status'];
		newImported = json['newImported'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['description'] = this.description;
		data['privacy'] = this.privacy;
		data['trackNumberUpdateTime'] = this.trackNumberUpdateTime;
		data['subscribed'] = this.subscribed;
		data['shareCount'] = this.shareCount;
		data['adType'] = this.adType;
		data['trackCount'] = this.trackCount;
		data['coverImgId_str'] = this.coverimgidStr;
		data['specialType'] = this.specialType;
		if (this.trackIds != null) {
      data['trackIds'] =  this.trackIds.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['ordered'] = this.ordered;
		if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
		data['ToplistType'] = this.toplistType;
		if (this.subscribers != null) {
      data['subscribers'] =  [];
    }
		data['backgroundCoverUrl'] = this.backgroundCoverUrl;
		data['highQuality'] = this.highQuality;
		data['commentThreadId'] = this.commentThreadId;
		data['updateTime'] = this.updateTime;
		data['trackUpdateTime'] = this.trackUpdateTime;
		data['userId'] = this.userId;
		if (this.tracks != null) {
      data['tracks'] =  this.tracks.map((v) => v.toJson()).toList();
    }
		if (this.tags != null) {
      data['tags'] =  [];
    }
		data['commentCount'] = this.commentCount;
		data['cloudTrackCount'] = this.cloudTrackCount;
		data['coverImgUrl'] = this.coverImgUrl;
		data['playCount'] = this.playCount;
		data['coverImgId'] = this.coverImgId;
		data['createTime'] = this.createTime;
		data['name'] = this.name;
		data['backgroundCoverId'] = this.backgroundCoverId;
		data['subscribedCount'] = this.subscribedCount;
		data['updateFrequency'] = this.updateFrequency;
		data['status'] = this.status;
		data['newImported'] = this.newImported;
		return data;
	}
}

class TopSongPlaylistTrackid {
	num v;
	num lr;
	num id;
	dynamic alg;

	TopSongPlaylistTrackid({this.v, this.lr, this.id, this.alg});

	TopSongPlaylistTrackid.fromJson(Map<String, dynamic> json) {
		v = json['v'];
		lr = json['lr'];
		id = json['id'];
		alg = json['alg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['v'] = this.v;
		data['lr'] = this.lr;
		data['id'] = this.id;
		data['alg'] = this.alg;
		return data;
	}
}

class TopSongPlaylistCreator {
	num birthday;
	String detailDescription;
	String backgroundUrl;
	num gender;
	num city;
	String signature;
	String description;
	dynamic remarkName;
	num accountStatus;
	num avatarImgId;
	bool defaultAvatar;
	String backgroundImgIdStr;
	String avatarImgIdStr;
	num province;
	String nickname;
	dynamic expertTags;
	num djStatus;
	String avatarUrl;
	num authStatus;
	num vipType;
	bool followed;
	num userId;
	bool mutual;
	num authority;
	num userType;
	num backgroundImgId;
	dynamic experts;

	TopSongPlaylistCreator({this.birthday, this.detailDescription, this.backgroundUrl, this.gender, this.city, this.signature, this.description, this.remarkName, this.accountStatus, this.avatarImgId, this.defaultAvatar, this.backgroundImgIdStr, this.avatarImgIdStr, this.province, this.nickname, this.expertTags, this.djStatus, this.avatarUrl, this.authStatus, this.vipType, this.followed, this.userId, this.mutual, this.authority, this.userType, this.backgroundImgId, this.experts});

	TopSongPlaylistCreator.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		detailDescription = json['detailDescription'];
		backgroundUrl = json['backgroundUrl'];
		gender = json['gender'];
		city = json['city'];
		signature = json['signature'];
		description = json['description'];
		remarkName = json['remarkName'];
		accountStatus = json['accountStatus'];
		avatarImgId = json['avatarImgId'];
		defaultAvatar = json['defaultAvatar'];
		backgroundImgIdStr = json['backgroundImgIdStr'];
		avatarImgIdStr = json['avatarImgIdStr'];
		province = json['province'];
		nickname = json['nickname'];
		expertTags = json['expertTags'];
		djStatus = json['djStatus'];
		avatarUrl = json['avatarUrl'];
		authStatus = json['authStatus'];
		vipType = json['vipType'];
		followed = json['followed'];
		userId = json['userId'];
		mutual = json['mutual'];
		authority = json['authority'];
		userType = json['userType'];
		backgroundImgId = json['backgroundImgId'];
		experts = json['experts'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['detailDescription'] = this.detailDescription;
		data['backgroundUrl'] = this.backgroundUrl;
		data['gender'] = this.gender;
		data['city'] = this.city;
		data['signature'] = this.signature;
		data['description'] = this.description;
		data['remarkName'] = this.remarkName;
		data['accountStatus'] = this.accountStatus;
		data['avatarImgId'] = this.avatarImgId;
		data['defaultAvatar'] = this.defaultAvatar;
		data['backgroundImgIdStr'] = this.backgroundImgIdStr;
		data['avatarImgIdStr'] = this.avatarImgIdStr;
		data['province'] = this.province;
		data['nickname'] = this.nickname;
		data['expertTags'] = this.expertTags;
		data['djStatus'] = this.djStatus;
		data['avatarUrl'] = this.avatarUrl;
		data['authStatus'] = this.authStatus;
		data['vipType'] = this.vipType;
		data['followed'] = this.followed;
		data['userId'] = this.userId;
		data['mutual'] = this.mutual;
		data['authority'] = this.authority;
		data['userType'] = this.userType;
		data['backgroundImgId'] = this.backgroundImgId;
		data['experts'] = this.experts;
		return data;
	}
}

class TopSongPlaylistTrack {
	num no;
	String rt;
	num copyright;
	num fee;
	dynamic rurl;
	num mst;
	num pst;
	num pop;
	num dt;
	num rtype;
	num sId;
	List<Null> rtUrls;
	num id;
	num st;
	dynamic a;
	String cd;
	num publishTime;
	String cf;
	TopSongPlaylistTracksH h;
	num mv;
	TopSongPlaylistTracksAl al;
	TopSongPlaylistTracksL l;
	TopSongPlaylistTracksM m;
	num cp;
	List<String> alia;
	num djId;
	String crbt;
	List<TopSongPlaylistTracksAr> ar;
	dynamic rtUrl;
	num ftype;
	num t;
	num v;
	String name;
	List<String> tns;
	num mark;

	TopSongPlaylistTrack({this.no, this.rt, this.copyright, this.fee, this.rurl, this.mst, this.pst, this.pop, this.dt, this.rtype, this.sId, this.rtUrls, this.id, this.st, this.a, this.cd, this.publishTime, this.cf, this.h, this.mv, this.al, this.l, this.m, this.cp, this.alia, this.djId, this.crbt, this.ar, this.rtUrl, this.ftype, this.t, this.v, this.name, this.tns, this.mark});

	TopSongPlaylistTrack.fromJson(Map<String, dynamic> json) {
		no = json['no'];
		rt = json['rt'];
		copyright = json['copyright'];
		fee = json['fee'];
		rurl = json['rurl'];
		mst = json['mst'];
		pst = json['pst'];
		pop = json['pop'];
		dt = json['dt'];
		rtype = json['rtype'];
		sId = json['s_id'];
		if (json['rtUrls'] != null) {
			rtUrls = new List<Null>();
		}
		id = json['id'];
		st = json['st'];
		a = json['a'];
		cd = json['cd'];
		publishTime = json['publishTime'];
		cf = json['cf'];
		h = json['h'] != null ? new TopSongPlaylistTracksH.fromJson(json['h']) : null;
		mv = json['mv'];
		al = json['al'] != null ? new TopSongPlaylistTracksAl.fromJson(json['al']) : null;
		l = json['l'] != null ? new TopSongPlaylistTracksL.fromJson(json['l']) : null;
		m = json['m'] != null ? new TopSongPlaylistTracksM.fromJson(json['m']) : null;
		cp = json['cp'];
		alia = json['alia']?.cast<String>();
		djId = json['djId'];
		crbt = json['crbt'];
		if (json['ar'] != null) {
			ar = new List<TopSongPlaylistTracksAr>();(json['ar'] as List).forEach((v) { ar.add(new TopSongPlaylistTracksAr.fromJson(v)); });
		}
		rtUrl = json['rtUrl'];
		ftype = json['ftype'];
		t = json['t'];
		v = json['v'];
		name = json['name'];
		tns = json['tns']?.cast<String>();
		mark = json['mark'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['no'] = this.no;
		data['rt'] = this.rt;
		data['copyright'] = this.copyright;
		data['fee'] = this.fee;
		data['rurl'] = this.rurl;
		data['mst'] = this.mst;
		data['pst'] = this.pst;
		data['pop'] = this.pop;
		data['dt'] = this.dt;
		data['rtype'] = this.rtype;
		data['s_id'] = this.sId;
		if (this.rtUrls != null) {
      data['rtUrls'] =  [];
    }
		data['id'] = this.id;
		data['st'] = this.st;
		data['a'] = this.a;
		data['cd'] = this.cd;
		data['publishTime'] = this.publishTime;
		data['cf'] = this.cf;
		if (this.h != null) {
      data['h'] = this.h.toJson();
    }
		data['mv'] = this.mv;
		if (this.al != null) {
      data['al'] = this.al.toJson();
    }
		if (this.l != null) {
      data['l'] = this.l.toJson();
    }
		if (this.m != null) {
      data['m'] = this.m.toJson();
    }
		data['cp'] = this.cp;
		data['alia'] = this.alia;
		data['djId'] = this.djId;
		data['crbt'] = this.crbt;
		if (this.ar != null) {
      data['ar'] =  this.ar.map((v) => v.toJson()).toList();
    }
		data['rtUrl'] = this.rtUrl;
		data['ftype'] = this.ftype;
		data['t'] = this.t;
		data['v'] = this.v;
		data['name'] = this.name;
		data['tns'] = this.tns;
		data['mark'] = this.mark;
		return data;
	}
}

class TopSongPlaylistTracksH {
	num br;
	num fid;
	num size;
	num vd;

	TopSongPlaylistTracksH({this.br, this.fid, this.size, this.vd});

	TopSongPlaylistTracksH.fromJson(Map<String, dynamic> json) {
		br = json['br'];
		fid = json['fid'];
		size = json['size'];
		vd = json['vd'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['br'] = this.br;
		data['fid'] = this.fid;
		data['size'] = this.size;
		data['vd'] = this.vd;
		return data;
	}
}

class TopSongPlaylistTracksAl {
	String picUrl;
	String name;
	List<Null> tns;
	String picStr;
	num id;
	num pic;

	TopSongPlaylistTracksAl({this.picUrl, this.name, this.tns, this.picStr, this.id, this.pic});

	TopSongPlaylistTracksAl.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		name = json['name'];
		if (json['tns'] != null) {
			tns = new List<Null>();
		}
		picStr = json['pic_str'];
		id = json['id'];
		pic = json['pic'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['name'] = this.name;
		if (this.tns != null) {
      data['tns'] =  [];
    }
		data['pic_str'] = this.picStr;
		data['id'] = this.id;
		data['pic'] = this.pic;
		return data;
	}
}

class TopSongPlaylistTracksL {
	num br;
	num fid;
	num size;
	num vd;

	TopSongPlaylistTracksL({this.br, this.fid, this.size, this.vd});

	TopSongPlaylistTracksL.fromJson(Map<String, dynamic> json) {
		br = json['br'];
		fid = json['fid'];
		size = json['size'];
		vd = json['vd'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['br'] = this.br;
		data['fid'] = this.fid;
		data['size'] = this.size;
		data['vd'] = this.vd;
		return data;
	}
}

class TopSongPlaylistTracksM {
	num br;
	num fid;
	num size;
	num vd;

	TopSongPlaylistTracksM({this.br, this.fid, this.size, this.vd});

	TopSongPlaylistTracksM.fromJson(Map<String, dynamic> json) {
		br = json['br'];
		fid = json['fid'];
		size = json['size'];
		vd = json['vd'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['br'] = this.br;
		data['fid'] = this.fid;
		data['size'] = this.size;
		data['vd'] = this.vd;
		return data;
	}
}

class TopSongPlaylistTracksAr {
	String name;
	List<Null> tns;
	List<Null> alias;
	num id;

	TopSongPlaylistTracksAr({this.name, this.tns, this.alias, this.id});

	TopSongPlaylistTracksAr.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		if (json['tns'] != null) {
			tns = new List<Null>();
		}
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		if (this.tns != null) {
      data['tns'] =  [];
    }
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['id'] = this.id;
		return data;
	}
}
