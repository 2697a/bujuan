class CloudEntity {
	num code;
	List<CloudData> data;
	String size;
	num upgradeSign;
	num count;
	bool hasMore;
	String maxSize;

	CloudEntity({this.code, this.data, this.size, this.upgradeSign, this.count, this.hasMore, this.maxSize});

	CloudEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<CloudData>();(json['data'] as List).forEach((v) { data.add(new CloudData.fromJson(v)); });
		}
		size = json['size'];
		upgradeSign = json['upgradeSign'];
		count = json['count'];
		hasMore = json['hasMore'];
		maxSize = json['maxSize'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['size'] = this.size;
		data['upgradeSign'] = this.upgradeSign;
		data['count'] = this.count;
		data['hasMore'] = this.hasMore;
		data['maxSize'] = this.maxSize;
		return data;
	}
}

class CloudData {
	String songName;
	String fileName;
	num addTime;
	String artist;
	String album;
	String lyricId;
	num bitrate;
	CloudDataSimplesong simpleSong;
	num version;
	num cover;
	String coverId;
	num fileSize;
	num songId;

	CloudData({this.songName, this.fileName, this.addTime, this.artist, this.album, this.lyricId, this.bitrate, this.simpleSong, this.version, this.cover, this.coverId, this.fileSize, this.songId});

	CloudData.fromJson(Map<String, dynamic> json) {
		songName = json['songName'];
		fileName = json['fileName'];
		addTime = json['addTime'];
		artist = json['artist'];
		album = json['album'];
		lyricId = json['lyricId'];
		bitrate = json['bitrate'];
		simpleSong = json['simpleSong'] != null ? new CloudDataSimplesong.fromJson(json['simpleSong']) : null;
		version = json['version'];
		cover = json['cover'];
		coverId = json['coverId'];
		fileSize = json['fileSize'];
		songId = json['songId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['songName'] = this.songName;
		data['fileName'] = this.fileName;
		data['addTime'] = this.addTime;
		data['artist'] = this.artist;
		data['album'] = this.album;
		data['lyricId'] = this.lyricId;
		data['bitrate'] = this.bitrate;
		if (this.simpleSong != null) {
      data['simpleSong'] = this.simpleSong.toJson();
    }
		data['version'] = this.version;
		data['cover'] = this.cover;
		data['coverId'] = this.coverId;
		data['fileSize'] = this.fileSize;
		data['songId'] = this.songId;
		return data;
	}
}

class CloudDataSimplesong {
	num no;
	String rt;
	num copyright;
	num fee;
	dynamic rurl;
	CloudDataSimplesongPrivilege privilege;
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
	dynamic h;
	num mv;
	CloudDataSimplesongAl al;
	CloudDataSimplesongL l;
	CloudDataSimplesongM m;
	num cp;
	List<Null> alia;
	num djId;
	String crbt;
	List<CloudDataSimplesongAr> ar;
	dynamic rtUrl;
	num ftype;
	num t;
	num v;
	String name;

	CloudDataSimplesong({this.no, this.rt, this.copyright, this.fee, this.rurl, this.privilege, this.mst, this.pst, this.pop, this.dt, this.rtype, this.sId, this.rtUrls, this.id, this.st, this.a, this.cd, this.publishTime, this.cf, this.h, this.mv, this.al, this.l, this.m, this.cp, this.alia, this.djId, this.crbt, this.ar, this.rtUrl, this.ftype, this.t, this.v, this.name});

	CloudDataSimplesong.fromJson(Map<String, dynamic> json) {
		no = json['no'];
		rt = json['rt'];
		copyright = json['copyright'];
		fee = json['fee'];
		rurl = json['rurl'];
		privilege = json['privilege'] != null ? new CloudDataSimplesongPrivilege.fromJson(json['privilege']) : null;
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
		h = json['h'];
		mv = json['mv'];
		al = json['al'] != null ? new CloudDataSimplesongAl.fromJson(json['al']) : null;
		l = json['l'] != null ? new CloudDataSimplesongL.fromJson(json['l']) : null;
		m = json['m'] != null ? new CloudDataSimplesongM.fromJson(json['m']) : null;
		cp = json['cp'];
		if (json['alia'] != null) {
			alia = new List<Null>();
		}
		djId = json['djId'];
		crbt = json['crbt'];
		if (json['ar'] != null) {
			ar = new List<CloudDataSimplesongAr>();(json['ar'] as List).forEach((v) { ar.add(new CloudDataSimplesongAr.fromJson(v)); });
		}
		rtUrl = json['rtUrl'];
		ftype = json['ftype'];
		t = json['t'];
		v = json['v'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['no'] = this.no;
		data['rt'] = this.rt;
		data['copyright'] = this.copyright;
		data['fee'] = this.fee;
		data['rurl'] = this.rurl;
		if (this.privilege != null) {
      data['privilege'] = this.privilege.toJson();
    }
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
		data['h'] = this.h;
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
		if (this.alia != null) {
      data['alia'] =  [];
    }
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
		return data;
	}
}

class CloudDataSimplesongPrivilege {
	num st;
	num flag;
	num subp;
	num fl;
	num fee;
	num dl;
	num cp;
	bool cs;
	bool toast;
	num maxbr;
	num id;
	num pl;
	num sp;
	num payed;

	CloudDataSimplesongPrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	CloudDataSimplesongPrivilege.fromJson(Map<String, dynamic> json) {
		st = json['st'];
		flag = json['flag'];
		subp = json['subp'];
		fl = json['fl'];
		fee = json['fee'];
		dl = json['dl'];
		cp = json['cp'];
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

class CloudDataSimplesongAl {
	String picUrl;
	String name;
	List<Null> tns;
	num id;
	num pic;

	CloudDataSimplesongAl({this.picUrl, this.name, this.tns, this.id, this.pic});

	CloudDataSimplesongAl.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		name = json['name'];
		if (json['tns'] != null) {
			tns = new List<Null>();
		}
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
		data['id'] = this.id;
		data['pic'] = this.pic;
		return data;
	}
}

class CloudDataSimplesongL {
	num br;
	num fid;
	num size;
	double vd;

	CloudDataSimplesongL({this.br, this.fid, this.size, this.vd});

	CloudDataSimplesongL.fromJson(Map<String, dynamic> json) {
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

class CloudDataSimplesongM {
	num br;
	num fid;
	num size;
	double vd;

	CloudDataSimplesongM({this.br, this.fid, this.size, this.vd});

	CloudDataSimplesongM.fromJson(Map<String, dynamic> json) {
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

class CloudDataSimplesongAr {
	String name;
	List<Null> tns;
	List<Null> alias;
	num id;

	CloudDataSimplesongAr({this.name, this.tns, this.alias, this.id});

	CloudDataSimplesongAr.fromJson(Map<String, dynamic> json) {
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
