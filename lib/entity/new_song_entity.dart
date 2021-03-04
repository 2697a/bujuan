class NewSongEntity {
	List<NewSongResult> result;
	int code;
	int category;

	NewSongEntity({this.result, this.code, this.category});

	NewSongEntity.fromJson(Map<String, dynamic> json) {
		if (json['result'] != null) {
			result = new List<NewSongResult>();(json['result'] as List).forEach((v) { result.add(new NewSongResult.fromJson(v)); });
		}
		code = json['code'];
		category = json['category'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] =  this.result.map((v) => v.toJson()).toList();
    }
		data['code'] = this.code;
		data['category'] = this.category;
		return data;
	}
}

class NewSongResult {
	NewSongResultSong song;
	dynamic picUrl;
	bool canDislike;
	String name;
	dynamic copywriter;
	int id;
	int type;
	String alg;

	NewSongResult({this.song, this.picUrl, this.canDislike, this.name, this.copywriter, this.id, this.type, this.alg});

	NewSongResult.fromJson(Map<String, dynamic> json) {
		song = json['song'] != null ? new NewSongResultSong.fromJson(json['song']) : null;
		picUrl = json['picUrl'];
		canDislike = json['canDislike'];
		name = json['name'];
		copywriter = json['copywriter'];
		id = json['id'];
		type = json['type'];
		alg = json['alg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.song != null) {
      data['song'] = this.song.toJson();
    }
		data['picUrl'] = this.picUrl;
		data['canDislike'] = this.canDislike;
		data['name'] = this.name;
		data['copywriter'] = this.copywriter;
		data['id'] = this.id;
		data['type'] = this.type;
		data['alg'] = this.alg;
		return data;
	}
}

class NewSongResultSong {
	int no;
	int copyright;
	int dayPlays;
	int fee;
	dynamic sign;
	dynamic rurl;
	NewSongResultSongPrivilege privilege;
	NewSongResultSongMmusic mMusic;
	NewSongResultSongBmusic bMusic;
	int duration;
	int score;
	int rtype;
	bool starred;
	List<NewSongResultSongArtist> artists;
	List<Null> rtUrls;
	double popularity;
	int playedNum;
	int hearTime;
	List<Null> alias;
	int starredNum;
	bool exclusive;
	int id;
	dynamic mp3Url;
	dynamic audition;
	dynamic transName;
	NewSongResultSongAlbum album;
	NewSongResultSongLmusic lMusic;
	String ringtone;
	String commentThreadId;
	String copyFrom;
	dynamic crbt;
	dynamic rtUrl;
	int ftype;
	int copyrightId;
	NewSongResultSongHmusic hMusic;
	int mvid;
	String name;
	String disc;
	int position;
	int mark;
	int status;

	NewSongResultSong({this.no, this.copyright, this.dayPlays, this.fee, this.sign, this.rurl, this.privilege, this.mMusic, this.bMusic, this.duration, this.score, this.rtype, this.starred, this.artists, this.rtUrls, this.popularity, this.playedNum, this.hearTime, this.alias, this.starredNum, this.exclusive, this.id, this.mp3Url, this.audition, this.transName, this.album, this.lMusic, this.ringtone, this.commentThreadId, this.copyFrom, this.crbt, this.rtUrl, this.ftype, this.copyrightId, this.hMusic, this.mvid, this.name, this.disc, this.position, this.mark, this.status});

	NewSongResultSong.fromJson(Map<String, dynamic> json) {
		no = json['no'];
		copyright = json['copyright'];
		dayPlays = json['dayPlays'];
		fee = json['fee'];
		sign = json['sign'];
		rurl = json['rurl'];
		privilege = json['privilege'] != null ? new NewSongResultSongPrivilege.fromJson(json['privilege']) : null;
		mMusic = json['mMusic'] != null ? new NewSongResultSongMmusic.fromJson(json['mMusic']) : null;
		bMusic = json['bMusic'] != null ? new NewSongResultSongBmusic.fromJson(json['bMusic']) : null;
		duration = json['duration'];
		score = json['score'];
		rtype = json['rtype'];
		starred = json['starred'];
		if (json['artists'] != null) {
			artists = new List<NewSongResultSongArtist>();(json['artists'] as List).forEach((v) { artists.add(new NewSongResultSongArtist.fromJson(v)); });
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
		exclusive = json['exclusive'];
		id = json['id'];
		mp3Url = json['mp3Url'];
		audition = json['audition'];
		transName = json['transName'];
		album = json['album'] != null ? new NewSongResultSongAlbum.fromJson(json['album']) : null;
		lMusic = json['lMusic'] != null ? new NewSongResultSongLmusic.fromJson(json['lMusic']) : null;
		ringtone = json['ringtone'];
		commentThreadId = json['commentThreadId'];
		copyFrom = json['copyFrom'];
		crbt = json['crbt'];
		rtUrl = json['rtUrl'];
		ftype = json['ftype'];
		copyrightId = json['copyrightId'];
		hMusic = json['hMusic'] != null ? new NewSongResultSongHmusic.fromJson(json['hMusic']) : null;
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
		data['exclusive'] = this.exclusive;
		data['id'] = this.id;
		data['mp3Url'] = this.mp3Url;
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

class NewSongResultSongPrivilege {
	int st;
	int flag;
	int subp;
	int fl;
	int fee;
	int dl;
	int cp;
	bool preSell;
	bool cs;
	bool toast;
	int maxbr;
	int id;
	int pl;
	int sp;
	int payed;

	NewSongResultSongPrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.preSell, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	NewSongResultSongPrivilege.fromJson(Map<String, dynamic> json) {
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

class NewSongResultSongMmusic {
	String extension;
	int size;
	double volumeDelta;
	dynamic name;
	int bitrate;
	int playTime;
	int id;
	int dfsId;
	int sr;

	NewSongResultSongMmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	NewSongResultSongMmusic.fromJson(Map<String, dynamic> json) {
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

class NewSongResultSongBmusic {
	String extension;
	int size;
	double volumeDelta;
	dynamic name;
	int bitrate;
	int playTime;
	int id;
	int dfsId;
	int sr;

	NewSongResultSongBmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	NewSongResultSongBmusic.fromJson(Map<String, dynamic> json) {
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

class NewSongResultSongArtist {
	String picUrl;
	String img1v1Url;
	int topicPerson;
	String briefDesc;
	int musicSize;
	String name;
	List<Null> alias;
	int img1v1Id;
	int id;
	int picId;
	int albumSize;
	String trans;

	NewSongResultSongArtist({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	NewSongResultSongArtist.fromJson(Map<String, dynamic> json) {
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

class NewSongResultSongAlbum {
	NewSongResultSongAlbumArtist artist;
	String description;
	int pic;
	String type;
	String picUrl;
	String briefDesc;
	List<NewSongResultSongAlbumArtist> artists;
	List<Null> alias;
	String company;
	int id;
	int picId;
	dynamic transName;
	int publishTime;
	String picidStr;
	String blurPicUrl;
	String commentThreadId;
	String tags;
	int companyId;
	int size;
	int copyrightId;
	List<Null> songs;
	String name;
	String subType;
	int mark;
	int status;

	NewSongResultSongAlbum({this.artist, this.description, this.pic, this.type, this.picUrl, this.briefDesc, this.artists, this.alias, this.company, this.id, this.picId, this.transName, this.publishTime, this.picidStr, this.blurPicUrl, this.commentThreadId, this.tags, this.companyId, this.size, this.copyrightId, this.songs, this.name, this.subType, this.mark, this.status});

	NewSongResultSongAlbum.fromJson(Map<String, dynamic> json) {
		artist = json['artist'] != null ? new NewSongResultSongAlbumArtist.fromJson(json['artist']) : null;
		description = json['description'];
		pic = json['pic'];
		type = json['type'];
		picUrl = json['picUrl'];
		briefDesc = json['briefDesc'];
		if (json['artists'] != null) {
			artists = new List<NewSongResultSongAlbumArtist>();(json['artists'] as List).forEach((v) { artists.add(new NewSongResultSongAlbumArtist.fromJson(v)); });
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

class NewSongResultSongAlbumArtist {
	String picUrl;
	String img1v1Url;
	int topicPerson;
	String briefDesc;
	int musicSize;
	String name;
	List<Null> alias;
	int img1v1Id;
	int id;
	int picId;
	int albumSize;
	String trans;

	NewSongResultSongAlbumArtist({this.picUrl, this.img1v1Url, this.topicPerson, this.briefDesc, this.musicSize, this.name, this.alias, this.img1v1Id, this.id, this.picId, this.albumSize, this.trans});

	NewSongResultSongAlbumArtist.fromJson(Map<String, dynamic> json) {
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

class NewSongResultSongLmusic {
	String extension;
	int size;
	double volumeDelta;
	dynamic name;
	int bitrate;
	int playTime;
	int id;
	int dfsId;
	int sr;

	NewSongResultSongLmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	NewSongResultSongLmusic.fromJson(Map<String, dynamic> json) {
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

class NewSongResultSongHmusic {
	String extension;
	int size;
	double volumeDelta;
	dynamic name;
	int bitrate;
	int playTime;
	int id;
	int dfsId;
	int sr;

	NewSongResultSongHmusic({this.extension, this.size, this.volumeDelta, this.name, this.bitrate, this.playTime, this.id, this.dfsId, this.sr});

	NewSongResultSongHmusic.fromJson(Map<String, dynamic> json) {
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
