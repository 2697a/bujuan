class TodaySongEntity {
	num code;
	List<TodaySongRecommand> recommend;

	TodaySongEntity({this.code, this.recommend});

	TodaySongEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['recommend'] != null) {
			recommend = new List<TodaySongRecommand>();(json['recommend'] as List).forEach((v) { recommend.add(new TodaySongRecommand.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.recommend != null) {
      data['recommend'] =  this.recommend.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TodaySongRecommand {
	num no;
	String reason;
	num copyright;
	num dayPlays;
	num fee;
	dynamic sign;
	dynamic rurl;
	TodaySongRecommendPrivilege privilege;
	TodaySongRecommendMmusic mMusic;
	TodaySongRecommendBmusic bMusic;
	num duration;
	num score;
	num rtype;
	bool starred;
	List<TodaySongRecommandArtists> artists;
	List<Null> rtUrls;
	num popularity;
	num playedNum;
	num hearTime;
	List<Null> alias;
	num starredNum;
	num id;
	dynamic mp3Url;
	String alg;
	dynamic audition;
	dynamic transName;
	TodaySongRecommendAlbum album;
	TodaySongRecommendLmusic lMusic;
	String ringtone;
	String commentThreadId;
	String copyFrom;
	String crbt;
	dynamic rtUrl;
	num ftype;
	num copyrightId;
	TodaySongRecommendHmusic hMusic;
	num mvid;
	String name;
	String disc;
	num position;
	num mark;
	num status;

	TodaySongRecommand({this.no, this.reason, this.copyright, this.dayPlays, this.fee, this.sign, this.rurl, this.privilege, this.mMusic, this.bMusic, this.duration, this.score, this.rtype, this.starred, this.artists, this.rtUrls, this.popularity, this.playedNum, this.hearTime, this.alias, this.starredNum, this.id, this.mp3Url, this.alg, this.audition, this.transName, this.album, this.lMusic, this.ringtone, this.commentThreadId, this.copyFrom, this.crbt, this.rtUrl, this.ftype, this.copyrightId, this.hMusic, this.mvid, this.name, this.disc, this.position, this.mark, this.status});

	TodaySongRecommand.fromJson(Map<String, dynamic> json) {
		no = json['no'];
		reason = json['reason'];
		copyright = json['copyright'];
		dayPlays = json['dayPlays'];
		fee = json['fee'];
		sign = json['sign'];
		rurl = json['rurl'];
		privilege = json['privilege'] != null ? new TodaySongRecommendPrivilege.fromJson(json['privilege']) : null;
		mMusic = json['mMusic'] != null ? new TodaySongRecommendMmusic.fromJson(json['mMusic']) : null;
		bMusic = json['bMusic'] != null ? new TodaySongRecommendBmusic.fromJson(json['bMusic']) : null;
		duration = json['duration'];
		score = json['score'];
		rtype = json['rtype'];
		starred = json['starred'];
		if (json['artists'] != null) {
			artists = new List<TodaySongRecommandArtists>();(json['artists'] as List).forEach((v) { artists.add(new TodaySongRecommandArtists.fromJson(v)); });
		}
		if (json['rtUrls'] != null) {
			rtUrls = new List<Null>();
		}
		popularity = json['popularity'];
		playedNum = json['playedNum'];
		hearTime = json['hearTime'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		starredNum = json['starredNum'];
		id = json['id'];
		mp3Url = json['mp3Url'];
		alg = json['alg'];
		audition = json['audition'];
		transName = json['transName'];
		album = json['album'] != null ? new TodaySongRecommendAlbum.fromJson(json['album']) : null;
		lMusic = json['lMusic'] != null ? new TodaySongRecommendLmusic.fromJson(json['lMusic']) : null;
		ringtone = json['ringtone'];
		commentThreadId = json['commentThreadId'];
		copyFrom = json['copyFrom'];
		crbt = json['crbt'];
		rtUrl = json['rtUrl'];
		ftype = json['ftype'];
		copyrightId = json['copyrightId'];
		hMusic = json['hMusic'] != null ? new TodaySongRecommendHmusic.fromJson(json['hMusic']) : null;
		mvid = json['mvid'];
		name = json['name'];
		disc = json['disc'];
		position = json['position'];
		mark = json['mark'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['no'] = this.no;
		data['reason'] = this.reason;
		data['copyright'] = this.copyright;
		data['dayPlays'] = this.dayPlays;
		data['fee'] = this.fee;
		data['sign'] = this.sign;
		data['rurl'] = this.rurl;
		if (this.privilege != null) {
      data['privilege'] = this.privilege.toJson();
    }
		if (this.mMusic != null) {
      data['mMusic'] = this.mMusic.toJson();
    }
		if (this.bMusic != null) {
      data['bMusic'] = this.bMusic.toJson();
    }
		data['duration'] = this.duration;
		data['score'] = this.score;
		data['rtype'] = this.rtype;
		data['starred'] = this.starred;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		if (this.rtUrls != null) {
      data['rtUrls'] =  [];
    }
		data['popularity'] = this.popularity;
		data['playedNum'] = this.playedNum;
		data['hearTime'] = this.hearTime;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['starredNum'] = this.starredNum;
		data['id'] = this.id;
		data['mp3Url'] = this.mp3Url;
		data['alg'] = this.alg;
		data['audition'] = this.audition;
		data['transName'] = this.transName;
		if (this.album != null) {
      data['album'] = this.album.toJson();
    }
		if (this.lMusic != null) {
      data['lMusic'] = this.lMusic.toJson();
    }
		data['ringtone'] = this.ringtone;
		data['commentThreadId'] = this.commentThreadId;
		data['copyFrom'] = this.copyFrom;
		data['crbt'] = this.crbt;
		data['rtUrl'] = this.rtUrl;
		data['ftype'] = this.ftype;
		data['copyrightId'] = this.copyrightId;
		if (this.hMusic != null) {
      data['hMusic'] = this.hMusic.toJson();
    }
		data['mvid'] = this.mvid;
		data['name'] = this.name;
		data['disc'] = this.disc;
		data['position'] = this.position;
		data['mark'] = this.mark;
		data['status'] = this.status;
		return data;
	}
}

class TodaySongRecommendPrivilege {
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

	TodaySongRecommendPrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.preSell, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	TodaySongRecommendPrivilege.fromJson(Map<String, dynamic> json) {
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

class TodaySongRecommendMmusic {
	String extension;
	num size;
	dynamic name;
	num playTime;
	num id;
	num dfsId;
	num sr;

	TodaySongRecommendMmusic({this.extension, this.size, this.name,  this.playTime, this.id, this.dfsId, this.sr});

	TodaySongRecommendMmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		name = json['name'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['name'] = this.name;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}

class TodaySongRecommendBmusic {
	String extension;
	num size;
	dynamic name;
	num playTime;
	num id;
	num dfsId;
	num sr;

	TodaySongRecommendBmusic({this.extension, this.size, this.name, this.playTime, this.id, this.dfsId, this.sr});

	TodaySongRecommendBmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		name = json['name'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['name'] = this.name;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}

class TodaySongRecommandArtists {
	String picUrl;
	String img1v1Url;
	num topicPerson;
	String briefDesc;
	num musicSize;
	String name;
	List<Null> alias;
	num img1v1Id;
	num id;
	num picId;
	num albumSize;
	String trans;

	TodaySongRecommandArtists({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	TodaySongRecommandArtists.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		topicPerson = json['topicPerson'];
		briefDesc = json['briefDesc'];
		musicSize = json['musicSize'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		img1v1Id = json['img1v1Id'];
		id = json['id'];
		picId = json['picId'];
		albumSize = json['albumSize'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['topicPerson'] = this.topicPerson;
		data['briefDesc'] = this.briefDesc;
		data['musicSize'] = this.musicSize;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['img1v1Id'] = this.img1v1Id;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['albumSize'] = this.albumSize;
		data['trans'] = this.trans;
		return data;
	}
}

class TodaySongRecommendAlbum {
	TodaySongRecommendAlbumArtist artist;
	String description;
	num pic;
	String type;
	String picUrl;
	String briefDesc;
	List<TodaySongRecommandAlbumArtists> artists;
	List<Null> alias;
	String company;
	num id;
	num picId;
	dynamic transName;
	num publishTime;
	String picidStr;
	String blurPicUrl;
	String commentThreadId;
	String tags;
	num companyId;
	num size;
	num copyrightId;
	List<Null> songs;
	String name;
	String subType;
	num mark;
	num status;

	TodaySongRecommendAlbum({this.artist, this.description, this.pic, this.type, this.picUrl, this.briefDesc, this.artists, this.alias, this.company, this.id, this.picId, this.transName, this.publishTime, this.picidStr, this.blurPicUrl, this.commentThreadId, this.tags, this.companyId, this.size, this.copyrightId, this.songs, this.name, this.subType, this.mark, this.status});

	TodaySongRecommendAlbum.fromJson(Map<String, dynamic> json) {
		artist = json['artist'] != null ? new TodaySongRecommendAlbumArtist.fromJson(json['artist']) : null;
		description = json['description'];
		pic = json['pic'];
		type = json['type'];
		picUrl = json['picUrl'];
		briefDesc = json['briefDesc'];
		if (json['artists'] != null) {
			artists = new List<TodaySongRecommandAlbumArtists>();(json['artists'] as List).forEach((v) { artists.add(new TodaySongRecommandAlbumArtists.fromJson(v)); });
		}
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		company = json['company'];
		id = json['id'];
		picId = json['picId'];
		transName = json['transName'];
		publishTime = json['publishTime'];
		picidStr = json['picId_str'];
		blurPicUrl = json['blurPicUrl'];
		commentThreadId = json['commentThreadId'];
		tags = json['tags'];
		companyId = json['companyId'];
		size = json['size'];
		copyrightId = json['copyrightId'];
		if (json['songs'] != null) {
			songs = new List<Null>();
		}
		name = json['name'];
		subType = json['subType'];
		mark = json['mark'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
		data['description'] = this.description;
		data['pic'] = this.pic;
		data['type'] = this.type;
		data['picUrl'] = this.picUrl;
		data['briefDesc'] = this.briefDesc;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['company'] = this.company;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['transName'] = this.transName;
		data['publishTime'] = this.publishTime;
		data['picId_str'] = this.picidStr;
		data['blurPicUrl'] = this.blurPicUrl;
		data['commentThreadId'] = this.commentThreadId;
		data['tags'] = this.tags;
		data['companyId'] = this.companyId;
		data['size'] = this.size;
		data['copyrightId'] = this.copyrightId;
		if (this.songs != null) {
      data['songs'] =  [];
    }
		data['name'] = this.name;
		data['subType'] = this.subType;
		data['mark'] = this.mark;
		data['status'] = this.status;
		return data;
	}
}

class TodaySongRecommendAlbumArtist {
	String picUrl;
	String img1v1Url;
	num topicPerson;
	String briefDesc;
	num musicSize;
	String name;
	List<Null> alias;
	num img1v1Id;
	num id;
	num picId;
	num albumSize;
	String trans;

	TodaySongRecommendAlbumArtist({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	TodaySongRecommendAlbumArtist.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		topicPerson = json['topicPerson'];
		briefDesc = json['briefDesc'];
		musicSize = json['musicSize'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		img1v1Id = json['img1v1Id'];
		id = json['id'];
		picId = json['picId'];
		albumSize = json['albumSize'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['topicPerson'] = this.topicPerson;
		data['briefDesc'] = this.briefDesc;
		data['musicSize'] = this.musicSize;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['img1v1Id'] = this.img1v1Id;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['albumSize'] = this.albumSize;
		data['trans'] = this.trans;
		return data;
	}
}

class TodaySongRecommandAlbumArtists {
	String picUrl;
	String img1v1Url;
	num topicPerson;
	String briefDesc;
	num musicSize;
	String name;
	List<Null> alias;
	num img1v1Id;
	num id;
	num picId;
	num albumSize;
	String trans;

	TodaySongRecommandAlbumArtists({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	TodaySongRecommandAlbumArtists.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		topicPerson = json['topicPerson'];
		briefDesc = json['briefDesc'];
		musicSize = json['musicSize'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		img1v1Id = json['img1v1Id'];
		id = json['id'];
		picId = json['picId'];
		albumSize = json['albumSize'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['topicPerson'] = this.topicPerson;
		data['briefDesc'] = this.briefDesc;
		data['musicSize'] = this.musicSize;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['img1v1Id'] = this.img1v1Id;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['albumSize'] = this.albumSize;
		data['trans'] = this.trans;
		return data;
	}
}

class TodaySongRecommendLmusic {
	String extension;
	num size;
	dynamic name;
	num playTime;
	num id;
	num dfsId;
	num sr;

	TodaySongRecommendLmusic({this.extension, this.size,  this.name,  this.playTime, this.id, this.dfsId, this.sr});

	TodaySongRecommendLmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		name = json['name'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['name'] = this.name;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}

class TodaySongRecommendHmusic {
	String extension;
	num size;
	dynamic name;
	num playTime;
	num id;
	num dfsId;
	num sr;

	TodaySongRecommendHmusic({this.extension, this.size,  this.name,  this.playTime, this.id, this.dfsId, this.sr});

	TodaySongRecommendHmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		name = json['name'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['name'] = this.name;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}
