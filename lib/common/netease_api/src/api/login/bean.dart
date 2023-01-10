import 'package:json_annotation/json_annotation.dart';
import '../../../netease_music_api.dart';
import '../../../src/api/bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class NeteaseAccount {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  String? userName;

  int? type;
  int? status;

  int? createTime;

  int? vipType;
  int? viptypeVersion;

  bool? anonimousUser;

  NeteaseAccount();

  factory NeteaseAccount.fromJson(Map<String, dynamic> json) =>
      _$NeteaseAccountFromJson(json);

  Map<String, dynamic> toJson() => _$NeteaseAccountToJson(this);
}

@JsonSerializable()
class NeteaseAccountProfile extends NeteaseUserInfo {
  int? follows;
  int? playlistCount;
  int? followeds;

  NeteaseAccountProfile();

  factory NeteaseAccountProfile.fromJson(Map<String, dynamic> json) =>
      _$NeteaseAccountProfileFromJson(json);

  Map<String, dynamic> toJson() => _$NeteaseAccountProfileToJson(this);
}

@JsonSerializable()
class NeteaseAccountInfoWrap extends ServerStatusBean {
  int? loginType;

  NeteaseAccount? account;

  NeteaseAccountProfile? profile;

  NeteaseAccountInfoWrap();

  factory NeteaseAccountInfoWrap.fromJson(Map<String, dynamic> json) =>
      _$NeteaseAccountInfoWrapFromJson(json);

  Map<String, dynamic> toJson() => _$NeteaseAccountInfoWrapToJson(this);
}

@JsonSerializable()
class NeteaseAccountBinding {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  @JsonKey(fromJson: dynamicToString)
  String? userId;

  String? tokenJsonStr;
  String? url;
  int? type;
  int? expiresIn;
  int? refreshTime;
  int? bindingTime;
  bool? expired;

  NeteaseAccountBinding();

  factory NeteaseAccountBinding.fromJson(Map<String, dynamic> json) =>
      _$NeteaseAccountBindingFromJson(json);

  Map<String, dynamic> toJson() => _$NeteaseAccountBindingToJson(this);
}

@JsonSerializable()
class NeteaseAccountBindingWrap extends ServerStatusBean {
  late List<NeteaseAccountBinding> bindings;

  NeteaseAccountBindingWrap();

  factory NeteaseAccountBindingWrap.fromJson(Map<String, dynamic> json) =>
      _$NeteaseAccountBindingWrapFromJson(json);

  Map<String, dynamic> toJson() => _$NeteaseAccountBindingWrapToJson(this);
}

@JsonSerializable()
class CellPhoneCheckExistenceRet extends ServerStatusBean {
  // 1: 存在   -1: 不存在
  int? exist;

  String? nickname;

  bool? hasPassword;

  /// 账号不存在 或者 没有密码 需要短信登录
  bool get needUseSms => exist != 1 || !(hasPassword ?? true);

  CellPhoneCheckExistenceRet();

  factory CellPhoneCheckExistenceRet.fromJson(Map<String, dynamic> json) =>
      _$CellPhoneCheckExistenceRetFromJson(json);

  Map<String, dynamic> toJson() => _$CellPhoneCheckExistenceRetToJson(this);
}

@JsonSerializable()
class AnonimousLoginRet extends ServerStatusBean {
  @JsonKey(fromJson: dynamicToString)
  late String userId;

  AnonimousLoginRet();

  factory AnonimousLoginRet.fromJson(Map<String, dynamic> json) =>
      _$AnonimousLoginRetFromJson(json);

  Map<String, dynamic> toJson() => _$AnonimousLoginRetToJson(this);
}

@JsonSerializable()
class QrCodeLoginKey extends ServerStatusBean {
  late String unikey;

  QrCodeLoginKey();

  factory QrCodeLoginKey.fromJson(Map<String, dynamic> json) =>
      _$QrCodeLoginKeyFromJson(json);

  Map<String, dynamic> toJson() => _$QrCodeLoginKeyToJson(this);
}
