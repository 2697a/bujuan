class MusicTalk {
  int code;
  Data data;

  MusicTalk({this.code, this.data});

  MusicTalk.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Comments> comments;
  dynamic currentComment;
  int totalCount;
  bool hasMore;
  String cursor;
  int sortType;
  List<SortTypeList> sortTypeList;

  Data(
      {this.comments,
        this.currentComment,
        this.totalCount,
        this.hasMore,
        this.cursor,
        this.sortType,
        this.sortTypeList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    currentComment = json['currentComment'];
    totalCount = json['totalCount'];
    hasMore = json['hasMore'];
    cursor = json['cursor'];
    sortType = json['sortType'];
    if (json['sortTypeList'] != null) {
      sortTypeList = new List<SortTypeList>();
      json['sortTypeList'].forEach((v) {
        sortTypeList.add(new SortTypeList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['currentComment'] = this.currentComment;
    data['totalCount'] = this.totalCount;
    data['hasMore'] = this.hasMore;
    data['cursor'] = this.cursor;
    data['sortType'] = this.sortType;
    if (this.sortTypeList != null) {
      data['sortTypeList'] = this.sortTypeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  User user;
  dynamic beReplied;
  int commentId;
  String content;
  int status;
  int time;
  int likedCount;
  bool liked;
  dynamic expressionUrl;
  int parentCommentId;
  bool repliedMark;
  dynamic pendantData;
  ShowFloorComment showFloorComment;
  int commentLocationType;
  String args;
  Tag tag;
  dynamic source;

  Comments(
      {this.user,
        this.beReplied,
        this.commentId,
        this.content,
        this.status,
        this.time,
        this.likedCount,
        this.liked,
        this.expressionUrl,
        this.parentCommentId,
        this.repliedMark,
        this.pendantData,
        this.showFloorComment,
        this.commentLocationType,
        this.args,
        this.tag,
        this.source});

  Comments.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    beReplied = json['beReplied'];
    commentId = json['commentId'];
    content = json['content'];
    status = json['status'];
    time = json['time'];
    likedCount = json['likedCount'];
    liked = json['liked'];
    expressionUrl = json['expressionUrl'];
    parentCommentId = json['parentCommentId'];
    repliedMark = json['repliedMark'];
    pendantData = json['pendantData'];
    showFloorComment = json['showFloorComment'] != null
        ? new ShowFloorComment.fromJson(json['showFloorComment'])
        : null;
    commentLocationType = json['commentLocationType'];
    args = json['args'];
    tag = json['tag'] != null ? new Tag.fromJson(json['tag']) : null;
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['beReplied'] = this.beReplied;
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['status'] = this.status;
    data['time'] = this.time;
    data['likedCount'] = this.likedCount;
    data['liked'] = this.liked;
    data['expressionUrl'] = this.expressionUrl;
    data['parentCommentId'] = this.parentCommentId;
    data['repliedMark'] = this.repliedMark;
    data['pendantData'] = this.pendantData;
    if (this.showFloorComment != null) {
      data['showFloorComment'] = this.showFloorComment.toJson();
    }
    data['commentLocationType'] = this.commentLocationType;
    data['args'] = this.args;
    if (this.tag != null) {
      data['tag'] = this.tag.toJson();
    }
    data['source'] = this.source;
    return data;
  }
}

class User {
  dynamic avatarDetail;
  dynamic locationInfo;
  dynamic liveInfo;
  bool followed;
  dynamic vipRights;
  dynamic relationTag;
  int anonym;
  int userId;
  int userType;
  String nickname;
  String avatarUrl;
  int authStatus;
  dynamic expertTags;
  dynamic experts;
  int vipType;
  dynamic remarkName;
  bool isHug;

  User(
      {this.avatarDetail,
        this.locationInfo,
        this.liveInfo,
        this.followed,
        this.vipRights,
        this.relationTag,
        this.anonym,
        this.userId,
        this.userType,
        this.nickname,
        this.avatarUrl,
        this.authStatus,
        this.expertTags,
        this.experts,
        this.vipType,
        this.remarkName,
        this.isHug});

  User.fromJson(Map<String, dynamic> json) {
    avatarDetail = json['avatarDetail'];
    locationInfo = json['locationInfo'];
    liveInfo = json['liveInfo'];
    followed = json['followed'];
    vipRights = json['vipRights'];
    relationTag = json['relationTag'];
    anonym = json['anonym'];
    userId = json['userId'];
    userType = json['userType'];
    nickname = json['nickname'];
    avatarUrl = json['avatarUrl'];
    authStatus = json['authStatus'];
    expertTags = json['expertTags'];
    experts = json['experts'];
    vipType = json['vipType'];
    remarkName = json['remarkName'];
    isHug = json['isHug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarDetail'] = this.avatarDetail;
    data['locationInfo'] = this.locationInfo;
    data['liveInfo'] = this.liveInfo;
    data['followed'] = this.followed;
    data['vipRights'] = this.vipRights;
    data['relationTag'] = this.relationTag;
    data['anonym'] = this.anonym;
    data['userId'] = this.userId;
    data['userType'] = this.userType;
    data['nickname'] = this.nickname;
    data['avatarUrl'] = this.avatarUrl;
    data['authStatus'] = this.authStatus;
    data['expertTags'] = this.expertTags;
    data['experts'] = this.experts;
    data['vipType'] = this.vipType;
    data['remarkName'] = this.remarkName;
    data['isHug'] = this.isHug;
    return data;
  }
}

class ShowFloorComment {
  int replyCount;
  dynamic comments;
  bool showReplyCount;
  dynamic topCommentIds;
  dynamic target;

  ShowFloorComment(
      {this.replyCount,
        this.comments,
        this.showReplyCount,
        this.topCommentIds,
        this.target});

  ShowFloorComment.fromJson(Map<String, dynamic> json) {
    replyCount = json['replyCount'];
    comments = json['comments'];
    showReplyCount = json['showReplyCount'];
    topCommentIds = json['topCommentIds'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyCount'] = this.replyCount;
    data['comments'] = this.comments;
    data['showReplyCount'] = this.showReplyCount;
    data['topCommentIds'] = this.topCommentIds;
    data['target'] = this.target;
    return data;
  }
}

class Tag {
  List<Datas> datas;
  dynamic relatedCommentIds;

  Tag({this.datas, this.relatedCommentIds});

  Tag.fromJson(Map<String, dynamic> json) {
    if (json['datas'] != null) {
      datas = new List<Datas>();
      json['datas'].forEach((v) {
        datas.add(new Datas.fromJson(v));
      });
    }
    relatedCommentIds = json['relatedCommentIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    data['relatedCommentIds'] = this.relatedCommentIds;
    return data;
  }
}

class Datas {
  String text;
  int type;
  String recommendType;

  Datas({this.text, this.type, this.recommendType});

  Datas.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
    recommendType = json['recommendType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['type'] = this.type;
    data['recommendType'] = this.recommendType;
    return data;
  }
}

class SortTypeList {
  int sortType;
  String sortTypeName;
  String target;

  SortTypeList({this.sortType, this.sortTypeName, this.target});

  SortTypeList.fromJson(Map<String, dynamic> json) {
    sortType = json['sortType'];
    sortTypeName = json['sortTypeName'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sortType'] = this.sortType;
    data['sortTypeName'] = this.sortTypeName;
    data['target'] = this.target;
    return data;
  }
}
