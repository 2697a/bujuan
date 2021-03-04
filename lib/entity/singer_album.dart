class SingerAlbum {
  List<HotAlbums> hotAlbums;
  bool more;
  int code;

  SingerAlbum({this.hotAlbums, this.more, this.code});

  SingerAlbum.fromJson(Map<String, dynamic> json) {
    if (json['hotAlbums'] != null) {
      hotAlbums = new List<HotAlbums>();
      json['hotAlbums'].forEach((v) {
        hotAlbums.add(new HotAlbums.fromJson(v));
      });
    }
    more = json['more'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotAlbums != null) {
      data['hotAlbums'] = this.hotAlbums.map((v) => v.toJson()).toList();
    }
    data['more'] = this.more;
    data['code'] = this.code;
    return data;
  }
}


class HotAlbums {
  String briefDesc;
  int publishTime;
  String company;
  String commentThreadId;
  String picUrl;
  int pic;
  String blurPicUrl;
  int companyId;
  String tags;
  int status;
  String subType;
  String description;
  String name;
  int id;
  String type;
  int size;
  String picIdStr;

  HotAlbums(
      {
        this.briefDesc,
        this.publishTime,
        this.company,
        this.commentThreadId,
        this.picUrl,
        this.pic,
        this.blurPicUrl,
        this.companyId,
        this.tags,
        this.status,
        this.subType,
        this.description,
        this.name,
        this.id,
        this.type,
        this.size,
        this.picIdStr});

  HotAlbums.fromJson(Map<String, dynamic> json) {
    briefDesc = json['briefDesc'];
    publishTime = json['publishTime'];
    company = json['company'];
    commentThreadId = json['commentThreadId'];
    picUrl = json['picUrl'];
    pic = json['pic'];
    blurPicUrl = json['blurPicUrl'];
    companyId = json['companyId'];
    tags = json['tags'];
    status = json['status'];
    subType = json['subType'];
    description = json['description'];
    name = json['name'];
    id = json['id'];
    type = json['type'];
    size = json['size'];
    picIdStr = json['picId_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['briefDesc'] = this.briefDesc;
    data['publishTime'] = this.publishTime;
    data['company'] = this.company;
    data['commentThreadId'] = this.commentThreadId;
    data['picUrl'] = this.picUrl;
    data['pic'] = this.pic;
    data['blurPicUrl'] = this.blurPicUrl;
    data['companyId'] = this.companyId;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['subType'] = this.subType;
    data['description'] = this.description;
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    data['size'] = this.size;
    data['picId_str'] = this.picIdStr;
    return data;
  }
}

class Artists {
  int img1v1Id;
  int topicPerson;
  int picId;
  int musicSize;
  int albumSize;
  String briefDesc;
  bool followed;
  String img1v1Url;
  String trans;
  String picUrl;
  String name;
  int id;
  String img1v1IdStr;

  Artists(
      {this.img1v1Id,
        this.topicPerson,
        this.picId,
        this.musicSize,
        this.albumSize,
        this.briefDesc,
        this.followed,
        this.img1v1Url,
        this.trans,
        this.picUrl,
        this.name,
        this.id,
        this.img1v1IdStr});

  Artists.fromJson(Map<String, dynamic> json) {
    img1v1Id = json['img1v1Id'];
    topicPerson = json['topicPerson'];
    picId = json['picId'];
    musicSize = json['musicSize'];
    albumSize = json['albumSize'];
    briefDesc = json['briefDesc'];
    followed = json['followed'];
    img1v1Url = json['img1v1Url'];
    trans = json['trans'];
    picUrl = json['picUrl'];
    name = json['name'];
    id = json['id'];
    img1v1IdStr = json['img1v1Id_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img1v1Id'] = this.img1v1Id;
    data['topicPerson'] = this.topicPerson;
    data['picId'] = this.picId;
    data['musicSize'] = this.musicSize;
    data['albumSize'] = this.albumSize;
    data['briefDesc'] = this.briefDesc;
    data['followed'] = this.followed;
    data['img1v1Url'] = this.img1v1Url;
    data['trans'] = this.trans;
    data['picUrl'] = this.picUrl;
    data['name'] = this.name;
    data['id'] = this.id;
    data['img1v1Id_str'] = this.img1v1IdStr;
    return data;
  }
}
