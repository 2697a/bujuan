class AlbumNewest {
  int code;
  List<Albums> albums;

  AlbumNewest({this.code, this.albums});

  AlbumNewest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['albums'] != null) {
      albums = new List<Albums>();
      json['albums'].forEach((v) {
        albums.add(new Albums.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.albums != null) {
      data['albums'] = this.albums.map((v) => v.toJson()).toList();
    }
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
  int status;
  int copyrightId;
  String commentThreadId;
  List<Artists> artists;
  bool paid;
  bool onSale;
  String picIdStr;

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
        this.status,
        this.copyrightId,
        this.commentThreadId,
        this.artists,
        this.paid,
        this.onSale,
        this.picIdStr});

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
    data['status'] = this.status;
    data['copyrightId'] = this.copyrightId;
    data['commentThreadId'] = this.commentThreadId;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['paid'] = this.paid;
    data['onSale'] = this.onSale;
    data['picId_str'] = this.picIdStr;
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
  String picIdStr;
  String img1v1IdStr;

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
        this.picIdStr,
        this.img1v1IdStr});

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
    picIdStr = json['picId_str'];
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
    data['alias'] = this.alias;
    data['trans'] = this.trans;
    data['musicSize'] = this.musicSize;
    data['topicPerson'] = this.topicPerson;
    data['picId_str'] = this.picIdStr;
    data['img1v1Id_str'] = this.img1v1IdStr;
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
