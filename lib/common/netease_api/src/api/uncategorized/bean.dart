import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import '../../../src/api/bean.dart';
import '../../../src/api/event/bean.dart';
import '../../../src/api/play/bean.dart';
import '../../../src/api/user/bean.dart';
import '../../../src/dio_ext.dart';

part 'bean.g.dart';

@JsonSerializable()
class BannerItem {
  String? bannerId;

  late String pic;

  late int targetId;
  late int targetType;

  String? titleColor;
  late String typeTitle;
  String? url;
  String? adurlV2;

  late bool exclusive;

  String? encodeId;

  Song2? song;

  String? alg;
  String? scm;
  String? requestId;

  bool? showAdTag;

  BannerItem();

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);

  Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}

@JsonSerializable()
class BannerListWrap extends ServerStatusBean {
  late List<BannerItem> banners;

  BannerListWrap();

  factory BannerListWrap.fromJson(Map<String, dynamic> json) =>
      _$BannerListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$BannerListWrapToJson(this);
}

@JsonSerializable()
class BannerListWrap2 extends ServerStatusBean {
  late List<BannerItem> data;

  BannerListWrap2();

  factory BannerListWrap2.fromJson(Map<String, dynamic> json) =>
      _$BannerListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$BannerListWrap2ToJson(this);
}

@JsonSerializable()
class PageConfig {
  String? title;

  String? refreshToast;
  String? nodataToast;
  int? refreshInterval;
  int? songLabelMarkLimit;

  bool? fullscreen;

  late List<String> songLabelMarkPriority;
  late List<String> abtest;

  PageConfig();

  factory PageConfig.fromJson(Map<String, dynamic> json) =>
      _$PageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PageConfigToJson(this);
}

@JsonSerializable()
class HomeBlockPageUiElementTitle {
  String? title;

  HomeBlockPageUiElementTitle();

  factory HomeBlockPageUiElementTitle.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageUiElementTitleFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageUiElementTitleToJson(this);
}

@JsonSerializable()
class HomeBlockPageUiElementButton {
  String? action;
  String? actionType;
  String? text;
  String? iconUrl;

  HomeBlockPageUiElementButton();

  factory HomeBlockPageUiElementButton.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageUiElementButtonFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageUiElementButtonToJson(this);
}

@JsonSerializable()
class HomeBlockPageUiElementImage {
  late String imageUrl;

  HomeBlockPageUiElementImage();

  factory HomeBlockPageUiElementImage.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageUiElementImageFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageUiElementImageToJson(this);
}

@JsonSerializable()
class HomeBlockPageUiElement {
  HomeBlockPageUiElementTitle? mainTitle;
  HomeBlockPageUiElementTitle? subTitle;
  HomeBlockPageUiElementButton? button;
  HomeBlockPageUiElementImage? image;

  List<String>? labelTexts;

  HomeBlockPageUiElement();

  factory HomeBlockPageUiElement.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageUiElementFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageUiElementToJson(this);
}

@JsonSerializable()
class HomeBlockPageResourceExt {
  List<Artists>? artists;
  Song? songData;
  Privilege? songPrivilege;
  CommentSimple? commentSimpleData;

  bool? highQuality;
  int? playCount;

  HomeBlockPageResourceExt();

  factory HomeBlockPageResourceExt.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageResourceExtFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageResourceExtToJson(this);
}

@JsonSerializable()
class HomeBlockPageResource {
  String? resourceType;

  String? resourceId;

  String? resourceUrl;

  String? action;
  String? actionType;

  late HomeBlockPageUiElement uiElement;

  late HomeBlockPageResourceExt resourceExtInfo;

  String? alg;

  bool? valid;

  HomeBlockPageResource();

  factory HomeBlockPageResource.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageResourceFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageResourceToJson(this);
}

@JsonSerializable()
class HomeBlockPageCreative {
  String? creativeType;

  String? creativeId;

  String? action;
  String? actionType;

  late HomeBlockPageUiElement uiElement;

  late List<HomeBlockPageResource> resources;

  String? alg;

  int? position;

  HomeBlockPageCreative();

  factory HomeBlockPageCreative.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageCreativeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageCreativeToJson(this);
}

@JsonSerializable()
class HomeBlockPageItem {
  String? blockCode;

  // HOMEPAGE_SLIDE_PLAYLIST  HOMEPAGE_SLIDE_SONGLIST_ALIGN
  String? showType;

  late HomeBlockPageUiElement uiElement;

  List<HomeBlockPageCreative>? creatives;

  dynamic extInfo;

  // orpheus://playlistCollection?referLog=HOMEPAGE_BLOCK_PLAYLIST_RCMD
  String? action;

  // scheme
  String? actionType;

  bool? canClose;

  HomeBlockPageItem();

  factory HomeBlockPageItem.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageItemFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageItemToJson(this);
}

@JsonSerializable()
class HomeBlockPageCursor {
  int? offset;

  late List<String> blockCodeOrderList;

  HomeBlockPageCursor();

  factory HomeBlockPageCursor.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageCursorFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageCursorToJson(this);
}

@JsonSerializable()
class HomeBlockPage {
  bool? hasMore;

  @JsonKey(fromJson: _stringToHomeBlockPageCursor)
  HomeBlockPageCursor? cursor;

  late PageConfig pageConfig;

  late List<HomeBlockPageItem> blocks;

  HomeBlockPage();

  factory HomeBlockPage.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageToJson(this);
}

HomeBlockPageCursor _stringToHomeBlockPageCursor(String value) =>
    HomeBlockPageCursor?.fromJson(json.decode(value));

@JsonSerializable()
class HomeBlockPageWrap extends ServerStatusBean {
  late HomeBlockPage data;

  HomeBlockPageWrap();

  factory HomeBlockPageWrap.fromJson(Map<String, dynamic> json) =>
      _$HomeBlockPageWrapFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBlockPageWrapToJson(this);
}

@JsonSerializable()
class HomeDragonBallItem {
  late int id;
  String? name;

  late String iconUrl;

  String? url;

  bool? skinSupport;

  HomeDragonBallItem();

  factory HomeDragonBallItem.fromJson(Map<String, dynamic> json) =>
      _$HomeDragonBallItemFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDragonBallItemToJson(this);
}

@JsonSerializable()
class HomeDragonBallWrap extends ServerStatusBean {
  late List<HomeDragonBallItem> data;

  HomeDragonBallWrap();

  factory HomeDragonBallWrap.fromJson(Map<String, dynamic> json) =>
      _$HomeDragonBallWrapFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDragonBallWrapToJson(this);
}

@JsonSerializable()
class CountriesCodeItem {
  String? zh;
  String? en;
  String? locale;
  String? code;

  CountriesCodeItem();

  factory CountriesCodeItem.fromJson(Map<String, dynamic> json) =>
      _$CountriesCodeItemFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesCodeItemToJson(this);
}

@JsonSerializable()
class CountriesCodeIndex {
  String? label;
  late List<CountriesCodeItem> countryList;

  CountriesCodeIndex();

  factory CountriesCodeIndex.fromJson(Map<String, dynamic> json) =>
      _$CountriesCodeIndexFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesCodeIndexToJson(this);
}

@JsonSerializable()
class CountriesCodeListWrap extends ServerStatusBean {
  late List<CountriesCodeIndex> data;

  CountriesCodeListWrap();

  factory CountriesCodeListWrap.fromJson(Map<String, dynamic> json) =>
      _$CountriesCodeListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesCodeListWrapToJson(this);
}

@JsonSerializable()
class PersonalizedPrivateContentItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  String? name;
  String? picUrl;
  String? sPicUrl;
  String? copywriter;

  String? alg;

  int? type;

  PersonalizedPrivateContentItem();

  factory PersonalizedPrivateContentItem.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedPrivateContentItemFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedPrivateContentItemToJson(this);
}

@JsonSerializable()
class PersonalizedPrivateContentListWrap extends ServerStatusBean {
  late List<PersonalizedPrivateContentItem> result;

  PersonalizedPrivateContentListWrap();

  factory PersonalizedPrivateContentListWrap.fromJson(
          Map<String, dynamic> json) =>
      _$PersonalizedPrivateContentListWrapFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PersonalizedPrivateContentListWrapToJson(this);
}

@JsonSerializable()
class TopListTrack {
  String? first;
  String? second;

  TopListTrack();

  factory TopListTrack.fromJson(Map<String, dynamic> json) =>
      _$TopListTrackFromJson(json);

  Map<String, dynamic> toJson() => _$TopListTrackToJson(this);
}

@JsonSerializable()
class TopList {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  @JsonKey(fromJson: dynamicToString)
  String? userId;

  late List<NeteaseUserInfo> subscribers;

  List<TopListTrack>? tracks;

  String? name;
  String? englishTitle;
  String? titleImageUrl;
  String? updateFrequency;
  String? backgroundCoverUrl;
  String? coverImgUrl;
  String? description;
  String? commentThreadId;
  String? ToplistType;

  late int adType;
  int? status;
  int? privacy;
  int? subscribedCount;
  int? playCount;
  int? createTime;
  int? updateTime;
  int? totalDuration;
  int? specialType;

  int? cloudTrackCount;
  int? trackNumberUpdateTime;
  int? trackUpdateTime;
  int? trackCount;

  bool? opRecommend;
  String? recommendInfo;
  bool? ordered;
  bool? highQuality;
  bool? newImported;
  bool? anonimous;

  late List<String> tags;

  TopList();

  factory TopList.fromJson(Map<String, dynamic> json) =>
      _$TopListFromJson(json);

  Map<String, dynamic> toJson() => _$TopListToJson(this);
}

@JsonSerializable()
class ArtistTopListArtists {
  String? first;
  String? second;

  int? third;

  ArtistTopListArtists();

  factory ArtistTopListArtists.fromJson(Map<String, dynamic> json) =>
      _$ArtistTopListArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistTopListArtistsToJson(this);
}

@JsonSerializable()
class ArtistTopList {
  int? position;

  String? coverUrl;
  String? name;
  String? upateFrequency;
  String? updateFrequency;

  List<ArtistTopListArtists>? artists;

  ArtistTopList();

  factory ArtistTopList.fromJson(Map<String, dynamic> json) =>
      _$ArtistTopListFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistTopListToJson(this);
}

@JsonSerializable()
class RewardTopList {
  int? position;

  String? coverUrl;

  late List<Song> songs;

  RewardTopList();

  factory RewardTopList.fromJson(Map<String, dynamic> json) =>
      _$RewardTopListFromJson(json);

  Map<String, dynamic> toJson() => _$RewardTopListToJson(this);
}

@JsonSerializable()
class TopListWrap extends ServerStatusBean {
  late List<TopList> list;
  late ArtistTopList artistToplist;

  TopListWrap();

  factory TopListWrap.fromJson(Map<String, dynamic> json) =>
      _$TopListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$TopListWrapToJson(this);
}

@JsonSerializable()
class TopListDetailWrap extends ServerStatusBean {
  late List<TopList> list;
  late ArtistTopList artistToplist;
  late RewardTopList rewardToplist;

  TopListDetailWrap();

  factory TopListDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$TopListDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$TopListDetailWrapToJson(this);
}

@JsonSerializable()
class McalendarDetailEvent {
  late String id;
  String? eventType;
  int? onlineTime;
  int? offlineTime;
  late String imgUrl;
  String? targetUrl;
  String? tag;
  String? title;
  bool? canRemind;
  bool? reminded;
  String? remindText;
  String? resourceId;
  String? resourceType;
  String? eventStatus;
  String? remindedText;

  McalendarDetailEvent();

  factory McalendarDetailEvent.fromJson(Map<String, dynamic> json) =>
      _$McalendarDetailEventFromJson(json);

  Map<String, dynamic> toJson() => _$McalendarDetailEventToJson(this);
}

@JsonSerializable()
class McalendarDetail {
  late List<McalendarDetailEvent> calendarEvents;

  McalendarDetail();

  factory McalendarDetail.fromJson(Map<String, dynamic> json) =>
      _$McalendarDetailFromJson(json);

  Map<String, dynamic> toJson() => _$McalendarDetailToJson(this);
}

@JsonSerializable()
class McalendarDetailWrap extends ServerStatusBean {
  late McalendarDetail data;

  McalendarDetailWrap();

  factory McalendarDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$McalendarDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$McalendarDetailWrapToJson(this);
}

@JsonSerializable()
class AudioMatchResult {
  int? startTime;
  late Song song;

  AudioMatchResult();

  factory AudioMatchResult.fromJson(Map<String, dynamic> json) =>
      _$AudioMatchResultFromJson(json);

  Map<String, dynamic> toJson() => _$AudioMatchResultToJson(this);
}

@JsonSerializable()
class AudioMatchResultData {
  int? type;

  late List<AudioMatchResult> result;

  AudioMatchResultData();

  factory AudioMatchResultData.fromJson(Map<String, dynamic> json) =>
      _$AudioMatchResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$AudioMatchResultDataToJson(this);
}

@JsonSerializable()
class AudioMatchResultWrap extends ServerStatusBean {
  late AudioMatchResultData data;

  AudioMatchResultWrap();

  factory AudioMatchResultWrap.fromJson(Map<String, dynamic> json) =>
      _$AudioMatchResultWrapFromJson(json);

  Map<String, dynamic> toJson() => _$AudioMatchResultWrapToJson(this);
}

@JsonSerializable()
class ListenTogetherStatusData {
  late bool inRoom;
  dynamic roomInfo;
  dynamic status;

  ListenTogetherStatusData();

  factory ListenTogetherStatusData.fromJson(Map<String, dynamic> json) =>
      _$ListenTogetherStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListenTogetherStatusDataToJson(this);
}

@JsonSerializable()
class ListenTogetherStatusWrap extends ServerStatusBean {
  late ListenTogetherStatusData data;

  ListenTogetherStatusWrap();

  factory ListenTogetherStatusWrap.fromJson(Map<String, dynamic> json) =>
      _$ListenTogetherStatusWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ListenTogetherStatusWrapToJson(this);
}

@JsonSerializable()
class UploadImageAlloc {
  late String bucket;
  late String docId;
  late String objectKey;
  late String token;

  UploadImageAlloc();

  factory UploadImageAlloc.fromJson(Map<String, dynamic> json) =>
      _$UploadImageAllocFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageAllocToJson(this);
}

@JsonSerializable()
class UploadImageAllocWrap extends ServerStatusBean {
  late UploadImageAlloc result;

  UploadImageAllocWrap();

  factory UploadImageAllocWrap.fromJson(Map<String, dynamic> json) =>
      _$UploadImageAllocWrapFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageAllocWrapToJson(this);
}

@JsonSerializable()
class UploadImageResult extends ServerStatusBean {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? url;

  UploadImageResult();

  factory UploadImageResult.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResultFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResultToJson(this);
}

class BatchApiWrap extends ServerStatusBean {
  late Map<String, dynamic> data;

  BatchApiWrap();

  dynamic findResponseData<T>(DioMetaData metaData) {
    return data[metaData.uri.path];
  }

  factory BatchApiWrap.fromJson(Map<String, dynamic> json) {
    return BatchApiWrap()
      ..code = json['code'] as int
      ..message = json['message'] as String?
      ..msg = json['msg'] as String?
      ..data = json;
  }
}
