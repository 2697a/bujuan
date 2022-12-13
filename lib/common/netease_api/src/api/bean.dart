import 'package:json_annotation/json_annotation.dart';
import '../../src/netease_bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class ServerStatusBean {
  @JsonKey(fromJson: dynamicToInt)
  late int code;
  String? message;
  String? msg;

  RetCode get codeEnum {
    return valueOfCode(code);
  }

  String get realMsg {
    return message ?? msg ?? '';
  }

  ServerStatusBean();

  factory ServerStatusBean.fromJson(Map<String, dynamic> json) =>
      _$ServerStatusBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ServerStatusBeanToJson(this);
}

@JsonSerializable()
class ServerStatusListBean extends ServerStatusBean {
  bool? more;
  bool? hasMore;
  int? count;
  int? total;

  bool get realMore {
    return more ?? hasMore ?? false;
  }

  ServerStatusListBean();

  factory ServerStatusListBean.fromJson(Map<String, dynamic> json) =>
      _$ServerStatusListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ServerStatusListBeanToJson(this);
}

String dynamicToString(dynamic value) => value?.toString() ?? '';

int dynamicToInt(dynamic value) {
  if (value is double) {
    return value.toInt();
  } else if (value is String) {
    return int.parse(value);
  }
  return value ?? 0;
}
