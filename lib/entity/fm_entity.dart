class FmEntity {
	num code;
	List<FmData> data;
	bool popAdjust;

	FmEntity({this.code, this.data, this.popAdjust});

	FmEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<FmData>();(json['data'] as List).forEach((v) { data.add(new FmData.fromJson(v)); });
		}
		popAdjust = json['popAdjust'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['popAdjust'] = this.popAdjust;
		return data;
	}
}

class FmData {
	num no;
	num copyright;
	num dayPlays;
	num fee;
	dynamic sign;
	dynamic rurl;
	FmDataPrivilege privilege;
	FmDataMmusic mMusic;
	FmDataBmusic bMusic;
	num duration;
	num score;
	num rtype;
	bool starred;
	List<FmDataArtist> artists;
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
	FmDataAlbum album;
	FmDataLmusic lMusic;
	String ringtone;
	String commentThreadId;
	String copyFrom;
	dynamic crbt;
	dynamic rtUrl;
	num ftype;
	num copyrightId;
	FmDataHmusic hMusic;
	num mvid;
	String name;
	String disc;
	num position;
	num mark;
	num status;

	FmData({this.no, this.copyright, this.dayPlays, this.fee, this.sign, this.rurl, this.privilege, this.mMusic, this.bMusic, this.duration, this.score, this.rtype, this.starred, this.artists, this.rtUrls, this.popularity, this.playedNum, this.hearTime, this.alias, this.starredNum, this.id, this.mp3Url, this.alg, this.audition, this.transName, this.album, this.lMusic, this.ringtone, this.commentThreadId, this.copyFrom, this.crbt, this.rtUrl, this.ftype, this.copyrightId, this.hMusic, this.mvid, this.name, this.disc, this.position, this.mark, this.status});

	FmData.fromJson(Map<String, dynamic> json) {
		no = json['no'];
		copyright = json['copyright'];
		dayPlays = json['dayPlays'];
		fee = json['fee'];
		sign = json['sign'];
		rurl = json['rurl'];
		privilege = json['privilege'] != null ? new FmDataPrivilege.fromJson(json['privilege']) : null;
		mMusic = json['mMusic'] != null ? new FmDataMmusic.fromJson(json['mMusic']) : null;
		bMusic = json['bMusic'] != null ? new FmDataBmusic.fromJson(json['bMusic']) : null;
		duration = json['duration'];
		score = json['score'];
		rtype = json['rtype'];
		starred = json['starred'];
		if (json['artists'] != null) {
			artists = new List<FmDataArtist>();(json['artists'] as List).forEach((v) { artists.add(new FmDataArtist.fromJson(v)); });
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
		album = json['album'] != null ? new FmDataAlbum.fromJson(json['album']) : null;
		lMusic = json['lMusic'] != null ? new FmDataLmusic.fromJson(json['lMusic']) : null;
		ringtone = json['ringtone'];
		commentThreadId = json['commentThreadId'];
		copyFrom = json['copyFrom'];
		crbt = json['crbt'];
		rtUrl = json['rtUrl'];
		ftype = json['ftype'];
		copyrightId = json['copyrightId'];
		hMusic = json['hMusic'] != null ? new FmDataHmusic.fromJson(json['hMusic']) : null;
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

class FmDataPrivilege {
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

	FmDataPrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.preSell, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	FmDataPrivilege.fromJson(Map<String, dynamic> json) {
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

class FmDataMmusic {
	String extension;
	num size;
	num volumeDelta;
	dynamic name;
	num bitrate;
	num playTime;
	num id;
	num dfsId;
	num sr;

	FmDataMmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	FmDataMmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		volumeDelta = json['volumeDelta'];
		name = json['name'];
		bitrate = json['bitrate'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['volumeDelta'] = this.volumeDelta;
		data['name'] = this.name;
		data['bitrate'] = this.bitrate;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}

class FmDataBmusic {
	String extension;
	num size;
	num volumeDelta;
	dynamic name;
	num bitrate;
	num playTime;
	num id;
	num dfsId;
	num sr;

	FmDataBmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	FmDataBmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		volumeDelta = json['volumeDelta'];
		name = json['name'];
		bitrate = json['bitrate'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['volumeDelta'] = this.volumeDelta;
		data['name'] = this.name;
		data['bitrate'] = this.bitrate;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}

class FmDataArtist {
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

	FmDataArtist({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	FmDataArtist.fromJson(Map<String, dynamic> json) {
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

class FmDataAlbum {
	dynamic transName;
	num publishTime;
	FmDataAlbumArtist artist;
	String blurPicUrl;
	String description;
	String commentThreadId;
	num pic;
	String type;
	String tags;
	String picUrl;
	num companyId;
	num size;
	String briefDesc;
	num copyrightId;
	List<FmDataAlbumArtist> artists;
	List<Null> songs;
	String name;
	List<Null> alias;
	String company;
	String subType;
	num id;
	num picId;
	num mark;
	num status;

	FmDataAlbum({this.transName, this.publishTime, this.artist, this.blurPicUrl, this.description, this.commentThreadId, this.pic, this.type, this.tags, this.picUrl, this.companyId, this.size, this.briefDesc, this.copyrightId, this.artists, this.songs, this.name, this.alias, this.company, this.subType, this.id, this.picId, this.mark, this.status});

	FmDataAlbum.fromJson(Map<String, dynamic> json) {
		transName = json['transName'];
		publishTime = json['publishTime'];
		artist = json['artist'] != null ? new FmDataAlbumArtist.fromJson(json['artist']) : null;
		blurPicUrl = json['blurPicUrl'];
		description = json['description'];
		commentThreadId = json['commentThreadId'];
		pic = json['pic'];
		type = json['type'];
		tags = json['tags'];
		picUrl = json['picUrl'];
		companyId = json['companyId'];
		size = json['size'];
		briefDesc = json['briefDesc'];
		copyrightId = json['copyrightId'];
		if (json['artists'] != null) {
			artists = new List<FmDataAlbumArtist>();(json['artists'] as List).forEach((v) { artists.add(new FmDataAlbumArtist.fromJson(v)); });
		}
		if (json['songs'] != null) {
			songs = new List<Null>();
		}
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		company = json['company'];
		subType = json['subType'];
		id = json['id'];
		picId = json['picId'];
		mark = json['mark'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['transName'] = this.transName;
		data['publishTime'] = this.publishTime;
		if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
		data['blurPicUrl'] = this.blurPicUrl;
		data['description'] = this.description;
		data['commentThreadId'] = this.commentThreadId;
		data['pic'] = this.pic;
		data['type'] = this.type;
		data['tags'] = this.tags;
		data['picUrl'] = this.picUrl;
		data['companyId'] = this.companyId;
		data['size'] = this.size;
		data['briefDesc'] = this.briefDesc;
		data['copyrightId'] = this.copyrightId;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		if (this.songs != null) {
      data['songs'] =  [];
    }
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['company'] = this.company;
		data['subType'] = this.subType;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['mark'] = this.mark;
		data['status'] = this.status;
		return data;
	}
}

class FmDataAlbumArtist {
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

	FmDataAlbumArtist({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	FmDataAlbumArtist.fromJson(Map<String, dynamic> json) {
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

class FmDataLmusic {
	String extension;
	num size;
	num volumeDelta;
	dynamic name;
	num bitrate;
	num playTime;
	num id;
	num dfsId;
	num sr;

	FmDataLmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	FmDataLmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		volumeDelta = json['volumeDelta'];
		name = json['name'];
		bitrate = json['bitrate'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['volumeDelta'] = this.volumeDelta;
		data['name'] = this.name;
		data['bitrate'] = this.bitrate;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}

class FmDataHmusic {
	String extension;
	num size;
	num volumeDelta;
	dynamic name;
	num bitrate;
	num playTime;
	num id;
	num dfsId;
	num sr;

	FmDataHmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	FmDataHmusic.fromJson(Map<String, dynamic> json) {
		extension = json['extension'];
		size = json['size'];
		volumeDelta = json['volumeDelta'];
		name = json['name'];
		bitrate = json['bitrate'];
		playTime = json['playTime'];
		id = json['id'];
		dfsId = json['dfsId'];
		sr = json['sr'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['extension'] = this.extension;
		data['size'] = this.size;
		data['volumeDelta'] = this.volumeDelta;
		data['name'] = this.name;
		data['bitrate'] = this.bitrate;
		data['playTime'] = this.playTime;
		data['id'] = this.id;
		data['dfsId'] = this.dfsId;
		data['sr'] = this.sr;
		return data;
	}
}
