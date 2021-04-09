class SearchAlbumEntity {
  Result result;
  int code;

  SearchAlbumEntity({this.result, this.code});

  SearchAlbumEntity.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['code'] = this.code;
    return data;
  }
}

class Result {
  List<Albums> albums;
  int albumCount;

  Result({this.albums, this.albumCount});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['albums'] != null) {
      albums = new List<Albums>();
      json['albums'].forEach((v) {
        albums.add(new Albums.fromJson(v));
      });
    }
    albumCount = json['albumCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.albums != null) {
      data['albums'] = this.albums.map((v) => v.toJson()).toList();
    }
    data['albumCount'] = this.albumCount;
    return data;
  }
}

class Albums {
  String name;
  int id;
  String type;
  int size;
  int picId;
  String blurPicUrl;
  int companyId;
  int pic;
  String picUrl;
  int publishTime;
  String description;
  String tags;
  String company;
  String briefDesc;
  Artist artist;
  Null songs;
  List<String> alias;
  int status;
  int copyrightId;
  String commentThreadId;
  List<Artists> artists;
  bool paid;
  bool onSale;
  String picIdStr;
  String alg;
  int mark;
  String containedSong;

  Albums(
      {this.name,
        this.id,
        this.type,
        this.size,
        this.picId,
        this.blurPicUrl,
        this.companyId,
        this.pic,
        this.picUrl,
        this.publishTime,
        this.description,
        this.tags,
        this.company,
        this.briefDesc,
        this.artist,
        this.songs,
        this.alias,
        this.status,
        this.copyrightId,
        this.commentThreadId,
        this.artists,
        this.paid,
        this.onSale,
        this.picIdStr,
        this.alg,
        this.mark,
        this.containedSong});

  Albums.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    size = json['size'];
    picId = json['picId'];
    blurPicUrl = json['blurPicUrl'];
    companyId = json['companyId'];
    pic = json['pic'];
    picUrl = json['picUrl'];
    publishTime = json['publishTime'];
    description = json['description'];
    tags = json['tags'];
    company = json['company'];
    briefDesc = json['briefDesc'];
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    songs = json['songs'];
    alias = json['alias'].cast<String>();
    status = json['status'];
    copyrightId = json['copyrightId'];
    commentThreadId = json['commentThreadId'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    paid = json['paid'];
    onSale = json['onSale'];
    picIdStr = json['picId_str'];
    alg = json['alg'];
    mark = json['mark'];
    containedSong = json['containedSong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    data['size'] = this.size;
    data['picId'] = this.picId;
    data['blurPicUrl'] = this.blurPicUrl;
    data['companyId'] = this.companyId;
    data['pic'] = this.pic;
    data['picUrl'] = this.picUrl;
    data['publishTime'] = this.publishTime;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['company'] = this.company;
    data['briefDesc'] = this.briefDesc;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    data['songs'] = this.songs;
    data['alias'] = this.alias;
    data['status'] = this.status;
    data['copyrightId'] = this.copyrightId;
    data['commentThreadId'] = this.commentThreadId;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['paid'] = this.paid;
    data['onSale'] = this.onSale;
    data['picId_str'] = this.picIdStr;
    data['alg'] = this.alg;
    data['mark'] = this.mark;
    data['containedSong'] = this.containedSong;
    return data;
  }
}

class Artist {
  String name;
  int id;
  int picId;
  int img1v1Id;
  String briefDesc;
  String picUrl;
  String img1v1Url;
  int albumSize;
  List<String> alias;
  String trans;
  int musicSize;
  int topicPerson;
  String img1v1IdStr;
  List<String> alia;
  String picIdStr;

  Artist(
      {this.name,
        this.id,
        this.picId,
        this.img1v1Id,
        this.briefDesc,
        this.picUrl,
        this.img1v1Url,
        this.albumSize,
        this.alias,
        this.trans,
        this.musicSize,
        this.topicPerson,
        this.img1v1IdStr,
        this.alia,
        this.picIdStr});

  Artist.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    picId = json['picId'];
    img1v1Id = json['img1v1Id'];
    briefDesc = json['briefDesc'];
    picUrl = json['picUrl'];
    img1v1Url = json['img1v1Url'];
    albumSize = json['albumSize'];
    alias = json['alias'].cast<String>();
    trans = json['trans'];
    musicSize = json['musicSize'];
    topicPerson = json['topicPerson'];
    img1v1IdStr = json['img1v1Id_str'];
    alia = json['alia'].cast<String>();
    picIdStr = json['picId_str'];
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
    data['alias'] = this.alias;
    data['trans'] = this.trans;
    data['musicSize'] = this.musicSize;
    data['topicPerson'] = this.topicPerson;
    data['img1v1Id_str'] = this.img1v1IdStr;
    data['alia'] = this.alia;
    data['picId_str'] = this.picIdStr;
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
  String img1v1IdStr;

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
        this.topicPerson,
        this.img1v1IdStr});

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
    img1v1IdStr = json['img1v1Id_str'];
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
    data['img1v1Id_str'] = this.img1v1IdStr;
    return data;
  }
}
