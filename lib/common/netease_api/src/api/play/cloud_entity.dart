import 'package:bujuan/common/netease_api/src/api/bean.dart';

class CloudEntity extends ServerStatusBean{
  // int? code;
  List<CloudData>? data;
  String? size;
  num? upgradeSign;
  num? count;
  bool? hasMore;
  String? maxSize;

  CloudEntity(
      {
      this.data,
      this.size,
      this.upgradeSign,
      this.count,
      this.hasMore,
      this.maxSize});

  CloudEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <CloudData>[];
      for (var v in (json['data'] as List)) {
        (data??[]).add(CloudData.fromJson(v));
      }
    }
    size = json['size'];
    upgradeSign = json['upgradeSign'];
    count = json['count'];
    hasMore = json['hasMore'];
    maxSize = json['maxSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    if (this.data != null) {
      data['data'] = (this.data??[]).map((v) => v.toJson()).toList();
    }
    data['size'] = size;
    data['upgradeSign'] = upgradeSign;
    data['count'] = count;
    data['hasMore'] = hasMore;
    data['maxSize'] = maxSize;
    return data;
  }
}

class CloudData {
  String? songName;
  String? fileName;
  num? addTime;
  String? artist;
  String? album;
  String? lyricId;
  num? bitrate;
  CloudDataSimplesong? simpleSong;
  num? version;
  num? cover;
  String? coverId;
  num? fileSize;
  num? songId;

  CloudData(
      {this.songName,
      this.fileName,
      this.addTime,
      this.artist,
      this.album,
      this.lyricId,
      this.bitrate,
      this.simpleSong,
      this.version,
      this.cover,
      this.coverId,
      this.fileSize,
      this.songId});

  CloudData.fromJson(Map<String, dynamic> json) {
    songName = json['songName'];
    fileName = json['fileName'];
    addTime = json['addTime'];
    artist = json['artist'];
    album = json['album'];
    lyricId = json['lyricId'];
    bitrate = json['bitrate'];
    simpleSong = json['simpleSong'] != null
        ? CloudDataSimplesong.fromJson(json['simpleSong'])
        : null;
    version = json['version'];
    cover = json['cover'];
    coverId = json['coverId'];
    fileSize = json['fileSize'];
    songId = json['songId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['songName'] = songName;
    data['fileName'] = fileName;
    data['addTime'] = addTime;
    data['artist'] = artist;
    data['album'] = album;
    data['lyricId'] = lyricId;
    data['bitrate'] = bitrate;
    if (simpleSong != null) {
      data['simpleSong'] = simpleSong?.toJson();
    }
    data['version'] = version;
    data['cover'] = cover;
    data['coverId'] = coverId;
    data['fileSize'] = fileSize;
    data['songId'] = songId;
    return data;
  }
}

class CloudDataSimplesong {
  num? no;
  String? rt;
  num? copyright;
  num? fee;
  dynamic rurl;
  CloudDataSimplesongPrivilege? privilege;
  num? mst;
  num? pst;
  num? pop;
  int? dt;
  num? rtype;
  num? sId;
  num? id;
  num? st;
  dynamic a;
  String? cd;
  num? publishTime;
  String? cf;
  dynamic h;
  num? mv;
  CloudDataSimplesongAl? al;
  CloudDataSimplesongL? l;
  CloudDataSimplesongM? m;
  num? cp;
  num? djId;
  String? crbt;
  List<CloudDataSimplesongAr>? ar;
  dynamic rtUrl;
  num? ftype;
  num? t;
  num? v;
  String? name;

  CloudDataSimplesong(
      {this.no,
      this.rt,
      this.copyright,
      this.fee,
      this.rurl,
      this.privilege,
      this.mst,
      this.pst,
      this.pop,
      this.dt,
      this.rtype,
      this.sId,
      this.id,
      this.st,
      this.a,
      this.cd,
      this.publishTime,
      this.cf,
      this.h,
      this.mv,
      this.al,
      this.l,
      this.m,
      this.cp,
      this.djId,
      this.crbt,
      this.ar,
      this.rtUrl,
      this.ftype,
      this.t,
      this.v,
      this.name});

  CloudDataSimplesong.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    rt = json['rt'];
    copyright = json['copyright'];
    fee = json['fee'];
    rurl = json['rurl'];
    privilege = json['privilege'] != null
        ? CloudDataSimplesongPrivilege.fromJson(json['privilege'])
        : null;
    mst = json['mst'];
    pst = json['pst'];
    pop = json['pop'];
    dt = json['dt'];
    rtype = json['rtype'];
    sId = json['s_id'];
    id = json['id'];
    st = json['st'];
    a = json['a'];
    cd = json['cd'];
    publishTime = json['publishTime'];
    cf = json['cf'];
    h = json['h'];
    mv = json['mv'];
    al = json['al'] != null
        ? CloudDataSimplesongAl.fromJson(json['al'])
        : null;
    l = json['l'] != null ? CloudDataSimplesongL.fromJson(json['l']) : null;
    m = json['m'] != null ? CloudDataSimplesongM.fromJson(json['m']) : null;
    cp = json['cp'];
    djId = json['djId'];
    crbt = json['crbt'];
    if (json['ar'] != null) {
      ar = <CloudDataSimplesongAr>[];
      for (var v in (json['ar'] as List)) {
        (ar??[]).add(CloudDataSimplesongAr.fromJson(v));
      }
    }
    rtUrl = json['rtUrl'];
    ftype = json['ftype'];
    t = json['t'];
    v = json['v'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no'] = no;
    data['rt'] = rt;
    data['copyright'] = copyright;
    data['fee'] = fee;
    data['rurl'] = rurl;
    if (privilege != null) {
      data['privilege'] = privilege?.toJson();
    }
    data['mst'] = mst;
    data['pst'] = pst;
    data['pop'] = pop;
    data['dt'] = dt;
    data['rtype'] = rtype;
    data['s_id'] = sId;
    data['id'] = id;
    data['st'] = st;
    data['a'] = a;
    data['cd'] = cd;
    data['publishTime'] = publishTime;
    data['cf'] = cf;
    data['h'] = h;
    data['mv'] = mv;
    if (al != null) {
      data['al'] = al?.toJson();
    }
    if (l != null) {
      data['l'] = l?.toJson();
    }
    if (m != null) {
      data['m'] = m?.toJson();
    }
    data['cp'] = cp;
    data['djId'] = djId;
    data['crbt'] = crbt;
    if (ar != null) {
      data['ar'] = (ar??[]).map((v) => v.toJson()).toList();
    }
    data['rtUrl'] = rtUrl;
    data['ftype'] = ftype;
    data['t'] = t;
    data['v'] = v;
    data['name'] = name;
    return data;
  }
}

class CloudDataSimplesongPrivilege {
  num? st;
  num? flag;
  num? subp;
  num? fl;
  num? fee;
  num? dl;
  num? cp;
  bool? cs;
  bool? toast;
  num? maxbr;
  num? id;
  num? pl;
  num? sp;
  num? payed;

  CloudDataSimplesongPrivilege(
      {this.st,
      this.flag,
      this.subp,
      this.fl,
      this.fee,
      this.dl,
      this.cp,
      this.cs,
      this.toast,
      this.maxbr,
      this.id,
      this.pl,
      this.sp,
      this.payed});

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['st'] = st;
    data['flag'] = flag;
    data['subp'] = subp;
    data['fl'] = fl;
    data['fee'] = fee;
    data['dl'] = dl;
    data['cp'] = cp;
    data['cs'] = cs;
    data['toast'] = toast;
    data['maxbr'] = maxbr;
    data['id'] = id;
    data['pl'] = pl;
    data['sp'] = sp;
    data['payed'] = payed;
    return data;
  }
}

class CloudDataSimplesongAl {
  String? picUrl;
  String? name;
  num? id;
  num? pic;

  CloudDataSimplesongAl({this.picUrl, this.name, this.id, this.pic});

  CloudDataSimplesongAl.fromJson(Map<String, dynamic> json) {
    picUrl = json['picUrl'];
    name = json['name'];
    id = json['id'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['picUrl'] = picUrl;
    data['name'] = name;
    data['id'] = id;
    data['pic'] = pic;
    return data;
  }
}

class CloudDataSimplesongL {
  num? br;
  num? fid;
  num? size;
  double? vd;

  CloudDataSimplesongL({this.br, this.fid, this.size, this.vd});

  CloudDataSimplesongL.fromJson(Map<String, dynamic> json) {
    br = json['br'];
    fid = json['fid'];
    size = json['size'];
    vd = json['vd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    return data;
  }
}

class CloudDataSimplesongM {
  num? br;
  num? fid;
  num? size;
  double? vd;

  CloudDataSimplesongM({this.br, this.fid, this.size, this.vd});

  CloudDataSimplesongM.fromJson(Map<String, dynamic> json) {
    br = json['br'];
    fid = json['fid'];
    size = json['size'];
    vd = json['vd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['br'] = br;
    data['fid'] = fid;
    data['size'] = size;
    data['vd'] = vd;
    return data;
  }
}

class CloudDataSimplesongAr {
  String? name;
  num? id;

  CloudDataSimplesongAr({this.name, this.id});

  CloudDataSimplesongAr.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
