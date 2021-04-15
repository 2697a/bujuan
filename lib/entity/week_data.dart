class WeekHistory {
  List<WeekData> weekData;
  num code;

  WeekHistory({this.weekData, this.code});

  WeekHistory.fromJson(Map<String, dynamic> json) {
    if (json['weekData'] != null) {
      weekData = new List<WeekData>();
      json['weekData'].forEach((v) {
        weekData.add(new WeekData.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weekData != null) {
      data['weekData'] = this.weekData.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class WeekData {
  num playCount;
  num score;
  Song song;

  WeekData({this.playCount, this.score, this.song});

  WeekData.fromJson(Map<String, dynamic> json) {
    playCount = json['playCount'];
    score = json['score'];
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playCount'] = this.playCount;
    data['score'] = this.score;
    if (this.song != null) {
      data['song'] = this.song.toJson();
    }
    return data;
  }
}

class Song {
  String name;
  num id;
  num pst;
  num t;
  List<Ar> ar;
  num pop;
  num st;
  String rt;
  num fee;
  num v;
  String cf;
  Al al;
  num dt;
  H h;
  H m;
  H l;
  Null a;
  String cd;
  num no;
  num ftype;
  num djId;
  num copyright;
  num sId;
  num mark;
  num originCoverType;
  num single;
  num mst;
  num cp;
  num mv;
  num rtype;
  num publishTime;
  Privilege privilege;

  Song(
      {this.name,
        this.id,
        this.pst,
        this.t,
        this.ar,
        this.pop,
        this.st,
        this.rt,
        this.fee,
        this.v,
        this.cf,
        this.al,
        this.dt,
        this.h,
        this.m,
        this.l,
        this.a,
        this.cd,
        this.no,
        this.ftype,
        this.djId,
        this.copyright,
        this.sId,
        this.mark,
        this.originCoverType,
        this.single,
        this.mst,
        this.cp,
        this.mv,
        this.rtype,
        this.publishTime,
        this.privilege});

  Song.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    pst = json['pst'];
    t = json['t'];
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }
    pop = json['pop'];
    st = json['st'];
    rt = json['rt'];
    fee = json['fee'];
    v = json['v'];
    cf = json['cf'];
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
    dt = json['dt'];
    h = json['h'] != null ? new H.fromJson(json['h']) : null;
    m = json['m'] != null ? new H.fromJson(json['m']) : null;
    l = json['l'] != null ? new H.fromJson(json['l']) : null;
    a = json['a'];
    cd = json['cd'];
    no = json['no'];
    ftype = json['ftype'];
    djId = json['djId'];
    copyright = json['copyright'];
    sId = json['s_id'];
    mark = json['mark'];
    originCoverType = json['originCoverType'];
    single = json['single'];
    mst = json['mst'];
    cp = json['cp'];
    mv = json['mv'];
    rtype = json['rtype'];
    publishTime = json['publishTime'];
    privilege = json['privilege'] != null
        ? new Privilege.fromJson(json['privilege'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['pst'] = this.pst;
    data['t'] = this.t;
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }
    data['pop'] = this.pop;
    data['st'] = this.st;
    data['rt'] = this.rt;
    data['fee'] = this.fee;
    data['v'] = this.v;
    data['cf'] = this.cf;
    if (this.al != null) {
      data['al'] = this.al.toJson();
    }
    data['dt'] = this.dt;
    if (this.h != null) {
      data['h'] = this.h.toJson();
    }
    if (this.m != null) {
      data['m'] = this.m.toJson();
    }
    if (this.l != null) {
      data['l'] = this.l.toJson();
    }
    data['a'] = this.a;
    data['cd'] = this.cd;
    data['no'] = this.no;
    data['ftype'] = this.ftype;
    data['djId'] = this.djId;
    data['copyright'] = this.copyright;
    data['s_id'] = this.sId;
    data['mark'] = this.mark;
    data['originCoverType'] = this.originCoverType;
    data['single'] = this.single;
    data['mst'] = this.mst;
    data['cp'] = this.cp;
    data['mv'] = this.mv;
    data['rtype'] = this.rtype;
    data['publishTime'] = this.publishTime;
    if (this.privilege != null) {
      data['privilege'] = this.privilege.toJson();
    }
    return data;
  }
}

class Ar {
  num id;
  String name;

  Ar({this.id, this.name});

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Al {
  num id;
  String name;
  String picUrl;
  String picStr;
  num pic;

  Al({this.id, this.name, this.picUrl, this.picStr, this.pic});

  Al.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    picStr = json['pic_str'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    data['pic_str'] = this.picStr;
    data['pic'] = this.pic;
    return data;
  }
}

class H {
  num br;
  num fid;
  num size;
  num vd;

  H({this.br, this.fid, this.size, this.vd});

  H.fromJson(Map<String, dynamic> json) {
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

class Privilege {
  num id;
  num fee;
  num payed;
  num st;
  num pl;
  num dl;
  num sp;
  num cp;
  num subp;
  bool cs;
  num maxbr;
  num fl;
  bool toast;
  num flag;
  bool preSell;

  Privilege(
      {this.id,
        this.fee,
        this.payed,
        this.st,
        this.pl,
        this.dl,
        this.sp,
        this.cp,
        this.subp,
        this.cs,
        this.maxbr,
        this.fl,
        this.toast,
        this.flag,
        this.preSell});

  Privilege.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fee = json['fee'];
    payed = json['payed'];
    st = json['st'];
    pl = json['pl'];
    dl = json['dl'];
    sp = json['sp'];
    cp = json['cp'];
    subp = json['subp'];
    cs = json['cs'];
    maxbr = json['maxbr'];
    fl = json['fl'];
    toast = json['toast'];
    flag = json['flag'];
    preSell = json['preSell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fee'] = this.fee;
    data['payed'] = this.payed;
    data['st'] = this.st;
    data['pl'] = this.pl;
    data['dl'] = this.dl;
    data['sp'] = this.sp;
    data['cp'] = this.cp;
    data['subp'] = this.subp;
    data['cs'] = this.cs;
    data['maxbr'] = this.maxbr;
    data['fl'] = this.fl;
    data['toast'] = this.toast;
    data['flag'] = this.flag;
    data['preSell'] = this.preSell;
    return data;
  }
}
