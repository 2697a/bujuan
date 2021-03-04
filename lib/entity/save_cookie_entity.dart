class SaveCookieEntity {
  String name;
  String value;
  int maxAge;
  String domain;
  String path;

  SaveCookieEntity(
      {this.name, this.value, this.maxAge, this.domain, this.path});

  SaveCookieEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    maxAge = json['maxAge'];
    domain = json['domain'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['maxAge'] = this.maxAge;
    data['domain'] = this.domain;
    data['path'] = this.path;
    return data;
  }
}
