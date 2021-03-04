class LocalSheetEntity {
  String name;
  String id;
  String picUrl;

  LocalSheetEntity({this.name, this.id, this.picUrl});

  LocalSheetEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['picUrl'] = this.picUrl;
    return data;
  }
}
