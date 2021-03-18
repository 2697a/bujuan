class SheetByClassify {
  List<Playlists> playlists;
  int total;
  int code;
  bool more;
  String cat;

  SheetByClassify({this.playlists, this.total, this.code, this.more, this.cat});

  SheetByClassify.fromJson(Map<String, dynamic> json) {
    if (json['playlists'] != null) {
      playlists = new List<Playlists>();
      json['playlists'].forEach((v) {
        playlists.add(new Playlists.fromJson(v));
      });
    }
    total = json['total'];
    code = json['code'];
    more = json['more'];
    cat = json['cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playlists != null) {
      data['playlists'] = this.playlists.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['code'] = this.code;
    data['more'] = this.more;
    data['cat'] = this.cat;
    return data;
  }
}

class Playlists {
  String name;
  int id;
  int trackNumberUpdateTime;
  int status;
  int userId;
  int createTime;
  int updateTime;
  int subscribedCount;
  int trackCount;
  int cloudTrackCount;
  String coverImgUrl;
  int coverImgId;
  String description;
  List<String> tags;
  int playCount;
  int trackUpdateTime;
  int specialType;
  int totalDuration;
  Creator creator;
  List<Subscribers> subscribers;
  bool subscribed;
  String commentThreadId;
  bool newImported;
  int adType;
  bool highQuality;
  int privacy;
  bool ordered;
  bool anonimous;
  int coverStatus;
  RecommendInfo recommendInfo;
  int shareCount;
  String coverImgIdStr;
  int commentCount;
  String alg;

  Playlists(
      {this.name,
        this.id,
        this.trackNumberUpdateTime,
        this.status,
        this.userId,
        this.createTime,
        this.updateTime,
        this.subscribedCount,
        this.trackCount,
        this.cloudTrackCount,
        this.coverImgUrl,
        this.coverImgId,
        this.description,
        this.tags,
        this.playCount,
        this.trackUpdateTime,
        this.specialType,
        this.totalDuration,
        this.creator,
        this.subscribers,
        this.subscribed,
        this.commentThreadId,
        this.newImported,
        this.adType,
        this.highQuality,
        this.privacy,
        this.ordered,
        this.anonimous,
        this.coverStatus,
        this.recommendInfo,
        this.shareCount,
        this.coverImgIdStr,
        this.commentCount,
        this.alg});

  Playlists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    trackNumberUpdateTime = json['trackNumberUpdateTime'];
    status = json['status'];
    userId = json['userId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    subscribedCount = json['subscribedCount'];
    trackCount = json['trackCount'];
    cloudTrackCount = json['cloudTrackCount'];
    coverImgUrl = json['coverImgUrl'];
    coverImgId = json['coverImgId'];
    description = json['description'];
    tags = json['tags'].cast<String>();
    playCount = json['playCount'];
    trackUpdateTime = json['trackUpdateTime'];
    specialType = json['specialType'];
    totalDuration = json['totalDuration'];
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['subscribers'] != null) {
      subscribers = new List<Subscribers>();
      json['subscribers'].forEach((v) {
        subscribers.add(new Subscribers.fromJson(v));
      });
    }
    subscribed = json['subscribed'];
    commentThreadId = json['commentThreadId'];
    newImported = json['newImported'];
    adType = json['adType'];
    highQuality = json['highQuality'];
    privacy = json['privacy'];
    ordered = json['ordered'];
    anonimous = json['anonimous'];
    coverStatus = json['coverStatus'];
    recommendInfo = json['recommendInfo'] != null
        ? new RecommendInfo.fromJson(json['recommendInfo'])
        : null;
    shareCount = json['shareCount'];
    coverImgIdStr = json['coverImgId_str'];
    commentCount = json['commentCount'];
    alg = json['alg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['trackNumberUpdateTime'] = this.trackNumberUpdateTime;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['subscribedCount'] = this.subscribedCount;
    data['trackCount'] = this.trackCount;
    data['cloudTrackCount'] = this.cloudTrackCount;
    data['coverImgUrl'] = this.coverImgUrl;
    data['coverImgId'] = this.coverImgId;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['playCount'] = this.playCount;
    data['trackUpdateTime'] = this.trackUpdateTime;
    data['specialType'] = this.specialType;
    data['totalDuration'] = this.totalDuration;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.subscribers != null) {
      data['subscribers'] = this.subscribers.map((v) => v.toJson()).toList();
    }
    data['subscribed'] = this.subscribed;
    data['commentThreadId'] = this.commentThreadId;
    data['newImported'] = this.newImported;
    data['adType'] = this.adType;
    data['highQuality'] = this.highQuality;
    data['privacy'] = this.privacy;
    data['ordered'] = this.ordered;
    data['anonimous'] = this.anonimous;
    data['coverStatus'] = this.coverStatus;
    if (this.recommendInfo != null) {
      data['recommendInfo'] = this.recommendInfo.toJson();
    }
    data['shareCount'] = this.shareCount;
    data['coverImgId_str'] = this.coverImgIdStr;
    data['commentCount'] = this.commentCount;
    data['alg'] = this.alg;
    return data;
  }
}

class Creator {
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
  AvatarDetail avatarDetail;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  bool anchor;

  Creator(
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
        this.anchor});

  Creator.fromJson(Map<String, dynamic> json) {
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
    avatarDetail = json['avatarDetail'] != null
        ? new AvatarDetail.fromJson(json['avatarDetail'])
        : null;
    avatarImgIdStr = json['avatarImgIdStr'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgId_str'];
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
    if (this.avatarDetail != null) {
      data['avatarDetail'] = this.avatarDetail.toJson();
    }
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['anchor'] = this.anchor;
    data['avatarImgId_str'] = this.avatarImgIdStr;
    return data;
  }
}

class AvatarDetail {
  int userType;
  int identityLevel;
  String identityIconUrl;

  AvatarDetail({this.userType, this.identityLevel, this.identityIconUrl});

  AvatarDetail.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    identityLevel = json['identityLevel'];
    identityIconUrl = json['identityIconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userType'] = this.userType;
    data['identityLevel'] = this.identityLevel;
    data['identityIconUrl'] = this.identityIconUrl;
    return data;
  }
}

class Subscribers {
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
  String avatarImgIdStr;
  String backgroundImgIdStr;
  bool anchor;

  Subscribers(
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
        this.avatarImgIdStr,
        this.backgroundImgIdStr,
        this.anchor});

  Subscribers.fromJson(Map<String, dynamic> json) {
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
    avatarImgIdStr = json['avatarImgIdStr'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgId_str'];
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
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['anchor'] = this.anchor;
    data['avatarImgId_str'] = this.avatarImgIdStr;
    return data;
  }
}

class RecommendInfo {
  String alg;
  String logInfo;

  RecommendInfo({this.alg, this.logInfo});

  RecommendInfo.fromJson(Map<String, dynamic> json) {
    alg = json['alg'];
    logInfo = json['logInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alg'] = this.alg;
    data['logInfo'] = this.logInfo;
    return data;
  }
}
