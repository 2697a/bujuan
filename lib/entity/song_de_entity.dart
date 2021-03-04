class SongDeEntity {
	List<SongDePrivilege> privileges;
	num code;
	List<SongDeSong> songs;

	SongDeEntity({this.privileges, this.code, this.songs});

	SongDeEntity.fromJson(Map<String, dynamic> json) {
		if (json['privileges'] != null) {
			privileges = new List<SongDePrivilege>();(json['privileges'] as List).forEach((v) { privileges.add(new SongDePrivilege.fromJson(v)); });
		}
		code = json['code'];
		if (json['songs'] != null) {
			songs = new List<SongDeSong>();(json['songs'] as List).forEach((v) { songs.add(new SongDeSong.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.privileges != null) {
      data['privileges'] =  this.privileges.map((v) => v.toJson()).toList();
    }
		data['code'] = this.code;
		if (this.songs != null) {
      data['songs'] =  this.songs.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SongDePrivilege {
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

	SongDePrivilege({this.st, this.flag, this.subp, this.fl, this.fee, this.dl, this.cp, this.preSell, this.cs, this.toast, this.maxbr, this.id, this.pl, this.sp, this.payed});

	SongDePrivilege.fromJson(Map<String, dynamic> json) {
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

class SongDeSong {
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
	SongDeSongsH h;
	num mv;
	SongDeSongsAl al;
	SongDeSongsL l;
	SongDeSongsM m;
	num cp;
	List<Null> alia;
	num djId;
	dynamic crbt;
	List<SongDeSongsAr> ar;
	dynamic rtUrl;
	num ftype;
	num t;
	num v;
	String name;
	num mark;

	SongDeSong({this.no, this.rt, this.copyright, this.fee, this.rurl, this.mst, this.pst, this.pop, this.dt, this.rtype, this.sId, this.rtUrls, this.id, this.st, this.a, this.cd, this.publishTime, this.cf, this.h, this.mv, this.al, this.l, this.m, this.cp, this.alia, this.djId, this.crbt, this.ar, this.rtUrl, this.ftype, this.t, this.v, this.name, this.mark});

	SongDeSong.fromJson(Map<String, dynamic> json) {
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
		h = json['h'] != null ? new SongDeSongsH.fromJson(json['h']) : null;
		mv = json['mv'];
		al = json['al'] != null ? new SongDeSongsAl.fromJson(json['al']) : null;
		l = json['l'] != null ? new SongDeSongsL.fromJson(json['l']) : null;
		m = json['m'] != null ? new SongDeSongsM.fromJson(json['m']) : null;
		cp = json['cp'];
		if (json['alia'] != null) {
			alia = new List<Null>();
		}
		djId = json['djId'];
		crbt = json['crbt'];
		if (json['ar'] != null) {
			ar = new List<SongDeSongsAr>();(json['ar'] as List).forEach((v) { ar.add(new SongDeSongsAr.fromJson(v)); });
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

class SongDeSongsH {
	num br;
	num fid;
	num size;
	double vd;

	SongDeSongsH({this.br, this.fid, this.size, this.vd});

	SongDeSongsH.fromJson(Map<String, dynamic> json) {
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

class SongDeSongsAl {
	String picUrl;
	String name;
	List<Null> tns;
	num id;
	num pic;

	SongDeSongsAl({this.picUrl, this.name, this.tns, this.id, this.pic});

	SongDeSongsAl.fromJson(Map<String, dynamic> json) {
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

class SongDeSongsL {
	num br;
	num fid;
	num size;
	double vd;

	SongDeSongsL({this.br, this.fid, this.size, this.vd});

	SongDeSongsL.fromJson(Map<String, dynamic> json) {
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

class SongDeSongsM {
	num br;
	num fid;
	num size;
	double vd;

	SongDeSongsM({this.br, this.fid, this.size, this.vd});

	SongDeSongsM.fromJson(Map<String, dynamic> json) {
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

class SongDeSongsAr {
	String name;
	List<Null> tns;
	List<Null> alias;
	num id;

	SongDeSongsAr({this.name, this.tns, this.alias, this.id});

	SongDeSongsAr.fromJson(Map<String, dynamic> json) {
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
