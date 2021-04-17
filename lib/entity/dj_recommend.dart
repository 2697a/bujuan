import 'package:bujuan/entity/user_dj.dart';

class DjRecommend {
  List<DjRadios> data;
  int code;

  DjRecommend({this.data, this.code});

  DjRecommend.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<DjRadios>();
      json['data'].forEach((v) {
        data.add(new DjRadios.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

