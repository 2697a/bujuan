class SongTalkEntity {
  List<Null> topComments;
  num total;
  num code;
  List<SongTalkCommants> comments;
  List<SongTalkHotcommants> hotComments;
  bool more;
  num userId;
  bool moreHot;
  bool isMusician;

  SongTalkEntity(
      {this.topComments,
      this.total,
      this.code,
      this.comments,
      this.hotComments,
      this.more,
      this.userId,
      this.moreHot,
      this.isMusician});

  SongTalkEntity.fromJson(Map<String, dynamic> json) {
    if (json['topComments'] != null) {
      topComments = new List<Null>();
    }
    total = json['total'];
    code = json['code'];
    if (json['comments'] != null) {
      comments = new List<SongTalkCommants>();
      (json['comments'] as List).forEach((v) {
        comments.add(new SongTalkCommants.fromJson(v));
      });
    }
    if (json['hotComments'] != null) {
      hotComments = new List<SongTalkHotcommants>();
      (json['hotComments'] as List).forEach((v) {
        hotComments.add(new SongTalkHotcommants.fromJson(v));
      });
    }
    more = json['more'];
    userId = json['userId'];
    moreHot = json['moreHot'];
    isMusician = json['isMusician'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topComments != null) {
      data['topComments'] = [];
    }
    data['total'] = this.total;
    data['code'] = this.code;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    if (this.hotComments != null) {
      data['hotComments'] = this.hotComments.map((v) => v.toJson()).toList();
    }
    data['more'] = this.more;
    data['userId'] = this.userId;
    data['moreHot'] = this.moreHot;
    data['isMusician'] = this.isMusician;
    return data;
  }
}

class SongTalkCommants {
  dynamic showFloorComment;
  List<Null> beReplied;
  bool repliedMark;
  num parentCommentId;
  num likedCount;
  num commentLocationType;
  String content;
  bool liked;
  num commentId;
  num time;
  SongTalkCommentsUser user;
  dynamic expressionUrl;
  SongTalkCommentsPendantdata pendantData;
  num status;

  SongTalkCommants(
      {this.showFloorComment,
      this.beReplied,
      this.repliedMark,
      this.parentCommentId,
      this.likedCount,
      this.commentLocationType,
      this.content,
      this.liked,
      this.commentId,
      this.time,
      this.user,
      this.expressionUrl,
      this.pendantData,
      this.status});

  SongTalkCommants.fromJson(Map<String, dynamic> json) {
    showFloorComment = json['showFloorComment'];
    if (json['beReplied'] != null) {
      beReplied = new List<Null>();
    }
    repliedMark = json['repliedMark'];
    parentCommentId = json['parentCommentId'];
    likedCount = json['likedCount'];
    commentLocationType = json['commentLocationType'];
    content = json['content'];
    liked = json['liked'];
    commentId = json['commentId'];
    time = json['time'];
    user = json['user'] != null
        ? new SongTalkCommentsUser.fromJson(json['user'])
        : null;
    expressionUrl = json['expressionUrl'];
    pendantData = json['pendantData'] != null
        ? new SongTalkCommentsPendantdata.fromJson(json['pendantData'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showFloorComment'] = this.showFloorComment;
    if (this.beReplied != null) {
      data['beReplied'] = [];
    }
    data['repliedMark'] = this.repliedMark;
    data['parentCommentId'] = this.parentCommentId;
    data['likedCount'] = this.likedCount;
    data['commentLocationType'] = this.commentLocationType;
    data['content'] = this.content;
    data['liked'] = this.liked;
    data['commentId'] = this.commentId;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['expressionUrl'] = this.expressionUrl;
    if (this.pendantData != null) {
      data['pendantData'] = this.pendantData.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class SongTalkCommentsUser {
  dynamic liveInfo;
  SongTalkCommentsUserViprights vipRights;
  dynamic locationInfo;
  String avatarUrl;
  num authStatus;
  String nickname;
  num vipType;
  dynamic expertTags;
  dynamic remarkName;
  num userType;
  dynamic experts;
  num userId;

  SongTalkCommentsUser(
      {this.liveInfo,
      this.vipRights,
      this.locationInfo,
      this.avatarUrl,
      this.authStatus,
      this.nickname,
      this.vipType,
      this.expertTags,
      this.remarkName,
      this.userType,
      this.experts,
      this.userId});

  SongTalkCommentsUser.fromJson(Map<String, dynamic> json) {
    liveInfo = json['liveInfo'];
    vipRights = json['vipRights'] != null
        ? new SongTalkCommentsUserViprights.fromJson(json['vipRights'])
        : null;
    locationInfo = json['locationInfo'];
    avatarUrl = json['avatarUrl'];
    authStatus = json['authStatus'];
    nickname = json['nickname'];
    vipType = json['vipType'];
    expertTags = json['expertTags'];
    remarkName = json['remarkName'];
    userType = json['userType'];
    experts = json['experts'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liveInfo'] = this.liveInfo;
    if (this.vipRights != null) {
      data['vipRights'] = this.vipRights.toJson();
    }
    data['locationInfo'] = this.locationInfo;
    data['avatarUrl'] = this.avatarUrl;
    data['authStatus'] = this.authStatus;
    data['nickname'] = this.nickname;
    data['vipType'] = this.vipType;
    data['expertTags'] = this.expertTags;
    data['remarkName'] = this.remarkName;
    data['userType'] = this.userType;
    data['experts'] = this.experts;
    data['userId'] = this.userId;
    return data;
  }
}

class SongTalkCommentsUserViprights {
  num redVipAnnualCount;
  SongTalkCommentsUserViprightsAssociator associator;
  dynamic musicPackage;

  SongTalkCommentsUserViprights(
      {this.redVipAnnualCount, this.associator, this.musicPackage});

  SongTalkCommentsUserViprights.fromJson(Map<String, dynamic> json) {
    redVipAnnualCount = json['redVipAnnualCount'];
    associator = json['associator'] != null
        ? new SongTalkCommentsUserViprightsAssociator.fromJson(
            json['associator'])
        : null;
    musicPackage = json['musicPackage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redVipAnnualCount'] = this.redVipAnnualCount;
    if (this.associator != null) {
      data['associator'] = this.associator.toJson();
    }
    data['musicPackage'] = this.musicPackage;
    return data;
  }
}

class SongTalkCommentsUserViprightsAssociator {
  bool rights;
  num vipCode;

  SongTalkCommentsUserViprightsAssociator({this.rights, this.vipCode});

  SongTalkCommentsUserViprightsAssociator.fromJson(Map<String, dynamic> json) {
    rights = json['rights'];
    vipCode = json['vipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rights'] = this.rights;
    data['vipCode'] = this.vipCode;
    return data;
  }
}

class SongTalkCommentsPendantdata {
  String imageUrl;
  num id;

  SongTalkCommentsPendantdata({this.imageUrl, this.id});

  SongTalkCommentsPendantdata.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}

class SongTalkHotcommants {
  dynamic showFloorComment;
  List<Null> beReplied;
  bool repliedMark;
  num parentCommentId;
  num likedCount;
  num commentLocationType;
  String content;
  bool liked;
  num commentId;
  num time;
  SongTalkHotcommentsUser user;
  dynamic decoration;
  dynamic expressionUrl;
  SongTalkHotcommentsPendantdata pendantData;
  num status;

  SongTalkHotcommants(
      {this.showFloorComment,
      this.beReplied,
      this.repliedMark,
      this.parentCommentId,
      this.likedCount,
      this.commentLocationType,
      this.content,
      this.liked,
      this.commentId,
      this.time,
      this.user,
      this.decoration,
      this.expressionUrl,
      this.pendantData,
      this.status});

  SongTalkHotcommants.fromJson(Map<String, dynamic> json) {
    showFloorComment = json['showFloorComment'];
    if (json['beReplied'] != null) {
      beReplied = new List<Null>();
    }
    repliedMark = json['repliedMark'];
    parentCommentId = json['parentCommentId'];
    likedCount = json['likedCount'];
    commentLocationType = json['commentLocationType'];
    content = json['content'];
    liked = json['liked'];
    commentId = json['commentId'];
    time = json['time'];
    user = json['user'] != null
        ? new SongTalkHotcommentsUser.fromJson(json['user'])
        : null;
    decoration = json['decoration'];
    expressionUrl = json['expressionUrl'];
    pendantData = json['pendantData'] != null
        ? new SongTalkHotcommentsPendantdata.fromJson(json['pendantData'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showFloorComment'] = this.showFloorComment;
    if (this.beReplied != null) {
      data['beReplied'] = [];
    }
    data['repliedMark'] = this.repliedMark;
    data['parentCommentId'] = this.parentCommentId;
    data['likedCount'] = this.likedCount;
    data['commentLocationType'] = this.commentLocationType;
    data['content'] = this.content;
    data['liked'] = this.liked;
    data['commentId'] = this.commentId;
    data['time'] = this.time;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['decoration'] = this.decoration;
    data['expressionUrl'] = this.expressionUrl;
    if (this.pendantData != null) {
      data['pendantData'] = this.pendantData.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class SongTalkHotcommentsUser {
  dynamic liveInfo;
  dynamic vipRights;
  dynamic locationInfo;
  String avatarUrl;
  num authStatus;
  String nickname;
  num vipType;
  dynamic expertTags;
  dynamic remarkName;
  num userType;
  dynamic experts;
  num userId;

  SongTalkHotcommentsUser(
      {this.liveInfo,
      this.vipRights,
      this.locationInfo,
      this.avatarUrl,
      this.authStatus,
      this.nickname,
      this.vipType,
      this.expertTags,
      this.remarkName,
      this.userType,
      this.experts,
      this.userId});

  SongTalkHotcommentsUser.fromJson(Map<String, dynamic> json) {
    liveInfo = json['liveInfo'];
    vipRights = json['vipRights'];
    locationInfo = json['locationInfo'];
    avatarUrl = json['avatarUrl'];
    authStatus = json['authStatus'];
    nickname = json['nickname'];
    vipType = json['vipType'];
    expertTags = json['expertTags'];
    remarkName = json['remarkName'];
    userType = json['userType'];
    experts = json['experts'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liveInfo'] = this.liveInfo;
    data['vipRights'] = this.vipRights;
    data['locationInfo'] = this.locationInfo;
    data['avatarUrl'] = this.avatarUrl;
    data['authStatus'] = this.authStatus;
    data['nickname'] = this.nickname;
    data['vipType'] = this.vipType;
    data['expertTags'] = this.expertTags;
    data['remarkName'] = this.remarkName;
    data['userType'] = this.userType;
    data['experts'] = this.experts;
    data['userId'] = this.userId;
    return data;
  }
}

class SongTalkHotcommentsPendantdata {
  String imageUrl;
  num id;

  SongTalkHotcommentsPendantdata({this.imageUrl, this.id});

  SongTalkHotcommentsPendantdata.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}
