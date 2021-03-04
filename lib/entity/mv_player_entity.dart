class MvPlayerEntity {
  String bufferPic;
  int code;
  String loadingPicFS;
  bool subed;
  MvPlayerData data;
  String bufferPicFS;
  String loadingPic;

  MvPlayerEntity(
      {this.bufferPic,
      this.code,
      this.loadingPicFS,
      this.subed,
      this.data,
      this.bufferPicFS,
      this.loadingPic});

  MvPlayerEntity.fromJson(Map<String, dynamic> json) {
    bufferPic = json['bufferPic'];
    code = json['code'];
    loadingPicFS = json['loadingPicFS'];
    subed = json['subed'];
    data =
        json['data'] != null ? new MvPlayerData.fromJson(json['data']) : null;
    bufferPicFS = json['bufferPicFS'];
    loadingPic = json['loadingPic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bufferPic'] = this.bufferPic;
    data['code'] = this.code;
    data['loadingPicFS'] = this.loadingPicFS;
    data['subed'] = this.subed;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['bufferPicFS'] = this.bufferPicFS;
    data['loadingPic'] = this.loadingPic;
    return data;
  }
}

class MvPlayerData {
  String publishTime;
  Map brs;
  bool isReward;
  String commentThreadId;
  int artistId;
  int likeCount;
  int commentCount;
  String cover;
  int subCount;
  int duration;
  int playCount;
  int shareCount;
  int coverId;
  String briefDesc;
  List<MvPlayerDataArtist> artists;
  String name;
  String artistName;
  int id;
  int nType;
  String desc;

  MvPlayerData(
      {this.publishTime,
      this.brs,
      this.isReward,
      this.commentThreadId,
      this.artistId,
      this.likeCount,
      this.commentCount,
      this.cover,
      this.subCount,
      this.duration,
      this.playCount,
      this.shareCount,
      this.coverId,
      this.briefDesc,
      this.artists,
      this.name,
      this.artistName,
      this.id,
      this.nType,
      this.desc});

  MvPlayerData.fromJson(Map<String, dynamic> json) {
    publishTime = json['publishTime'];
    brs = json['brs'];
    isReward = json['isReward'];
    commentThreadId = json['commentThreadId'];
    artistId = json['artistId'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    cover = json['cover'];
    subCount = json['subCount'];
    duration = json['duration'];
    playCount = json['playCount'];
    shareCount = json['shareCount'];
    coverId = json['coverId'];
    briefDesc = json['briefDesc'];
    if (json['artists'] != null) {
      artists = new List<MvPlayerDataArtist>();
      (json['artists'] as List).forEach((v) {
        artists.add(new MvPlayerDataArtist.fromJson(v));
      });
    }
    name = json['name'];
    artistName = json['artistName'];
    id = json['id'];
    nType = json['nType'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishTime'] = this.publishTime;
    data['brs'] = this.brs;
    data['isReward'] = this.isReward;
    data['commentThreadId'] = this.commentThreadId;
    data['artistId'] = this.artistId;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    data['cover'] = this.cover;
    data['subCount'] = this.subCount;
    data['duration'] = this.duration;
    data['playCount'] = this.playCount;
    data['shareCount'] = this.shareCount;
    data['coverId'] = this.coverId;
    data['briefDesc'] = this.briefDesc;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['artistName'] = this.artistName;
    data['id'] = this.id;
    data['nType'] = this.nType;
    data['desc'] = this.desc;
    return data;
  }
}

class MvPlayerDataArtist {
  String name;
  int id;

  MvPlayerDataArtist({this.name, this.id});

  MvPlayerDataArtist.fromJson(Map<String, dynamic> json) {
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
