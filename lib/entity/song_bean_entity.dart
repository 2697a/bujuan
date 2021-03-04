class SongBean {
  List<SongBeanEntity> players;

  SongBean({this.players});

  SongBean.fromJson(Map<String, dynamic> json) {
    if (json['players'] != null) {
      players = new List<SongBeanEntity>();
      (json['players'] as List).forEach((v) {
        players.add(new SongBeanEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.players != null) {
      data['players'] = this.players.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongBeanEntity {
  String name;
  String id;
  String picUrl;
  String singer;
  int mv;
  bool like;
  String url;

  SongBeanEntity({this.name, this.id, this.picUrl,this.singer,this.mv,this.like,this.url});

  SongBeanEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    picUrl = json['picUrl'];
    singer = json['singer'];
    url = json['url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['picUrl'] = this.picUrl;
    data['singer'] = this.singer;
    data['url'] = this.url;
    return data;
  }

  static String encondeToJson(List<SongBeanEntity> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList.toString();
  }
}
