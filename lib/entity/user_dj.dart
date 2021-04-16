class UserDj {
  int count;
  List<DjRadios> djRadios;
  int time;
  bool hasMore;
  int code;

  UserDj({this.count, this.djRadios, this.time, this.hasMore, this.code});

  UserDj.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['djRadios'] != null) {
      djRadios = new List<DjRadios>();
      json['djRadios'].forEach((v) {
        djRadios.add(new DjRadios.fromJson(v));
      });
    }
    time = json['time'];
    hasMore = json['hasMore'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.djRadios != null) {
      data['djRadios'] = this.djRadios.map((v) => v.toJson()).toList();
    }
    data['time'] = this.time;
    data['hasMore'] = this.hasMore;
    data['code'] = this.code;
    return data;
  }
}

class DjRadios {
  Dj dj;
  String category;
  bool buyed;
  int price;
  int originalPrice;
  int purchaseCount;
  String lastProgramName;
  bool finished;
  bool underShelf;
  int playCount;
  bool privacy;
  int programCount;
  int createTime;
  int categoryId;
  int picId;
  int subCount;
  int lastProgramCreateTime;
  int radioFeeType;
  int lastProgramId;
  int feeScope;
  String picUrl;
  String desc;
  String name;
  int id;
  String rcmdtext;
  int newProgramCount;

  DjRadios(
      {this.dj,
        this.category,
        this.buyed,
        this.price,
        this.originalPrice,
        this.purchaseCount,
        this.lastProgramName,
        this.finished,
        this.underShelf,
        this.playCount,
        this.privacy,
        this.programCount,
        this.createTime,
        this.categoryId,
        this.picId,
        this.subCount,
        this.lastProgramCreateTime,
        this.radioFeeType,
        this.lastProgramId,
        this.feeScope,
        this.picUrl,
        this.desc,
        this.name,
        this.id,
        this.rcmdtext,
        this.newProgramCount});

  DjRadios.fromJson(Map<String, dynamic> json) {
    dj = json['dj'] != null ? new Dj.fromJson(json['dj']) : null;
    category = json['category'];
    buyed = json['buyed'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    purchaseCount = json['purchaseCount'];
    lastProgramName = json['lastProgramName'];
    finished = json['finished'];
    underShelf = json['underShelf'];
    playCount = json['playCount'];
    privacy = json['privacy'];
    programCount = json['programCount'];
    createTime = json['createTime'];
    categoryId = json['categoryId'];
    picId = json['picId'];
    subCount = json['subCount'];
    lastProgramCreateTime = json['lastProgramCreateTime'];
    radioFeeType = json['radioFeeType'];
    lastProgramId = json['lastProgramId'];
    feeScope = json['feeScope'];
    picUrl = json['picUrl'];
    desc = json['desc'];
    name = json['name'];
    id = json['id'];
    rcmdtext = json['rcmdtext'];
    newProgramCount = json['newProgramCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dj != null) {
      data['dj'] = this.dj.toJson();
    }
    data['category'] = this.category;
    data['buyed'] = this.buyed;
    data['price'] = this.price;
    data['originalPrice'] = this.originalPrice;
    data['purchaseCount'] = this.purchaseCount;
    data['lastProgramName'] = this.lastProgramName;
    data['finished'] = this.finished;
    data['underShelf'] = this.underShelf;
    data['playCount'] = this.playCount;
    data['privacy'] = this.privacy;
    data['programCount'] = this.programCount;
    data['createTime'] = this.createTime;
    data['categoryId'] = this.categoryId;
    data['picId'] = this.picId;
    data['subCount'] = this.subCount;
    data['lastProgramCreateTime'] = this.lastProgramCreateTime;
    data['radioFeeType'] = this.radioFeeType;
    data['lastProgramId'] = this.lastProgramId;
    data['feeScope'] = this.feeScope;
    data['picUrl'] = this.picUrl;
    data['desc'] = this.desc;
    data['name'] = this.name;
    data['id'] = this.id;
    data['rcmdtext'] = this.rcmdtext;
    data['newProgramCount'] = this.newProgramCount;
    return data;
  }
}

class Dj {
  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  int avatarImgId;
  int backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  int djStatus;
  int vipType;
  int authenticationTypes;
  Null avatarDetail;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  bool anchor;

  Dj(
      {this.defaultAvatar,
        this.province,
        this.authStatus,
        this.followed,
        this.avatarUrl,
        this.accountStatus,
        this.gender,
        this.city,
        this.birthday,
        this.userId,
        this.userType,
        this.nickname,
        this.signature,
        this.description,
        this.detailDescription,
        this.avatarImgId,
        this.backgroundImgId,
        this.backgroundUrl,
        this.authority,
        this.mutual,
        this.djStatus,
        this.vipType,
        this.authenticationTypes,
        this.avatarDetail,
        this.avatarImgIdStr,
        this.backgroundImgIdStr,
        this.anchor,});

  Dj.fromJson(Map<String, dynamic> json) {
    defaultAvatar = json['defaultAvatar'];
    province = json['province'];
    authStatus = json['authStatus'];
    followed = json['followed'];
    avatarUrl = json['avatarUrl'];
    accountStatus = json['accountStatus'];
    gender = json['gender'];
    city = json['city'];
    birthday = json['birthday'];
    userId = json['userId'];
    userType = json['userType'];
    nickname = json['nickname'];
    signature = json['signature'];
    description = json['description'];
    detailDescription = json['detailDescription'];
    avatarImgId = json['avatarImgId'];
    backgroundImgId = json['backgroundImgId'];
    backgroundUrl = json['backgroundUrl'];
    authority = json['authority'];
    mutual = json['mutual'];
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    authenticationTypes = json['authenticationTypes'];
    avatarDetail = json['avatarDetail'];
    avatarImgIdStr = json['avatarImgIdStr']??json['avatarImgId_str'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    anchor = json['anchor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultAvatar'] = this.defaultAvatar;
    data['province'] = this.province;
    data['authStatus'] = this.authStatus;
    data['followed'] = this.followed;
    data['avatarUrl'] = this.avatarUrl;
    data['accountStatus'] = this.accountStatus;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['birthday'] = this.birthday;
    data['userId'] = this.userId;
    data['userType'] = this.userType;
    data['nickname'] = this.nickname;
    data['signature'] = this.signature;
    data['description'] = this.description;
    data['detailDescription'] = this.detailDescription;
    data['avatarImgId'] = this.avatarImgId;
    data['backgroundImgId'] = this.backgroundImgId;
    data['backgroundUrl'] = this.backgroundUrl;
    data['authority'] = this.authority;
    data['mutual'] = this.mutual;
    data['djStatus'] = this.djStatus;
    data['vipType'] = this.vipType;
    data['authenticationTypes'] = this.authenticationTypes;
    data['avatarDetail'] = this.avatarDetail;
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['anchor'] = this.anchor;
    data['avatarImgId_str'] = this.avatarImgIdStr;
    return data;
  }
}
