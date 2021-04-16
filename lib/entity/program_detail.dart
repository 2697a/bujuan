class ProgramDetail {
  Program program;
  int code;

  ProgramDetail({this.program, this.code});

  ProgramDetail.fromJson(Map<String, dynamic> json) {
    program =
    json['program'] != null ? new Program.fromJson(json['program']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.program != null) {
      data['program'] = this.program.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Program {
  String blurCoverUrl;
  int duration;
  bool buyed;
  bool canReward;
  int auditStatus;
  int score;
  int auditDisPlayStatus;
  String categoryName;
  String secondCategoryName;
  int trackCount;
  bool isPublish;
  int createTime;
  int categoryId;
  String coverUrl;
  int secondCategoryId;
  int scheduledPublishTime;
  int serialNum;
  int listenerCount;
  int feeScope;
  int programFeeType;
  int pubStatus;
  int subscribedCount;
  bool reward;
  int bdAuditStatus;
  int mainTrackId;
  int smallLanguageAuditStatus;
  String commentThreadId;
  bool privacy;
  String description;
  String name;
  int id;
  bool subscribed;
  int shareCount;
  int likedCount;
  int commentCount;

  Program(
      {
        this.blurCoverUrl,
        this.duration,
        this.buyed,
        this.canReward,
        this.auditStatus,
        this.score,
        this.auditDisPlayStatus,
        this.categoryName,
        this.secondCategoryName,
        this.trackCount,
        this.isPublish,
        this.createTime,
        this.categoryId,
        this.coverUrl,
        this.secondCategoryId,
        this.scheduledPublishTime,
        this.serialNum,
        this.listenerCount,
        this.feeScope,
        this.programFeeType,
        this.pubStatus,
        this.subscribedCount,
        this.reward,
        this.bdAuditStatus,
        this.mainTrackId,
        this.smallLanguageAuditStatus,
        this.commentThreadId,
        this.privacy,
        this.description,
        this.name,
        this.id,
        this.subscribed,
        this.shareCount,
        this.likedCount,
        this.commentCount});

  Program.fromJson(Map<String, dynamic> json) {
    blurCoverUrl = json['blurCoverUrl'];
    duration = json['duration'];
    buyed = json['buyed'];
    canReward = json['canReward'];
    auditStatus = json['auditStatus'];
    score = json['score'];
    auditDisPlayStatus = json['auditDisPlayStatus'];
    categoryName = json['categoryName'];
    secondCategoryName = json['secondCategoryName'];
    trackCount = json['trackCount'];
    isPublish = json['isPublish'];
    createTime = json['createTime'];
    categoryId = json['categoryId'];
    coverUrl = json['coverUrl'];
    secondCategoryId = json['secondCategoryId'];
    scheduledPublishTime = json['scheduledPublishTime'];
    serialNum = json['serialNum'];
    listenerCount = json['listenerCount'];
    feeScope = json['feeScope'];
    programFeeType = json['programFeeType'];
    pubStatus = json['pubStatus'];
    subscribedCount = json['subscribedCount'];
    reward = json['reward'];
    bdAuditStatus = json['bdAuditStatus'];
    mainTrackId = json['mainTrackId'];
    smallLanguageAuditStatus = json['smallLanguageAuditStatus'];
    commentThreadId = json['commentThreadId'];
    privacy = json['privacy'];
    description = json['description'];
    name = json['name'];
    id = json['id'];
    subscribed = json['subscribed'];
    shareCount = json['shareCount'];
    likedCount = json['likedCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blurCoverUrl'] = this.blurCoverUrl;
    data['duration'] = this.duration;
    data['buyed'] = this.buyed;
    data['canReward'] = this.canReward;
    data['auditStatus'] = this.auditStatus;
    data['score'] = this.score;
    data['auditDisPlayStatus'] = this.auditDisPlayStatus;
    data['categoryName'] = this.categoryName;
    data['secondCategoryName'] = this.secondCategoryName;
    data['trackCount'] = this.trackCount;
    data['isPublish'] = this.isPublish;
    data['createTime'] = this.createTime;
    data['categoryId'] = this.categoryId;
    data['coverUrl'] = this.coverUrl;
    data['secondCategoryId'] = this.secondCategoryId;
    data['scheduledPublishTime'] = this.scheduledPublishTime;
    data['serialNum'] = this.serialNum;
    data['listenerCount'] = this.listenerCount;
    data['feeScope'] = this.feeScope;
    data['programFeeType'] = this.programFeeType;
    data['pubStatus'] = this.pubStatus;
    data['subscribedCount'] = this.subscribedCount;
    data['reward'] = this.reward;
    data['bdAuditStatus'] = this.bdAuditStatus;
    data['mainTrackId'] = this.mainTrackId;
    data['smallLanguageAuditStatus'] = this.smallLanguageAuditStatus;
    data['commentThreadId'] = this.commentThreadId;
    data['privacy'] = this.privacy;
    data['description'] = this.description;
    data['name'] = this.name;
    data['id'] = this.id;
    data['subscribed'] = this.subscribed;
    data['shareCount'] = this.shareCount;
    data['likedCount'] = this.likedCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}


class Artists {
  String name;
  int id;
  int picId;
  int img1v1Id;
  String briefDesc;
  String picUrl;
  String img1v1Url;
  int albumSize;
  String trans;
  int musicSize;
  int topicPerson;

  Artists(
      {this.name,
        this.id,
        this.picId,
        this.img1v1Id,
        this.briefDesc,
        this.picUrl,
        this.img1v1Url,
        this.albumSize,
        this.trans,
        this.musicSize,
        this.topicPerson});

  Artists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    picId = json['picId'];
    img1v1Id = json['img1v1Id'];
    briefDesc = json['briefDesc'];
    picUrl = json['picUrl'];
    img1v1Url = json['img1v1Url'];
    albumSize = json['albumSize'];
    trans = json['trans'];
    musicSize = json['musicSize'];
    topicPerson = json['topicPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['picId'] = this.picId;
    data['img1v1Id'] = this.img1v1Id;
    data['briefDesc'] = this.briefDesc;
    data['picUrl'] = this.picUrl;
    data['img1v1Url'] = this.img1v1Url;
    data['albumSize'] = this.albumSize;
    data['trans'] = this.trans;
    data['musicSize'] = this.musicSize;
    data['topicPerson'] = this.topicPerson;
    return data;
  }
}


class BMusic {
  int id;
  int size;
  String extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  BMusic(
      {
        this.id,
        this.size,
        this.extension,
        this.sr,
        this.dfsId,
        this.bitrate,
        this.playTime,
        this.volumeDelta});

  BMusic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    extension = json['extension'];
    sr = json['sr'];
    dfsId = json['dfsId'];
    bitrate = json['bitrate'];
    playTime = json['playTime'];
    volumeDelta = json['volumeDelta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['extension'] = this.extension;
    data['sr'] = this.sr;
    data['dfsId'] = this.dfsId;
    data['bitrate'] = this.bitrate;
    data['playTime'] = this.playTime;
    data['volumeDelta'] = this.volumeDelta;
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
  Experts experts;
  int djStatus;
  int vipType;
  int authenticationTypes;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  bool anchor;
  String brand;

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
        this.experts,
        this.djStatus,
        this.vipType,
        this.authenticationTypes,
        this.avatarImgIdStr,
        this.backgroundImgIdStr,
        this.anchor,
        this.brand});

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
    experts =
    json['experts'] != null ? new Experts.fromJson(json['experts']) : null;
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    authenticationTypes = json['authenticationTypes'];
    avatarImgIdStr = json['avatarImgIdStr'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    anchor = json['anchor'];
    avatarImgIdStr = json['avatarImgId_str'];
    brand = json['brand'];
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
    if (this.experts != null) {
      data['experts'] = this.experts.toJson();
    }
    data['djStatus'] = this.djStatus;
    data['vipType'] = this.vipType;
    data['authenticationTypes'] = this.authenticationTypes;
    data['avatarImgIdStr'] = this.avatarImgIdStr;
    data['backgroundImgIdStr'] = this.backgroundImgIdStr;
    data['anchor'] = this.anchor;
    data['avatarImgId_str'] = this.avatarImgIdStr;
    data['brand'] = this.brand;
    return data;
  }
}

class Experts {
  String s1;

  Experts({this.s1});

  Experts.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    return data;
  }
}

