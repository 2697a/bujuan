import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import '../../../netease_music_api.dart';
import '../../../src/api/bean.dart';
import '../../../src/api/login/bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class CommentThread {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  int? resourceType;
  int? commentCount;
  int? likedCount;
  int? shareCount;
  int? hotCount;

  int? resourceId;
  int? resourceOwnerId;
  String? resourceTitle;

  CommentThread();

  factory CommentThread.fromJson(Map<String, dynamic> json) =>
      _$CommentThreadFromJson(json);

  Map<String, dynamic> toJson() => _$CommentThreadToJson(this);
}

@JsonSerializable()
class EventItemInfo {
  late String threadId;

  int? resourceId;
  int? resourceType;

  bool? liked;
  int? commentCount;
  int? likedCount;
  int? shareCount;

  late CommentThread commentThread;

  EventItemInfo();

  factory EventItemInfo.fromJson(Map<String, dynamic> json) =>
      _$EventItemInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EventItemInfoToJson(this);
}

@JsonSerializable()
class EventItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? actName;
  String? json;

  int? type;

  int? actId;
  int? eventTime;
  int? expireTime;
  int? showTime;
  int? forwardCount;
  int? sic;

  late int insiteForwardCount;

  bool? topEvent;

  late NeteaseAccountProfile user;

  late EventItemInfo info;

  EventItem();

  factory EventItem.fromJson(Map<String, dynamic> json) =>
      _$EventItemFromJson(json);

  Map<String, dynamic> toJson() => _$EventItemToJson(this);
}

@JsonSerializable()
class EventListWrap extends ServerStatusBean {
  List<EventItem>? events;

  int? lasttime;

  EventListWrap();

  factory EventListWrap.fromJson(Map<String, dynamic> json) =>
      _$EventListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$EventListWrapToJson(this);
}

@JsonSerializable()
class EventListWrap2 extends ServerStatusBean {
  List<EventItem>? event;

  int? lasttime;

  EventListWrap2();

  factory EventListWrap2.fromJson(Map<String, dynamic> json) =>
      _$EventListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$EventListWrap2ToJson(this);
}

@JsonSerializable()
class EventSingleWrap extends ServerStatusBean {
  late EventItem event;

  EventSingleWrap();

  factory EventSingleWrap.fromJson(Map<String, dynamic> json) =>
      _$EventSingleWrapFromJson(json);

  Map<String, dynamic> toJson() => _$EventSingleWrapToJson(this);
}

@JsonSerializable()
class CommentItemBase {
  @JsonKey(fromJson: dynamicToString)
  late String commentId;

  @JsonKey(fromJson: dynamicToString)
  String? parentCommentId;

  late NeteaseUserInfo user;

  List<BeRepliedCommentItem>? beReplied;

  String? content;

  int? time;
  String? timeStr;

  int? likedCount;
  int? replyCount;

  bool? liked;

  // beReplied

  int? status;
  int? commentLocationType;

  CommentItemBase();

  factory CommentItemBase.fromJson(Map<String, dynamic> json) =>
      _$CommentItemBaseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemBaseToJson(this);
}

@JsonSerializable()
class CommentItem extends CommentItemBase {
  List<BeRepliedCommentItem>? beReplied;

  CommentItem();

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
}

@JsonSerializable()
class BeRepliedCommentItem extends CommentItemBase {
  @JsonKey(fromJson: dynamicToString)
  String? beRepliedCommentId;

  BeRepliedCommentItem();

  factory BeRepliedCommentItem.fromJson(Map<String, dynamic> json) =>
      _$BeRepliedCommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$BeRepliedCommentItemToJson(this);
}

@JsonSerializable()
class CommentListWrap extends ServerStatusListBean {
  bool? moreHot;
  int? cnum;
  bool? isMusician;

  @JsonKey(fromJson: dynamicToString)
  String? userId;

  List<CommentItem>? topComments;
  List<CommentItem>? hotComments;
  List<CommentItem>? comments;

  CommentListWrap();

  factory CommentListWrap.fromJson(Map<String, dynamic> json) =>
      _$CommentListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$CommentListWrapToJson(this);
}

@JsonSerializable()
class CommentHistoryData {
  bool? hasMore;
  bool? reminder;

  int? commentCount;

  List<CommentItem>? hotComments;
  List<CommentItem>? comments;

  CommentHistoryData();

  factory CommentHistoryData.fromJson(Map<String, dynamic> json) =>
      _$CommentHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentHistoryDataToJson(this);
}

@JsonSerializable()
class CommentHistoryWrap extends ServerStatusBean {
  late CommentHistoryData data;

  CommentHistoryWrap();

  factory CommentHistoryWrap.fromJson(Map<String, dynamic> json) =>
      _$CommentHistoryWrapFromJson(json);

  Map<String, dynamic> toJson() => _$CommentHistoryWrapToJson(this);
}

@JsonSerializable()
class CommentList2DataSortType {
  int? sortType;
  String? sortTypeName;
  String? target;

  CommentList2DataSortType();

  factory CommentList2DataSortType.fromJson(Map<String, dynamic> json) =>
      _$CommentList2DataSortTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CommentList2DataSortTypeToJson(this);
}

@JsonSerializable()
class CommentList2Data {
  bool? hasMore;

  String? cursor;
  int? totalCount;
  int? sortType;
  List<CommentList2DataSortType>? sortTypeList;

  List<CommentItem>? comments;
  CommentItem? currentComment;

  CommentList2Data();

  factory CommentList2Data.fromJson(Map<String, dynamic> json) =>
      _$CommentList2DataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentList2DataToJson(this);
}

@JsonSerializable()
class CommentList2Wrap extends ServerStatusBean {
  late CommentList2Data data;

  CommentList2Wrap();

  factory CommentList2Wrap.fromJson(Map<String, dynamic> json) =>
      _$CommentList2WrapFromJson(json);

  Map<String, dynamic> toJson() => _$CommentList2WrapToJson(this);
}

@JsonSerializable()
class HugComment {
  late NeteaseUserInfo user;
  String? hugContent;

  HugComment();

  factory HugComment.fromJson(Map<String, dynamic> json) =>
      _$HugCommentFromJson(json);

  Map<String, dynamic> toJson() => _$HugCommentToJson(this);
}

@JsonSerializable()
class HugCommentListData {
  bool? hasMore;

  String? cursor;
  int? idCursor;
  int? hugTotalCounts;

  List<HugComment>? hugComments;
  late CommentItem currentComment;

  HugCommentListData();

  factory HugCommentListData.fromJson(Map<String, dynamic> json) =>
      _$HugCommentListDataFromJson(json);

  Map<String, dynamic> toJson() => _$HugCommentListDataToJson(this);
}

@JsonSerializable()
class HugCommentListWrap extends ServerStatusBean {
  late HugCommentListData data;

  HugCommentListWrap();

  factory HugCommentListWrap.fromJson(Map<String, dynamic> json) =>
      _$HugCommentListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$HugCommentListWrapToJson(this);
}

@JsonSerializable()
class FloorCommentDetail {
  List<CommentItem>? comments;

  bool? hasMore;
  int? totalCount;
  int? time;

  late CommentItem ownerComment;

  FloorCommentDetail();

  factory FloorCommentDetail.fromJson(Map<String, dynamic> json) =>
      _$FloorCommentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FloorCommentDetailToJson(this);
}

@JsonSerializable()
class FloorCommentDetailWrap extends ServerStatusBean {
  late FloorCommentDetail data;

  FloorCommentDetailWrap();

  factory FloorCommentDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$FloorCommentDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$FloorCommentDetailWrapToJson(this);
}

@JsonSerializable()
class EventForwardRet {
  String? msg;
  late int eventId;
  int? eventTime;

  EventForwardRet();

  factory EventForwardRet.fromJson(Map<String, dynamic> json) =>
      _$EventForwardRetFromJson(json);

  Map<String, dynamic> toJson() => _$EventForwardRetToJson(this);
}

@JsonSerializable()
class EventForwardRetWrap extends ServerStatusBean {
  EventForwardRet? data;

  EventForwardRetWrap();

  factory EventForwardRetWrap.fromJson(Map<String, dynamic> json) =>
      _$EventForwardRetWrapFromJson(json);

  Map<String, dynamic> toJson() => _$EventForwardRetWrapToJson(this);
}

@JsonSerializable()
class TopicContent {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  int? type;

  String? content;

  TopicContent();

  factory TopicContent.fromJson(Map<String, dynamic> json) =>
      _$TopicContentFromJson(json);

  Map<String, dynamic> toJson() => _$TopicContentToJson(this);
}

@JsonSerializable()
class Topic {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  @JsonKey(fromJson: dynamicToString)
  String? userId;

  List<TopicContent>? content;
  String? title;
  String? wxTitle;
  String? mainTitle;
  String? startText;
  String? summary;
  late String adInfo;
  String? recomdTitle;
  String? recomdContent;

  late int addTime;
  int? pubTime;
  int? updateTime;

  int? cover;
  int? headPic;
  int? status;
  int? seriesId;
  int? categoryId;
  double? hotScore;

  String? auditor;
  int? auditTime;
  int? auditStatus;
  String? delReason;

  int? number;
  int? readCount;

  int? rectanglePic;

  List<String>? tags;

  bool? reward;
  bool? fromBackend;
  bool? showRelated;
  bool? showComment;
  bool? pubImmidiatly;

  Topic();

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class TopicItem2 {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  late Topic topic;

  late NeteaseUserInfo creator;

  int? number;
  int? shareCount;
  int? commentCount;
  int? likedCount;
  int? readCount;
  int? rewardCount;
  double? rewardMoney;

  String? rectanglePicUrl;
  String? coverUrl;

  int? seriesId;
  int? categoryId;
  String? categoryName;

  String? url;
  String? wxTitle;
  String? mainTitle;
  String? title;
  String? summary;
  String? shareContent;
  String? recmdTitle;
  String? recmdContent;

  List<String>? tags;

  late int addTime;

  String? commentThreadId;

  bool? showRelated;
  bool? showComment;
  bool? reward;
  bool? liked;

  TopicItem2();

  factory TopicItem2.fromJson(Map<String, dynamic> json) =>
      _$TopicItem2FromJson(json);

  Map<String, dynamic> toJson() => _$TopicItem2ToJson(this);
}

@JsonSerializable()
class TopicItem {
  @JsonKey(fromJson: dynamicToString)
  late String actId;

  String? title;

  List<String>? text;

  String? reason;

  int? participateCount;

  late bool isDefaultImg;

  //featured TopicQualityScore
  String? alg;

  int? startTime;

  int? endTime;

  int? resourceType;

  int? videoType;

  int? topicType;

  int? meetingBeginTime;

  int? meetingEndTime;

  String? coverPCLongUrl;

  String? sharePicUrl;

  String? coverPCUrl;

  String? coverMobileUrl;

  String? coverPCListUrl;

  TopicItem();

  factory TopicItem.fromJson(Map<String, dynamic> json) =>
      _$TopicItemFromJson(json);

  Map<String, dynamic> toJson() => _$TopicItemToJson(this);
}

@JsonSerializable()
class TopicHotListWrap extends ServerStatusBean {
  List<TopicItem>? hot;

  TopicHotListWrap();

  factory TopicHotListWrap.fromJson(Map<String, dynamic> json) =>
      _$TopicHotListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$TopicHotListWrapToJson(this);
}

@JsonSerializable()
class TopicDetailWrap extends ServerStatusBean {
  late TopicItem act;

  bool? needBeginNotify;

  TopicDetailWrap();

  factory TopicDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$TopicDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$TopicDetailWrapToJson(this);
}

@JsonSerializable()
class SimpleResourceInfo {
  @JsonKey(fromJson: dynamicToString)
  String? songId;

  String? threadId;

  String? songCoverUrl;

  String? name;

  late Song song;

  SimpleResourceInfo();

  factory SimpleResourceInfo.fromJson(Map<String, dynamic> json) =>
      _$SimpleResourceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleResourceInfoToJson(this);
}

@JsonSerializable()
class HotwallCommentItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? threadId;

  String? content;

  int? time;

  bool? liked;

  int? likedCount;
  int? replyCount;

  late NeteaseSimpleUserInfo simpleUserInfo;

  late SimpleResourceInfo simpleResourceInfo;

  HotwallCommentItem();

  factory HotwallCommentItem.fromJson(Map<String, dynamic> json) =>
      _$HotwallCommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$HotwallCommentItemToJson(this);
}

@JsonSerializable()
class HotwallCommentListWrap extends ServerStatusBean {
  List<HotwallCommentItem>? data;

  HotwallCommentListWrap();

  factory HotwallCommentListWrap.fromJson(Map<String, dynamic> json) =>
      _$HotwallCommentListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$HotwallCommentListWrapToJson(this);
}

@JsonSerializable()
class CommentSimple {
  @JsonKey(fromJson: dynamicToString)
  String? commentId;

  String? content;

  String? threadId;

  @JsonKey(fromJson: dynamicToString)
  String? userId;

  String? userName;

  CommentSimple();

  factory CommentSimple.fromJson(Map<String, dynamic> json) =>
      _$CommentSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$CommentSimpleToJson(this);
}

@JsonSerializable()
class Comment {
  @JsonKey(fromJson: dynamicToString)
  late String commentId;

  late NeteaseUserInfo user;
  NeteaseUserInfo? beRepliedUser;

  String? expressionUrl;

  int? commentLocationType;

  int? time;

  String? content;

  Comment();

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CommentWrap extends ServerStatusBean {
  Comment? comment;

  CommentWrap();

  factory CommentWrap.fromJson(Map<String, dynamic> json) =>
      _$CommentWrapFromJson(json);

  Map<String, dynamic> toJson() => _$CommentWrapToJson(this);
}

@JsonSerializable()
class MsgPromotion {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? title;
  String? coverUrl;
  String? text;
  String? url;

  late int addTime;

  MsgPromotion();

  factory MsgPromotion.fromJson(Map<String, dynamic> json) =>
      _$MsgPromotionFromJson(json);

  Map<String, dynamic> toJson() => _$MsgPromotionToJson(this);
}

@JsonSerializable()
class MsgGeneral {
  String? title;
  String? subTitle;
  String? tag;
  String? subTag;
  String? noticeMsg;
  late String inboxBriefContent;
  String? webUrl;
  String? nativeUrl;
  String? cover;
  String? resName;

  int? channel;
  int? subType;
  bool? canPlay;

  MsgGeneral();

  factory MsgGeneral.fromJson(Map<String, dynamic> json) =>
      _$MsgGeneralFromJson(json);

  Map<String, dynamic> toJson() => _$MsgGeneralToJson(this);
}

@JsonSerializable()
class MsgContent {
  String? msg;
  String? title;
  String? pushMsg;
  int? type;
  int? resType;

  bool? newPub;

  // type={6} ~

  //type={12}
  MsgPromotion? promotionUrl;

  //type={23}
  MsgGeneral? generalMsg;

  //type={7}
  Mv3? mv;

  MsgContent();

  factory MsgContent.fromJson(Map<String, dynamic> json) =>
      _$MsgContentFromJson(json);

  Map<String, dynamic> toJson() => _$MsgContentToJson(this);
}

@JsonSerializable()
class Msg {
  late NeteaseUserInfo fromUser;
  late NeteaseUserInfo toUser;

  String? lastMsg;

  bool? noticeAccountFlag;

  int? lastMsgTime;
  int? newMsgCount;

  MsgContent get msgObj {
    return MsgContent.fromJson(jsonDecode(lastMsg ?? ''));
  }

  Msg();

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}

@JsonSerializable()
class Msg2 {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  late NeteaseUserInfo fromUser;
  late NeteaseUserInfo toUser;

  String? msg;

  int? time;
  int? batchId;

  MsgContent get msgObj {
    return MsgContent.fromJson(jsonDecode(msg ?? ''));
  }

  Msg2();

  factory Msg2.fromJson(Map<String, dynamic> json) => _$Msg2FromJson(json);

  Map<String, dynamic> toJson() => _$Msg2ToJson(this);
}

@JsonSerializable()
class UsersMsgListWrap extends ServerStatusBean {
  List<Msg>? msgs;

  UsersMsgListWrap();

  factory UsersMsgListWrap.fromJson(Map<String, dynamic> json) =>
      _$UsersMsgListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$UsersMsgListWrapToJson(this);
}

@JsonSerializable()
class RecentContactUsersData {
  List<NeteaseAccountProfile>? follow;

  RecentContactUsersData();

  factory RecentContactUsersData.fromJson(Map<String, dynamic> json) =>
      _$RecentContactUsersDataFromJson(json);

  Map<String, dynamic> toJson() => _$RecentContactUsersDataToJson(this);
}

@JsonSerializable()
class RecentContactUsersWrap extends ServerStatusBean {
  late RecentContactUsersData data;

  RecentContactUsersWrap();

  factory RecentContactUsersWrap.fromJson(Map<String, dynamic> json) =>
      _$RecentContactUsersWrapFromJson(json);

  Map<String, dynamic> toJson() => _$RecentContactUsersWrapToJson(this);
}

@JsonSerializable()
class UserMsgListWrap extends ServerStatusBean {
  List<Msg2>? msgs;

  late bool isArtist;
  late bool isSubed;
  bool? more;

  UserMsgListWrap();

  factory UserMsgListWrap.fromJson(Map<String, dynamic> json) =>
      _$UserMsgListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$UserMsgListWrapToJson(this);
}

@JsonSerializable()
class UserMsgListWrap2 extends ServerStatusBean {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  List<Msg2>? newMsgs;

  //sendblacklist
  //blacklist

  UserMsgListWrap2();

  factory UserMsgListWrap2.fromJson(Map<String, dynamic> json) =>
      _$UserMsgListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$UserMsgListWrap2ToJson(this);
}

@JsonSerializable()
class Cover {
  int? width;
  int? height;
  String? url;

  Cover();

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);

  Map<String, dynamic> toJson() => _$CoverToJson(this);
}

@JsonSerializable()
class Talk {
  @JsonKey(fromJson: dynamicToString)
  String? talkId;
  String? talkName;
  String? talkDes;
  late Cover shareCover;
  late Cover showCover;

  int? status;
  int? mlogCount;
  int? follows;
  int? participations;
  int? showParticipations;
  late bool isFollow;

  String? alg;

  Talk();

  factory Talk.fromJson(Map<String, dynamic> json) => _$TalkFromJson(json);

  Map<String, dynamic> toJson() => _$TalkToJson(this);
}

@JsonSerializable()
class MyLogBaseData {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  int? pubTime;
  int? type;

  String? coverUrl;
  int? coverWidth;
  int? coverHeight;
  int? coverColor;

  Talk? talk;

  String? text;

  MyLogBaseData();

  factory MyLogBaseData.fromJson(Map<String, dynamic> json) =>
      _$MyLogBaseDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyLogBaseDataToJson(this);
}

@JsonSerializable()
class MyLogResourceExt {
  int? likedCount;
  int? commentCount;

  MyLogResourceExt();

  factory MyLogResourceExt.fromJson(Map<String, dynamic> json) =>
      _$MyLogResourceExtFromJson(json);

  Map<String, dynamic> toJson() => _$MyLogResourceExtToJson(this);
}

@JsonSerializable()
class MyLogResource {
  late MyLogBaseData mlogBaseData;
  late MyLogResourceExt mlogExtVO;
  NeteaseAccountProfile? userProfile;

  int? status;
  String? shareUrl;

  MyLogResource();

  factory MyLogResource.fromJson(Map<String, dynamic> json) =>
      _$MyLogResourceFromJson(json);

  Map<String, dynamic> toJson() => _$MyLogResourceToJson(this);
}

@JsonSerializable()
class MyLog {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  int? type;

  late MyLogResource resource;

  String? alg;
  String? reason;
  int? matchField;
  String? matchFieldContent;
  bool? sameCity;

  MyLog();

  factory MyLog.fromJson(Map<String, dynamic> json) => _$MyLogFromJson(json);

  Map<String, dynamic> toJson() => _$MyLogToJson(this);
}

@JsonSerializable()
class MyLogMyLikeData {
  List<MyLogResource>? feeds;

  int? time;
  bool? more;

  MyLogMyLikeData();

  factory MyLogMyLikeData.fromJson(Map<String, dynamic> json) =>
      _$MyLogMyLikeDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyLogMyLikeDataToJson(this);
}

@JsonSerializable()
class MyLogMyLikeWrap extends ServerStatusBean {
  late MyLogMyLikeData data;

  MyLogMyLikeWrap();

  factory MyLogMyLikeWrap.fromJson(Map<String, dynamic> json) =>
      _$MyLogMyLikeWrapFromJson(json);

  Map<String, dynamic> toJson() => _$MyLogMyLikeWrapToJson(this);
}
