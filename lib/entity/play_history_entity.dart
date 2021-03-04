class PlayHistoryEntity {
	List<PlayHistoryAlldata> allData;
	num code;

	PlayHistoryEntity({this.allData, this.code});

	PlayHistoryEntity.fromJson(Map<String, dynamic> json) {
		if (json['allData'] != null) {
			allData = new List<PlayHistoryAlldata>();(json['allData'] as List).forEach((v) { allData.add(new PlayHistoryAlldata.fromJson(v)); });
		}
		code = json['code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.allData != null) {
      data['allData'] =  this.allData.map((v) => v.toJson()).toList();
    }
		data['code'] = this.code;
		return data;
	}
}

class PlayHistoryAlldata {
	PlayHistoryWeekdataSong song;
	num playCount;
	num score;

	PlayHistoryAlldata({this.song, this.playCount, this.score});

	PlayHistoryAlldata.fromJson(Map<String, dynamic> json) {
		song = json['song'] != null ? new PlayHistoryWeekdataSong.fromJson(json['song']) : null;
		playCount = json['playCount'];
		score = json['score'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.song != null) {
      data['song'] = this.song.toJson();
    }
		data['playCount'] = this.playCount;
		data['score'] = this.score;
		return data;
	}
}

class PlayHistoryWeekdataSong {
	num no;
	dynamic rt;
	num copyright;
	num fee;
	dynamic rurl;
	PlayHistoryWeekdataSongPrivilege privilege;
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
	PlayHistoryWeekdataSongH h;
	num mv;
	PlayHistoryWeekdataSongAl al;
	PlayHistoryWeekdataSongL l;
	PlayHistoryWeekdataSongM m;
	num cp;
	List<Null> alia;
	num djId;
	dynamic crbt;
	List<PlayHistoryWeekdataSongAr> ar;
	dynamic rtUrl;
	num ftype;
	num t;
	num v;
	String name;
	num mark;

	PlayHistoryWeekdataSong({this.no, this.rt, this.copyright, this.fee, this.rurl, this.privilege, this.mst, this.pst, this.pop, this.dt, this.rtype, this.sId, this.rtUrls, this.id, this.st, this.a, this.cd, this.publishTime, this.cf, this.h, this.mv, this.al, this.l, this.m, this.cp, this.alia, this.djId, this.crbt, this.ar, this.rtUrl, this.ftype, this.t, this.v, this.name, this.mark});

	PlayHistoryWeekdataSong.fromJson(Map<String, dynamic> json) {
		no = json['no'];
		rt = json['rt'];
		copyright = json['copyright'];
		fee = json['fee'];
		rurl = json['rurl'];
		privilege = json['privilege'] != null ? new PlayHistoryWeekdataSongPrivilege.fromJson(json['privilege']) : null;
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
		h = json['h'] != null ? new PlayHistoryWeekdataSongH.fromJson(json['h']) : null;
		mv = json['mv'];
		al = json['al'] != null ? new PlayHistoryWeekdataSongAl.fromJson(json['al']) : null;
		l = json['l'] != null ? new PlayHistoryWeekdataSongL.fromJson(json['l']) : null;
		m = json['m'] != null ? new PlayHistoryWeekdataSongM.fromJson(json['m']) : null;
		cp = json['cp'];
		if (json['alia'] != null) {
			alia = new List<Null>();
		}
		djId = json['djId'];
		crbt = json['crbt'];
		if (json['ar'] != null) {
			ar = new List<PlayHistoryWeekdataSongAr>();(json['ar'] as List).forEach((v) { ar.add(new PlayHistoryWeekdataSongAr.fromJson(v)); });
		}
		rtUrl = json['rtUrl'];
		ftype = json['ftype'];
		t = json['t'];
		v = json['v'];
		name = json['name'];
		mark = json['mark'];
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
		data['mark'] = this.mark;
		return data;
	}
}

class PlayHistoryWeekdataSongPrivilege {
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

	PlayHistoryWeekdataSongPrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.preSell, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	PlayHistoryWeekdataSongPrivilege.fromJson(Map<String, dynamic> json) {
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

class PlayHistoryWeekdataSongH {
	num br;
	num fid;
	num size;
	double vd;

	PlayHistoryWeekdataSongH({this.br, this.fid, this.size, this.vd});

	PlayHistoryWeekdataSongH.fromJson(Map<String, dynamic> json) {
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

class PlayHistoryWeekdataSongAl {
	String picUrl;
	String name;
	List<Null> tns;
	num id;
	num pic;

	PlayHistoryWeekdataSongAl({this.picUrl, this.name, this.tns, this.id, this.pic});

	PlayHistoryWeekdataSongAl.fromJson(Map<String, dynamic> json) {
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

class PlayHistoryWeekdataSongL {
	num br;
	num fid;
	num size;
	double vd;

	PlayHistoryWeekdataSongL({this.br, this.fid, this.size, this.vd});

	PlayHistoryWeekdataSongL.fromJson(Map<String, dynamic> json) {
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

class PlayHistoryWeekdataSongM {
	num br;
	num fid;
	num size;
	double vd;

	PlayHistoryWeekdataSongM({this.br, this.fid, this.size, this.vd});

	PlayHistoryWeekdataSongM.fromJson(Map<String, dynamic> json) {
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

class PlayHistoryWeekdataSongAr {
	String name;
	List<Null> tns;
	List<Null> alias;
	num id;

	PlayHistoryWeekdataSongAr({this.name, this.tns, this.alias, this.id});

	PlayHistoryWeekdataSongAr.fromJson(Map<String, dynamic> json) {
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
