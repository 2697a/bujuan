class UserDjProgram {
  num count;
  num code;
  List<Programs> programs;
  bool more;

  UserDjProgram({this.count, this.code, this.programs, this.more});

  UserDjProgram.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    code = json['code'];
    if (json['programs'] != null) {
      programs = new List<Programs>();
      json['programs'].forEach((v) {
        programs.add(new Programs.fromJson(v));
      });
    }
    more = json['more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['code'] = this.code;
    if (this.programs != null) {
      data['programs'] = this.programs.map((v) => v.toJson()).toList();
    }
    data['more'] = this.more;
    return data;
  }
}

class Programs {
  MainSong mainSong;
  Dj dj;
  String blurCoverUrl;
  Radio radio;
  num duration;
  bool buyed;
  bool canReward;
  num auditStatus;
  num score;
  num auditDisPlayStatus;
  String description;
  num trackCount;
  bool isPublish;
  String commentThreadId;
  List<String> channels;
  num listenerCount;
  num pubStatus;
  bool privacy;
  num scheduledPublishTime;
  num smallLanguageAuditStatus;
  num categoryId;
  num createTime;
  num serialNum;
  num secondCategoryId;
  num feeScope;
  String coverUrl;
  num bdAuditStatus;
  num subscribedCount;
  bool reward;
  num programFeeType;
  num manumrackId;
  String name;
  num id;
  num shareCount;
  bool subscribed;
  num likedCount;
  num commentCount;

  Programs(
      {this.mainSong,
        this.dj,
        this.blurCoverUrl,
        this.radio,
        this.duration,
        this.buyed,
        this.canReward,
        this.auditStatus,
        this.score,
        this.auditDisPlayStatus,
        this.description,
        this.trackCount,
        this.isPublish,
        this.commentThreadId,
        this.channels,
        this.listenerCount,
        this.pubStatus,
        this.privacy,
        this.scheduledPublishTime,
        this.smallLanguageAuditStatus,
        this.categoryId,
        this.createTime,
        this.serialNum,
        this.secondCategoryId,
        this.feeScope,
        this.coverUrl,
        this.bdAuditStatus,
        this.subscribedCount,
        this.reward,
        this.programFeeType,
        this.manumrackId,
        this.name,
        this.id,
        this.shareCount,
        this.subscribed,
        this.likedCount,
        this.commentCount});

  Programs.fromJson(Map<String, dynamic> json) {
    mainSong = json['mainSong'] != null
        ? new MainSong.fromJson(json['mainSong'])
        : null;
    dj = json['dj'] != null ? new Dj.fromJson(json['dj']) : null;
    blurCoverUrl = json['blurCoverUrl'];
    radio = json['radio'] != null ? new Radio.fromJson(json['radio']) : null;
    duration = json['duration'];
    buyed = json['buyed'];
    canReward = json['canReward'];
    auditStatus = json['auditStatus'];
    score = json['score'];
    auditDisPlayStatus = json['auditDisPlayStatus'];
    description = json['description'];
    trackCount = json['trackCount'];
    isPublish = json['isPublish'];
    commentThreadId = json['commentThreadId'];
    channels = json['channels'].cast<String>();
    listenerCount = json['listenerCount'];
    pubStatus = json['pubStatus'];
    privacy = json['privacy'];
    scheduledPublishTime = json['scheduledPublishTime'];
    smallLanguageAuditStatus = json['smallLanguageAuditStatus'];
    categoryId = json['categoryId'];
    createTime = json['createTime'];
    serialNum = json['serialNum'];
    secondCategoryId = json['secondCategoryId'];
    feeScope = json['feeScope'];
    coverUrl = json['coverUrl'];
    bdAuditStatus = json['bdAuditStatus'];
    subscribedCount = json['subscribedCount'];
    reward = json['reward'];
    programFeeType = json['programFeeType'];
    manumrackId = json['manumrackId'];
    name = json['name'];
    id = json['id'];
    shareCount = json['shareCount'];
    subscribed = json['subscribed'];
    likedCount = json['likedCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainSong != null) {
      data['mainSong'] = this.mainSong.toJson();
    }
    if (this.dj != null) {
      data['dj'] = this.dj.toJson();
    }
    data['blurCoverUrl'] = this.blurCoverUrl;
    if (this.radio != null) {
      data['radio'] = this.radio.toJson();
    }
    data['duration'] = this.duration;
    data['buyed'] = this.buyed;
    data['canReward'] = this.canReward;
    data['auditStatus'] = this.auditStatus;
    data['score'] = this.score;
    data['auditDisPlayStatus'] = this.auditDisPlayStatus;
    data['description'] = this.description;
    data['trackCount'] = this.trackCount;
    data['isPublish'] = this.isPublish;
    data['commentThreadId'] = this.commentThreadId;
    data['channels'] = this.channels;
    data['listenerCount'] = this.listenerCount;
    data['pubStatus'] = this.pubStatus;
    data['privacy'] = this.privacy;
    data['scheduledPublishTime'] = this.scheduledPublishTime;
    data['smallLanguageAuditStatus'] = this.smallLanguageAuditStatus;
    data['categoryId'] = this.categoryId;
    data['createTime'] = this.createTime;
    data['serialNum'] = this.serialNum;
    data['secondCategoryId'] = this.secondCategoryId;
    data['feeScope'] = this.feeScope;
    data['coverUrl'] = this.coverUrl;
    data['bdAuditStatus'] = this.bdAuditStatus;
    data['subscribedCount'] = this.subscribedCount;
    data['reward'] = this.reward;
    data['programFeeType'] = this.programFeeType;
    data['manumrackId'] = this.manumrackId;
    data['name'] = this.name;
    data['id'] = this.id;
    data['shareCount'] = this.shareCount;
    data['subscribed'] = this.subscribed;
    data['likedCount'] = this.likedCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}

class MainSong {
  String name;
  num id;
  num position;
  num status;
  num fee;
  num copyrightId;
  String disc;
  num no;
  List<Artists> artists;
  DjAlbum album;
  bool starred;
  num popularity;
  num score;
  num starredNum;
  num duration;
  num playedNum;
  num dayPlays;
  num hearTime;
  String ringtone;
  String copyFrom;
  String commentThreadId;
  num ftype;
  num copyright;
  num mark;
  MMusic mMusic;
  MMusic lMusic;
  MMusic bMusic;
  num rtype;
  num mvid;

  MainSong(
      {this.name,
        this.id,
        this.position,
        this.status,
        this.fee,
        this.copyrightId,
        this.disc,
        this.no,
        this.artists,
        this.album,
        this.starred,
        this.popularity,
        this.score,
        this.starredNum,
        this.duration,
        this.playedNum,
        this.dayPlays,
        this.hearTime,
        this.ringtone,
        this.copyFrom,
        this.commentThreadId,
        this.ftype,
        this.copyright,
        this.mark,
        this.mMusic,
        this.lMusic,
        this.bMusic,
        this.rtype,
        this.mvid});

  MainSong.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    position = json['position'];
    status = json['status'];
    fee = json['fee'];
    copyrightId = json['copyrightId'];
    disc = json['disc'];
    no = json['no'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    album = json['album'] != null ? new DjAlbum.fromJson(json['album']) : null;
    starred = json['starred'];
    popularity = json['popularity'];
    score = json['score'];
    starredNum = json['starredNum'];
    duration = json['duration'];
    playedNum = json['playedNum'];
    dayPlays = json['dayPlays'];
    hearTime = json['hearTime'];
    ringtone = json['ringtone'];
    copyFrom = json['copyFrom'];
    commentThreadId = json['commentThreadId'];
    ftype = json['ftype'];
    copyright = json['copyright'];
    mark = json['mark'];
    mMusic =
    json['mMusic'] != null ? new MMusic.fromJson(json['mMusic']) : null;
    lMusic =
    json['lMusic'] != null ? new MMusic.fromJson(json['lMusic']) : null;
    bMusic =
    json['bMusic'] != null ? new MMusic.fromJson(json['bMusic']) : null;
    rtype = json['rtype'];
    mvid = json['mvid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['position'] = this.position;
    data['status'] = this.status;
    data['fee'] = this.fee;
    data['copyrightId'] = this.copyrightId;
    data['disc'] = this.disc;
    data['no'] = this.no;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    data['starred'] = this.starred;
    data['popularity'] = this.popularity;
    data['score'] = this.score;
    data['starredNum'] = this.starredNum;
    data['duration'] = this.duration;
    data['playedNum'] = this.playedNum;
    data['dayPlays'] = this.dayPlays;
    data['hearTime'] = this.hearTime;
    data['ringtone'] = this.ringtone;
    data['copyFrom'] = this.copyFrom;
    data['commentThreadId'] = this.commentThreadId;
    data['ftype'] = this.ftype;
    data['copyright'] = this.copyright;
    data['mark'] = this.mark;
    if (this.mMusic != null) {
      data['mMusic'] = this.mMusic.toJson();
    }
    if (this.lMusic != null) {
      data['lMusic'] = this.lMusic.toJson();
    }
    if (this.bMusic != null) {
      data['bMusic'] = this.bMusic.toJson();
    }
    data['rtype'] = this.rtype;
    data['mvid'] = this.mvid;
    return data;
  }
}

class Artists {
  String name;
  num id;
  num picId;
  num img1v1Id;
  String briefDesc;
  String picUrl;
  String img1v1Url;
  num albumSize;
  String trans;
  num musicSize;
  num topicPerson;

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

class DjAlbum {
  String name;
  num id;
  num size;
  num picId;
  num companyId;
  num pic;
  String picUrl;
  num publishTime;
  String description;
  String tags;
  String briefDesc;
  Artists artist;
  num status;
  num copyrightId;
  String commentThreadId;
  List<Artists> artists;
  num mark;

  DjAlbum(
      {this.name,
        this.id,
        this.size,
        this.picId,
        this.companyId,
        this.pic,
        this.picUrl,
        this.publishTime,
        this.description,
        this.tags,
        this.briefDesc,
        this.artist,
        this.status,
        this.copyrightId,
        this.commentThreadId,
        this.artists,
        this.mark});

  DjAlbum.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    size = json['size'];
    picId = json['picId'];
    companyId = json['companyId'];
    pic = json['pic'];
    picUrl = json['picUrl'];
    publishTime = json['publishTime'];
    description = json['description'];
    tags = json['tags'];
    briefDesc = json['briefDesc'];
    artist =
    json['artist'] != null ? new Artists.fromJson(json['artist']) : null;
    status = json['status'];
    copyrightId = json['copyrightId'];
    commentThreadId = json['commentThreadId'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    mark = json['mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['size'] = this.size;
    data['picId'] = this.picId;
    data['companyId'] = this.companyId;
    data['pic'] = this.pic;
    data['picUrl'] = this.picUrl;
    data['publishTime'] = this.publishTime;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['briefDesc'] = this.briefDesc;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    data['status'] = this.status;
    data['copyrightId'] = this.copyrightId;
    data['commentThreadId'] = this.commentThreadId;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['mark'] = this.mark;
    return data;
  }
}

class MMusic {
  String name;
  num id;
  num size;
  String extension;
  num sr;
  num dfsId;
  num bitrate;
  num playTime;
  num volumeDelta;

  MMusic(
      {this.name,
        this.id,
        this.size,
        this.extension,
        this.sr,
        this.dfsId,
        this.bitrate,
        this.playTime,
        this.volumeDelta});

  MMusic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
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
    data['name'] = this.name;
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
  num province;
  num authStatus;
  bool followed;
  String avatarUrl;
  num accountStatus;
  num gender;
  num city;
  num birthday;
  num userId;
  num userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  num avatarImgId;
  num backgroundImgId;
  String backgroundUrl;
  num authority;
  bool mutual;
  num djStatus;
  num vipType;
  num authenticationTypes;
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
    djStatus = json['djStatus'];
    vipType = json['vipType'];
    authenticationTypes = json['authenticationTypes'];
    avatarImgIdStr = json['avatarImgIdStr']??json['avatarImgId_str'];
    backgroundImgIdStr = json['backgroundImgIdStr'];
    anchor = json['anchor'];
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

class Radio {
  String category;
  bool buyed;
  num price;
  num originalPrice;
  num purchaseCount;
  bool finished;
  bool underShelf;
  num playCount;
  bool privacy;
  String desc;
  String picUrl;
  num programCount;
  num categoryId;
  num createTime;
  num feeScope;
  num picId;
  num subCount;
  num lastProgramCreateTime;
  num lastProgramId;
  num radioFeeType;
  String name;
  num id;
  bool subed;

  Radio(
      {
        this.category,
        this.buyed,
        this.price,
        this.originalPrice,
        this.purchaseCount,
        this.finished,
        this.underShelf,
        this.playCount,
        this.privacy,
        this.desc,
        this.picUrl,
        this.programCount,
        this.categoryId,
        this.createTime,
        this.feeScope,
        this.picId,
        this.subCount,
        this.lastProgramCreateTime,
        this.lastProgramId,
        this.radioFeeType,
        this.name,
        this.id,
        this.subed});

  Radio.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    buyed = json['buyed'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    purchaseCount = json['purchaseCount'];
    finished = json['finished'];
    underShelf = json['underShelf'];
    playCount = json['playCount'];
    privacy = json['privacy'];
    desc = json['desc'];
    picUrl = json['picUrl'];
    programCount = json['programCount'];
    categoryId = json['categoryId'];
    createTime = json['createTime'];
    feeScope = json['feeScope'];
    picId = json['picId'];
    subCount = json['subCount'];
    lastProgramCreateTime = json['lastProgramCreateTime'];
    lastProgramId = json['lastProgramId'];
    radioFeeType = json['radioFeeType'];
    name = json['name'];
    id = json['id'];
    subed = json['subed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['buyed'] = this.buyed;
    data['price'] = this.price;
    data['originalPrice'] = this.originalPrice;
    data['purchaseCount'] = this.purchaseCount;
    data['finished'] = this.finished;
    data['underShelf'] = this.underShelf;
    data['playCount'] = this.playCount;
    data['privacy'] = this.privacy;
    data['desc'] = this.desc;
    data['picUrl'] = this.picUrl;
    data['programCount'] = this.programCount;
    data['categoryId'] = this.categoryId;
    data['createTime'] = this.createTime;
    data['feeScope'] = this.feeScope;
    data['picId'] = this.picId;
    data['subCount'] = this.subCount;
    data['lastProgramCreateTime'] = this.lastProgramCreateTime;
    data['lastProgramId'] = this.lastProgramId;
    data['radioFeeType'] = this.radioFeeType;
    data['name'] = this.name;
    data['id'] = this.id;
    data['subed'] = this.subed;
    return data;
  }
}
