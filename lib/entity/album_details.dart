class AlbumDetails {
  bool resourceState;
  List<Songs> songs;
  int code;
  Album album;

  AlbumDetails({this.resourceState, this.songs, this.code, this.album});

  AlbumDetails.fromJson(Map<String, dynamic> json) {
    resourceState = json['resourceState'];
    if (json['songs'] != null) {
      songs = new List<Songs>();
      json['songs'].forEach((v) {
        songs.add(new Songs.fromJson(v));
      });
    }
    code = json['code'];
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceState'] = this.resourceState;
    if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    return data;
  }
}

class Songs {
  List<Ar> ar;
  Al al;
  int st;
  int mst;
  String cf;
  H h;
  int dt;
  String cd;
  int djId;
  int no;
  int fee;
  int v;
  int mv;
  int cp;
  String rt;
  H l;
  int rtype;
  double pop;
  int ftype;
  int t;
  int pst;
  H m;
  String name;
  int id;
  Privilege privilege;

  Songs(
      {
        this.ar,
        this.al,
        this.st,
        this.mst,
        this.cf,
        this.h,
        this.dt,
        this.cd,
        this.djId,
        this.no,
        this.fee,
        this.v,
        this.mv,
        this.cp,
        this.rt,
        this.l,
        this.rtype,
        this.pop,
        this.ftype,
        this.t,
        this.pst,
        this.m,
        this.name,
        this.id,
        this.privilege});

  Songs.fromJson(Map<String, dynamic> json) {
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
    st = json['st'];
    mst = json['mst'];
    cf = json['cf'];
    h = json['h'] != null ? new H.fromJson(json['h']) : null;
    dt = json['dt'];
    cd = json['cd'];
    djId = json['djId'];
    no = json['no'];
    fee = json['fee'];
    v = json['v'];
    mv = json['mv'];
    cp = json['cp'];
    rt = json['rt'];
    l = json['l'] != null ? new H.fromJson(json['l']) : null;
    rtype = json['rtype'];
    pop = json['pop'];
    ftype = json['ftype'];
    t = json['t'];
    pst = json['pst'];
    m = json['m'] != null ? new H.fromJson(json['m']) : null;
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
    data['st'] = this.st;
    data['mst'] = this.mst;
    data['cf'] = this.cf;
    if (this.h != null) {
      data['h'] = this.h.toJson();
    }
    data['dt'] = this.dt;
    data['cd'] = this.cd;
    data['djId'] = this.djId;
    data['no'] = this.no;
    data['fee'] = this.fee;
    data['v'] = this.v;
    data['mv'] = this.mv;
    data['cp'] = this.cp;
    data['rt'] = this.rt;
    if (this.l != null) {
      data['l'] = this.l.toJson();
    }
    data['rtype'] = this.rtype;
    data['pop'] = this.pop;
    data['ftype'] = this.ftype;
    data['t'] = this.t;
    data['pst'] = this.pst;
    if (this.m != null) {
      data['m'] = this.m.toJson();
    }
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
  int id;
  String name;
  String picUrl;
  String picStr;
  int pic;

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
  Null rscl;
  FreeTrialPrivilege freeTrialPrivilege;
  List<ChargeInfoList> chargeInfoList;

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
        this.downloadMaxbr,
        this.rscl,
        this.freeTrialPrivilege,
        this.chargeInfoList});

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
    rscl = json['rscl'];
    freeTrialPrivilege = json['freeTrialPrivilege'] != null
        ? new FreeTrialPrivilege.fromJson(json['freeTrialPrivilege'])
        : null;
    if (json['chargeInfoList'] != null) {
      chargeInfoList = new List<ChargeInfoList>();
      json['chargeInfoList'].forEach((v) {
        chargeInfoList.add(new ChargeInfoList.fromJson(v));
      });
    }
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
    data['rscl'] = this.rscl;
    if (this.freeTrialPrivilege != null) {
      data['freeTrialPrivilege'] = this.freeTrialPrivilege.toJson();
    }
    if (this.chargeInfoList != null) {
      data['chargeInfoList'] =
          this.chargeInfoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FreeTrialPrivilege {
  bool resConsumable;
  bool userConsumable;

  FreeTrialPrivilege({this.resConsumable, this.userConsumable});

  FreeTrialPrivilege.fromJson(Map<String, dynamic> json) {
    resConsumable = json['resConsumable'];
    userConsumable = json['userConsumable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resConsumable'] = this.resConsumable;
    data['userConsumable'] = this.userConsumable;
    return data;
  }
}

class ChargeInfoList {
  int rate;
  int chargeType;

  ChargeInfoList(
      {this.rate,  this.chargeType});

  ChargeInfoList.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    chargeType = json['chargeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['chargeType'] = this.chargeType;
    return data;
  }
}

class Album {
  bool paid;
  bool onSale;
  int mark;
  String picUrl;
  List<Artists> artists;
  int copyrightId;
  int picId;
  Artist artist;
  int publishTime;
  String company;
  String briefDesc;
  String commentThreadId;
  int pic;
  String blurPicUrl;
  int companyId;
  String description;
  String tags;
  int status;
  String subType;
  String name;
  int id;
  String type;
  int size;
  String picIdStr;
  Info info;

  Album(
      {
        this.paid,
        this.onSale,
        this.mark,
        this.picUrl,
        this.artists,
        this.copyrightId,
        this.picId,
        this.artist,
        this.publishTime,
        this.company,
        this.briefDesc,
        this.commentThreadId,
        this.pic,
        this.blurPicUrl,
        this.companyId,
        this.description,
        this.tags,
        this.status,
        this.subType,
        this.name,
        this.id,
        this.type,
        this.size,
        this.picIdStr,
        this.info});

  Album.fromJson(Map<String, dynamic> json) {
    paid = json['paid'];
    onSale = json['onSale'];
    mark = json['mark'];
    picUrl = json['picUrl'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    copyrightId = json['copyrightId'];
    picId = json['picId'];
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    publishTime = json['publishTime'];
    company = json['company'];
    briefDesc = json['briefDesc'];
    commentThreadId = json['commentThreadId'];
    pic = json['pic'];
    blurPicUrl = json['blurPicUrl'];
    companyId = json['companyId'];
    description = json['description'];
    tags = json['tags'];
    status = json['status'];
    subType = json['subType'];
    name = json['name'];
    id = json['id'];
    type = json['type'];
    size = json['size'];
    picIdStr = json['picId_str'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paid'] = this.paid;
    data['onSale'] = this.onSale;
    data['mark'] = this.mark;
    data['picUrl'] = this.picUrl;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['copyrightId'] = this.copyrightId;
    data['picId'] = this.picId;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    data['publishTime'] = this.publishTime;
    data['company'] = this.company;
    data['briefDesc'] = this.briefDesc;
    data['commentThreadId'] = this.commentThreadId;
    data['pic'] = this.pic;
    data['blurPicUrl'] = this.blurPicUrl;
    data['companyId'] = this.companyId;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['subType'] = this.subType;
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    data['size'] = this.size;
    data['picId_str'] = this.picIdStr;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Artists {
  int img1v1Id;
  int topicPerson;
  String picUrl;
  int picId;
  String trans;
  int musicSize;
  int albumSize;
  String briefDesc;
  bool followed;
  String img1v1Url;
  String name;
  int id;
  String img1v1IdStr;

  Artists(
      {this.img1v1Id,
        this.topicPerson,
        this.picUrl,
        this.picId,
        this.trans,
        this.musicSize,
        this.albumSize,
        this.briefDesc,
        this.followed,
        this.img1v1Url,
        this.name,
        this.id,
        this.img1v1IdStr});

  Artists.fromJson(Map<String, dynamic> json) {
    img1v1Id = json['img1v1Id'];
    topicPerson = json['topicPerson'];
    picUrl = json['picUrl'];
    picId = json['picId'];
    trans = json['trans'];
    musicSize = json['musicSize'];
    albumSize = json['albumSize'];
    briefDesc = json['briefDesc'];
    followed = json['followed'];
    img1v1Url = json['img1v1Url'];
    name = json['name'];
    id = json['id'];
    img1v1IdStr = json['img1v1Id_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img1v1Id'] = this.img1v1Id;
    data['topicPerson'] = this.topicPerson;
    data['picUrl'] = this.picUrl;
    data['picId'] = this.picId;
    data['trans'] = this.trans;
    data['musicSize'] = this.musicSize;
    data['albumSize'] = this.albumSize;
    data['briefDesc'] = this.briefDesc;
    data['followed'] = this.followed;
    data['img1v1Url'] = this.img1v1Url;
    data['name'] = this.name;
    data['id'] = this.id;
    data['img1v1Id_str'] = this.img1v1IdStr;
    return data;
  }
}

class Artist {
  int img1v1Id;
  int topicPerson;
  String picUrl;
  int picId;
  String trans;
  int musicSize;
  int albumSize;
  String briefDesc;
  bool followed;
  String img1v1Url;
  String name;
  int id;
  String picIdStr;
  String img1v1IdStr;

  Artist(
      {this.img1v1Id,
        this.topicPerson,
        this.picUrl,
        this.picId,
        this.trans,
        this.musicSize,
        this.albumSize,
        this.briefDesc,
        this.followed,
        this.img1v1Url,
        this.name,
        this.id,
        this.picIdStr,
        this.img1v1IdStr});

  Artist.fromJson(Map<String, dynamic> json) {
    img1v1Id = json['img1v1Id'];
    topicPerson = json['topicPerson'];
    picUrl = json['picUrl'];
    picId = json['picId'];
    trans = json['trans'];
    musicSize = json['musicSize'];
    albumSize = json['albumSize'];
    briefDesc = json['briefDesc'];
    followed = json['followed'];
    img1v1Url = json['img1v1Url'];
    name = json['name'];
    id = json['id'];
    picIdStr = json['picId_str'];
    img1v1IdStr = json['img1v1Id_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img1v1Id'] = this.img1v1Id;
    data['topicPerson'] = this.topicPerson;
    data['picUrl'] = this.picUrl;
    data['picId'] = this.picId;
    data['trans'] = this.trans;
    data['musicSize'] = this.musicSize;
    data['albumSize'] = this.albumSize;
    data['briefDesc'] = this.briefDesc;
    data['followed'] = this.followed;
    data['img1v1Url'] = this.img1v1Url;
    data['name'] = this.name;
    data['id'] = this.id;
    data['picId_str'] = this.picIdStr;
    data['img1v1Id_str'] = this.img1v1IdStr;
    return data;
  }
}

class Info {
  CommentThread commentThread;
  bool liked;
  int resourceType;
  int resourceId;
  int commentCount;
  int likedCount;
  int shareCount;
  String threadId;

  Info(
      {this.commentThread,
        this.liked,
        this.resourceType,
        this.resourceId,
        this.commentCount,
        this.likedCount,
        this.shareCount,
        this.threadId});

  Info.fromJson(Map<String, dynamic> json) {
    commentThread = json['commentThread'] != null
        ? new CommentThread.fromJson(json['commentThread'])
        : null;
    liked = json['liked'];
    resourceType = json['resourceType'];
    resourceId = json['resourceId'];
    commentCount = json['commentCount'];
    likedCount = json['likedCount'];
    shareCount = json['shareCount'];
    threadId = json['threadId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentThread != null) {
      data['commentThread'] = this.commentThread.toJson();
    }
    data['liked'] = this.liked;
    data['resourceType'] = this.resourceType;
    data['resourceId'] = this.resourceId;
    data['commentCount'] = this.commentCount;
    data['likedCount'] = this.likedCount;
    data['shareCount'] = this.shareCount;
    data['threadId'] = this.threadId;
    return data;
  }
}

class CommentThread {
  String id;
  ResourceInfo resourceInfo;
  int resourceType;
  int commentCount;
  int likedCount;
  int shareCount;
  int hotCount;
  int resourceId;
  int resourceOwnerId;
  String resourceTitle;

  CommentThread(
      {this.id,
        this.resourceInfo,
        this.resourceType,
        this.commentCount,
        this.likedCount,
        this.shareCount,
        this.hotCount,
        this.resourceId,
        this.resourceOwnerId,
        this.resourceTitle});

  CommentThread.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceInfo = json['resourceInfo'] != null
        ? new ResourceInfo.fromJson(json['resourceInfo'])
        : null;
    resourceType = json['resourceType'];
    commentCount = json['commentCount'];
    likedCount = json['likedCount'];
    shareCount = json['shareCount'];
    hotCount = json['hotCount'];
    resourceId = json['resourceId'];
    resourceOwnerId = json['resourceOwnerId'];
    resourceTitle = json['resourceTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.resourceInfo != null) {
      data['resourceInfo'] = this.resourceInfo.toJson();
    }
    data['resourceType'] = this.resourceType;
    data['commentCount'] = this.commentCount;
    data['likedCount'] = this.likedCount;
    data['shareCount'] = this.shareCount;
    data['hotCount'] = this.hotCount;
    data['resourceId'] = this.resourceId;
    data['resourceOwnerId'] = this.resourceOwnerId;
    data['resourceTitle'] = this.resourceTitle;
    return data;
  }
}

class ResourceInfo {
  int id;
  int userId;
  String name;
  String imgUrl;

  ResourceInfo(
      {this.id,
        this.userId,
        this.name,
        this.imgUrl,});

  ResourceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}
