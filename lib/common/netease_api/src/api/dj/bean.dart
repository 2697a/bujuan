import 'package:json_annotation/json_annotation.dart';
import '../../../src/api/bean.dart';
import '../../../src/netease_bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class Dj {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? nickName;
  String? avatarUrl;
  int? userType;

  int? rank;
  int? lastRank;
  int? score;

  Dj();

  factory Dj.fromJson(Map<String, dynamic> json) => _$DjFromJson(json);

  Map<String, dynamic> toJson() => _$DjToJson(this);
}

@JsonSerializable()
class DjRadio {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  late String name;

  NeteaseAccountProfile? dj;

  late String picUrl;
  String? desc;

  late int subCount;
  int? commentCount;
  late int programCount;
  int? shareCount;
  int? likedCount;

  int? createTime;
  int? categoryId;
  String? category;

  late int radioFeeType;
  late int feeScope;

  bool? buyed;
  bool? finished;
  bool? underShelf;

  int? purchaseCount;
  int? price;
  int? originalPrice;
  int? lastProgramCreateTime;
  String? lastProgramName;
  int? lastProgramId;

  bool? composeVideo;

  String? alg;

  DjRadio();

  factory DjRadio.fromJson(Map<String, dynamic> json) =>
      _$DjRadioFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioToJson(this);
}

@JsonSerializable()
class DjProgram {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;
  String? programDesc;

  String? coverUrl;
  String? blurCoverUrl;
  String? description;
  String? alg;
  String? commentThreadId;

  int? mainTrackId;
  int? pubStatus;
  late int bdAuditStatus;
  int? serialNum;
  int? duration;
  int? auditStatus;
  int? score;
  int? createTime;
  int? feeScope;
  int? listenerCount;
  int? subscribedCount;
  int? programFeeType;
  int? trackCount;
  int? smallLanguageAuditStatus;
  int? shareCount;
  int? likedCount;
  int? commentCount;

  bool? buyed;
  late bool isPublish;
  bool? subscribed;
  bool? canReward;
  bool? reward;

  late DjRadio radio;

  late Song mainSong;

  late NeteaseAccountProfile dj;

  DjProgram();

  factory DjProgram.fromJson(Map<String, dynamic> json) =>
      _$DjProgramFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramToJson(this);
}

@JsonSerializable()
class DjRadioCategory {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  late String name;

  late String picMacUrl;
  late String picWebUrl;
  late String picUWPUrl;
  late String picIPadUrl;
  late String picPCBlackUrl;
  late String picPCWhiteUrl;
  late String pic56x56Url;
  late String pic84x84IdUrl;
  late String pic96x96Url;

  DjRadioCategory();

  factory DjRadioCategory.fromJson(Map<String, dynamic> json) =>
      _$DjRadioCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioCategoryToJson(this);
}

@JsonSerializable()
class DjRadioCategory2 {
  @JsonKey(fromJson: dynamicToString)
  late String categoryId;
  late String categoryName;

  late List<DjRadio> radios;

  DjRadioCategory2();

  factory DjRadioCategory2.fromJson(Map<String, dynamic> json) =>
      _$DjRadioCategory2FromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioCategory2ToJson(this);
}

@JsonSerializable()
class DjRadioCategoryWrap extends ServerStatusBean {
  late List<DjRadioCategory> categories;

  DjRadioCategoryWrap();

  factory DjRadioCategoryWrap.fromJson(Map<String, dynamic> json) =>
      _$DjRadioCategoryWrapFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioCategoryWrapToJson(this);
}

@JsonSerializable()
class DjRadioCategoryWrap2 extends ServerStatusBean {
  late List<DjRadioCategory2> data;

  DjRadioCategoryWrap2();

  factory DjRadioCategoryWrap2.fromJson(Map<String, dynamic> json) =>
      _$DjRadioCategoryWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioCategoryWrap2ToJson(this);
}

@JsonSerializable()
class DjRadioCategoryWrap3 extends ServerStatusBean {
  late List<DjRadioCategory> data;

  DjRadioCategoryWrap3();

  factory DjRadioCategoryWrap3.fromJson(Map<String, dynamic> json) =>
      _$DjRadioCategoryWrap3FromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioCategoryWrap3ToJson(this);
}

@JsonSerializable()
class DjRadioListWrap extends ServerStatusListBean {
  late List<DjRadio> djRadios;

  String? name;

  int? subCount;

  DjRadioListWrap();

  factory DjRadioListWrap.fromJson(Map<String, dynamic> json) =>
      _$DjRadioListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioListWrapToJson(this);
}

@JsonSerializable()
class DjRadioListWrap2 extends ServerStatusBean {
  late List<DjRadio> data;

  DjRadioListWrap2();

  factory DjRadioListWrap2.fromJson(Map<String, dynamic> json) =>
      _$DjRadioListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioListWrap2ToJson(this);
}

@JsonSerializable()
class DjTopListListWrap {
  late List<Dj> list;

  int? total;
  int? updateTime;

  DjTopListListWrap();

  factory DjTopListListWrap.fromJson(Map<String, dynamic> json) =>
      _$DjTopListListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$DjTopListListWrapToJson(this);
}

@JsonSerializable()
class DjTopListListWrapX extends ServerStatusBean {
  late DjTopListListWrap data;

  DjTopListListWrapX();

  factory DjTopListListWrapX.fromJson(Map<String, dynamic> json) =>
      _$DjTopListListWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$DjTopListListWrapXToJson(this);
}

@JsonSerializable()
class DjRadioTopListItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  String? name;
  String? picUrl;
  String? creatorName;

  int? rank;
  int? lastRank;
  int? score;

  // [djRadioPayGiftTopList] 这个api独有数据
  String? rcmdText;
  int? radioFeeType;
  int? feeScope;
  int? programCount;
  int? originalPrice;
  String? alg;
  String? lastProgramName;

  DjRadioTopListItem();

  factory DjRadioTopListItem.fromJson(Map<String, dynamic> json) =>
      _$DjRadioTopListItemFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioTopListItemToJson(this);
}

@JsonSerializable()
class DjRadioTopListListWrap {
  late List<DjRadioTopListItem> list;

  int? total;
  int? updateTime;

  DjRadioTopListListWrap();

  factory DjRadioTopListListWrap.fromJson(Map<String, dynamic> json) =>
      _$DjRadioTopListListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioTopListListWrapToJson(this);
}

@JsonSerializable()
class DjRadioTopListListWrapX extends ServerStatusBean {
  late DjRadioTopListListWrap data;

  DjRadioTopListListWrapX();

  factory DjRadioTopListListWrapX.fromJson(Map<String, dynamic> json) =>
      _$DjRadioTopListListWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioTopListListWrapXToJson(this);
}

@JsonSerializable()
class DjRadioDetail extends ServerStatusBean {
  late DjRadio data;

  DjRadioDetail();

  factory DjRadioDetail.fromJson(Map<String, dynamic> json) =>
      _$DjRadioDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioDetailToJson(this);
}

@JsonSerializable()
class DjRadioTopListListWrapX2 extends ServerStatusBean {
  late List<DjRadio> toplist;

  int? updateTime;

  DjRadioTopListListWrapX2();

  factory DjRadioTopListListWrapX2.fromJson(Map<String, dynamic> json) =>
      _$DjRadioTopListListWrapX2FromJson(json);

  Map<String, dynamic> toJson() => _$DjRadioTopListListWrapX2ToJson(this);
}

@JsonSerializable()
class DjProgramListWrap extends ServerStatusListBean {
  late List<DjProgram> programs;

  String? name;

  DjProgramListWrap();

  factory DjProgramListWrap.fromJson(Map<String, dynamic> json) =>
      _$DjProgramListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramListWrapToJson(this);
}

@JsonSerializable()
class DjProgramTopListItem {
  late DjProgram program;

  int? rank;
  int? lastRank;
  int? score;
  int? programFeeType;

  DjProgramTopListItem();

  factory DjProgramTopListItem.fromJson(Map<String, dynamic> json) =>
      _$DjProgramTopListItemFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramTopListItemToJson(this);
}

@JsonSerializable()
class DjProgramTopListListWrap2 extends ServerStatusBean {
  late List<DjProgramTopListItem> toplist;

  int? updateTime;

  DjProgramTopListListWrap2();

  factory DjProgramTopListListWrap2.fromJson(Map<String, dynamic> json) =>
      _$DjProgramTopListListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramTopListListWrap2ToJson(this);
}

@JsonSerializable()
class PersonalizedDjProgramItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;
  String? copywriter;
  String? picUrl;

  bool? canDislike;

  int? type;

  late DjProgram program;

  PersonalizedDjProgramItem();

  factory PersonalizedDjProgramItem.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedDjProgramItemFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedDjProgramItemToJson(this);
}

@JsonSerializable()
class DjProgramTopListListWrap {
  late List<DjProgramTopListItem> list;

  int? total;
  int? updateTime;

  DjProgramTopListListWrap();

  factory DjProgramTopListListWrap.fromJson(Map<String, dynamic> json) =>
      _$DjProgramTopListListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramTopListListWrapToJson(this);
}

@JsonSerializable()
class DjProgramTopListListWrapX extends ServerStatusBean {
  late DjProgramTopListListWrap data;

  DjProgramTopListListWrapX();

  factory DjProgramTopListListWrapX.fromJson(Map<String, dynamic> json) =>
      _$DjProgramTopListListWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramTopListListWrapXToJson(this);
}

@JsonSerializable()
class PersonalizedDjProgramListWrap extends ServerStatusBean {
  int? category;

  late List<PersonalizedDjProgramItem> result;

  PersonalizedDjProgramListWrap();

  factory PersonalizedDjProgramListWrap.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedDjProgramListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedDjProgramListWrapToJson(this);
}

@JsonSerializable()
class DjProgramDetail extends ServerStatusBean {
  late DjProgram program;

  DjProgramDetail();

  factory DjProgramDetail.fromJson(Map<String, dynamic> json) =>
      _$DjProgramDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DjProgramDetailToJson(this);
}
