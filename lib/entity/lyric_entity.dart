class LyricEntity {
	LyricLyricuser lyricUser;
	int code;
	bool qfy;
	LyricTransuser transUser;
	LyricKlyric klyric;
	bool sfy;
	LyricTlyric tlyric;
	LyricLrc lrc;
	bool sgc;

	LyricEntity({this.lyricUser, this.code, this.qfy, this.transUser, this.klyric, this.sfy, this.tlyric, this.lrc, this.sgc});

	LyricEntity.fromJson(Map<String, dynamic> json) {
		lyricUser = json['lyricUser'] != null ? new LyricLyricuser.fromJson(json['lyricUser']) : null;
		code = json['code'];
		qfy = json['qfy'];
		transUser = json['transUser'] != null ? new LyricTransuser.fromJson(json['transUser']) : null;
		klyric = json['klyric'] != null ? new LyricKlyric.fromJson(json['klyric']) : null;
		sfy = json['sfy'];
		tlyric = json['tlyric'] != null ? new LyricTlyric.fromJson(json['tlyric']) : null;
		lrc = json['lrc'] != null ? new LyricLrc.fromJson(json['lrc']) : null;
		sgc = json['sgc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.lyricUser != null) {
      data['lyricUser'] = this.lyricUser.toJson();
    }
		data['code'] = this.code;
		data['qfy'] = this.qfy;
		if (this.transUser != null) {
      data['transUser'] = this.transUser.toJson();
    }
		if (this.klyric != null) {
      data['klyric'] = this.klyric.toJson();
    }
		data['sfy'] = this.sfy;
		if (this.tlyric != null) {
      data['tlyric'] = this.tlyric.toJson();
    }
		if (this.lrc != null) {
      data['lrc'] = this.lrc.toJson();
    }
		data['sgc'] = this.sgc;
		return data;
	}
}

class LyricLyricuser {
	String nickname;
	int id;
	int demand;
	int userid;
	int status;
	int uptime;

	LyricLyricuser({this.nickname, this.id, this.demand, this.userid, this.status, this.uptime});

	LyricLyricuser.fromJson(Map<String, dynamic> json) {
		nickname = json['nickname'];
		id = json['id'];
		demand = json['demand'];
		userid = json['userid'];
		status = json['status'];
		uptime = json['uptime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['nickname'] = this.nickname;
		data['id'] = this.id;
		data['demand'] = this.demand;
		data['userid'] = this.userid;
		data['status'] = this.status;
		data['uptime'] = this.uptime;
		return data;
	}
}

class LyricTransuser {
	String nickname;
	int id;
	int demand;
	int userid;
	int status;
	int uptime;

	LyricTransuser({this.nickname, this.id, this.demand, this.userid, this.status, this.uptime});

	LyricTransuser.fromJson(Map<String, dynamic> json) {
		nickname = json['nickname'];
		id = json['id'];
		demand = json['demand'];
		userid = json['userid'];
		status = json['status'];
		uptime = json['uptime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['nickname'] = this.nickname;
		data['id'] = this.id;
		data['demand'] = this.demand;
		data['userid'] = this.userid;
		data['status'] = this.status;
		data['uptime'] = this.uptime;
		return data;
	}
}

class LyricKlyric {
	dynamic lyric;
	int version;

	LyricKlyric({this.lyric, this.version});

	LyricKlyric.fromJson(Map<String, dynamic> json) {
		lyric = json['lyric'];
		version = json['version'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lyric'] = this.lyric;
		data['version'] = this.version;
		return data;
	}
}

class LyricTlyric {
	String lyric;
	int version;

	LyricTlyric({this.lyric, this.version});

	LyricTlyric.fromJson(Map<String, dynamic> json) {
		lyric = json['lyric'];
		version = json['version'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lyric'] = this.lyric;
		data['version'] = this.version;
		return data;
	}
}

class LyricLrc {
	String lyric;
	int version;

	LyricLrc({this.lyric, this.version});

	LyricLrc.fromJson(Map<String, dynamic> json) {
		lyric = json['lyric'];
		version = json['version'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lyric'] = this.lyric;
		data['version'] = this.version;
		return data;
	}
}
