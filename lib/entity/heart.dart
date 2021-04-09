class Heart {
  int code;
  String message;
  List<Data> data;

  Heart({this.code, this.message, this.data});

  Heart.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String alg;
  bool recommended;
  SongInfo songInfo;

  Data({this.id, this.alg, this.recommended, this.songInfo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alg = json['alg'];
    recommended = json['recommended'];
    songInfo = json['songInfo'] != null
        ? new SongInfo.fromJson(json['songInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alg'] = this.alg;
    data['recommended'] = this.recommended;
    if (this.songInfo != null) {
      data['songInfo'] = this.songInfo.toJson();
    }
    return data;
  }
}

class SongInfo {
  int no;
  int copyright;
  String rt;
  int fee;
  Privilege privilege;
  int mst;
  int pst;
  num pop;
  int dt;
  int rtype;
  int sId;
  int id;
  int st;
  String cd;
  int publishTime;
  String cf;
  H h;
  int mv;
  Al al;
  H l;
  int cp;
  H m;
  int djId;
  List<String> alia;
  String crbt;
  List<Ar> ar;
  int ftype;
  int t;
  int v;
  String name;

  SongInfo(
      {this.no,
        this.copyright,
        this.rt,
        this.fee,
        this.privilege,
        this.mst,
        this.pst,
        this.pop,
        this.dt,
        this.rtype,
        this.sId,
        this.id,
        this.st,
        this.cd,
        this.publishTime,
        this.cf,
        this.h,
        this.mv,
        this.al,
        this.l,
        this.cp,
        this.m,
        this.djId,
        this.alia,
        this.crbt,
        this.ar,
        this.ftype,
        this.t,
        this.v,
        this.name});

  SongInfo.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    copyright = json['copyright'];
    rt = json['rt'];
    fee = json['fee'];
    privilege = json['privilege'] != null
        ? new Privilege.fromJson(json['privilege'])
        : null;
    mst = json['mst'];
    pst = json['pst'];
    pop = json['pop'];
    dt = json['dt'];
    rtype = json['rtype'];
    sId = json['s_id'];
    id = json['id'];
    st = json['st'];
    cd = json['cd'];
    publishTime = json['publishTime'];
    cf = json['cf'];
    h = json['h'] != null ? new H.fromJson(json['h']) : null;
    mv = json['mv'];
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
    l = json['l'] != null ? new H.fromJson(json['l']) : null;
    cp = json['cp'];
    m = json['m'] != null ? new H.fromJson(json['m']) : null;
    djId = json['djId'];
    alia = json['alia'].cast<String>();
    crbt = json['crbt'];
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }
    ftype = json['ftype'];
    t = json['t'];
    v = json['v'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['copyright'] = this.copyright;
    data['rt'] = this.rt;
    data['fee'] = this.fee;
    if (this.privilege != null) {
      data['privilege'] = this.privilege.toJson();
    }
    data['mst'] = this.mst;
    data['pst'] = this.pst;
    data['pop'] = this.pop;
    data['dt'] = this.dt;
    data['rtype'] = this.rtype;
    data['s_id'] = this.sId;
    data['id'] = this.id;
    data['st'] = this.st;
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
    data['cp'] = this.cp;
    if (this.m != null) {
      data['m'] = this.m.toJson();
    }
    data['djId'] = this.djId;
    data['alia'] = this.alia;
    data['crbt'] = this.crbt;
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }
    data['ftype'] = this.ftype;
    data['t'] = this.t;
    data['v'] = this.v;
    data['name'] = this.name;
    return data;
  }
}

class Privilege {
  int id;
  int fee;
  int payed;
  int st;
  int pl;
  int dl;
  int sp;
  int cp;
  int subp;
  bool cs;
  int maxbr;
  int fl;
  bool toast;
  int flag;
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

class H {
  int br;
  int fid;
  int size;
  double vd;

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

class Al {
  String picUrl;
  String name;
  List<String> tns;
  String picStr;
  int id;
  int pic;

  Al({this.picUrl, this.name, this.tns, this.picStr, this.id, this.pic});

  Al.fromJson(Map<String, dynamic> json) {
    picUrl = json['picUrl'];
    name = json['name'];
    tns = json['tns'].cast<String>();
    picStr = json['pic_str'];
    id = json['id'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picUrl'] = this.picUrl;
    data['name'] = this.name;
    data['tns'] = this.tns;
    data['pic_str'] = this.picStr;
    data['id'] = this.id;
    data['pic'] = this.pic;
    return data;
  }
}

class Ar {
  String name;
  int id;

  Ar({this.name, this.id});

  Ar.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
