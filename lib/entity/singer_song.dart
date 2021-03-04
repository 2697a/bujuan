class SingerSong {
  Artist artist;
  List<HotSongs> hotSongs;
  bool more;
  int code;

  SingerSong({this.artist, this.hotSongs, this.more, this.code});

  SingerSong.fromJson(Map<String, dynamic> json) {
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    if (json['hotSongs'] != null) {
      hotSongs = new List<HotSongs>();
      json['hotSongs'].forEach((v) {
        hotSongs.add(new HotSongs.fromJson(v));
      });
    }
    more = json['more'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    if (this.hotSongs != null) {
      data['hotSongs'] = this.hotSongs.map((v) => v.toJson()).toList();
    }
    data['more'] = this.more;
    data['code'] = this.code;
    return data;
  }
}

class Artist {
  int img1v1Id;
  int topicPerson;
  List<dynamic> alias;
  int musicSize;
  int albumSize;
  String briefDesc;
  int picId;
  bool followed;
  String img1v1Url;
  String trans;
  String picUrl;
  String name;
  int id;
  int publishTime;
  String picIdStr;
  String img1v1IdStr;
  int mvSize;

  Artist(
      {this.img1v1Id,
        this.topicPerson,
        this.alias,
        this.musicSize,
        this.albumSize,
        this.briefDesc,
        this.picId,
        this.followed,
        this.img1v1Url,
        this.trans,
        this.picUrl,
        this.name,
        this.id,
        this.publishTime,
        this.picIdStr,
        this.img1v1IdStr,
        this.mvSize});

  Artist.fromJson(Map<String, dynamic> json) {
    img1v1Id = json['img1v1Id'];
    topicPerson = json['topicPerson'];
    alias = json['alias'];
    musicSize = json['musicSize'];
    albumSize = json['albumSize'];
    briefDesc = json['briefDesc'];
    picId = json['picId'];
    followed = json['followed'];
    img1v1Url = json['img1v1Url'];
    trans = json['trans'];
    picUrl = json['picUrl'];
    name = json['name'];
    id = json['id'];
    publishTime = json['publishTime'];
    picIdStr = json['picId_str'];
    img1v1IdStr = json['img1v1Id_str'];
    mvSize = json['mvSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img1v1Id'] = this.img1v1Id;
    data['topicPerson'] = this.topicPerson;
    data['alias'] = this.alias;
    data['musicSize'] = this.musicSize;
    data['albumSize'] = this.albumSize;
    data['briefDesc'] = this.briefDesc;
    data['picId'] = this.picId;
    data['followed'] = this.followed;
    data['img1v1Url'] = this.img1v1Url;
    data['trans'] = this.trans;
    data['picUrl'] = this.picUrl;
    data['name'] = this.name;
    data['id'] = this.id;
    data['publishTime'] = this.publishTime;
    data['picId_str'] = this.picIdStr;
    data['img1v1Id_str'] = this.img1v1IdStr;
    data['mvSize'] = this.mvSize;
    return data;
  }
}

class HotSongs {
  List<Ar> ar;
  Al al;
  int mv;
  String name;
  int id;
  Privilege privilege;

  HotSongs(
      {
        this.ar,
        this.al,
        this.mv,
        this.name,
        this.id,
        this.privilege,});

  HotSongs.fromJson(Map<String, dynamic> json) {
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
    mv = json['mv'];
    name = json['name'];
    id = json['id'];
    privilege = json['privilege'] != null
        ? new Privilege.fromJson(json['privilege'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }
    if (this.al != null) {
      data['al'] = this.al.toJson();
    }
    data['mv'] = this.mv;
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.privilege != null) {
      data['privilege'] = this.privilege.toJson();
    }
    return data;
  }
}

class Ar {
  int id;
  String name;
  List<dynamic> alia;

  Ar({this.id, this.name, this.alia});

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alia = json['alia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alia'] = this.alia;
    return data;
  }
}

class Al {
  int id;
  String name;
  String picUrl;
  String picStr;
  int pic;

  Al(
      {this.id,
        this.name,
        this.picUrl,
        this.picStr,
        this.pic,});

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
  int playMaxbr;
  int downloadMaxbr;

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
        this.preSell,
        this.playMaxbr,
        this.downloadMaxbr});

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
    playMaxbr = json['playMaxbr'];
    downloadMaxbr = json['downloadMaxbr'];
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
    data['playMaxbr'] = this.playMaxbr;
    data['downloadMaxbr'] = this.downloadMaxbr;
    return data;
  }
}