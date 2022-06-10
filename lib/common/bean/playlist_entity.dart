import 'dart:convert';
import 'package:bujuan/generated/json/base/json_field.dart';
import 'package:bujuan/generated/json/playlist_entity.g.dart';

@JsonSerializable()
class PlaylistEntity {

	int? code;
	dynamic relatedVideos;
	PlaylistPlaylist? playlist;
	dynamic urls;
	List<PlaylistPrivileges>? privileges;
	dynamic sharedPrivilege;
	dynamic resEntrance;
  
  PlaylistEntity();

  factory PlaylistEntity.fromJson(Map<String, dynamic> json) => $PlaylistEntityFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylist {

	int? id;
	String? name;
	int? coverImgId;
	String? coverImgUrl;
	@JSONField(name: "coverImgId_str")
	String? coverimgidStr;
	int? adType;
	int? userId;
	int? createTime;
	int? status;
	bool? opRecommend;
	bool? highQuality;
	bool? newImported;
	int? updateTime;
	int? trackCount;
	int? specialType;
	int? privacy;
	int? trackUpdateTime;
	String? commentThreadId;
	int? playCount;
	int? trackNumberUpdateTime;
	int? subscribedCount;
	int? cloudTrackCount;
	bool? ordered;
	String? description;
	List<String>? tags;
	dynamic updateFrequency;
	int? backgroundCoverId;
	dynamic backgroundCoverUrl;
	int? titleImage;
	dynamic titleImageUrl;
	dynamic englishTitle;
	dynamic officialPlaylistType;
	List<PlaylistPlaylistSubscribers>? subscribers;
	dynamic subscribed;
	PlaylistPlaylistCreator? creator;
	List<PlaylistPlaylistTracks>? tracks;
	dynamic videoIds;
	dynamic videos;
	List<PlaylistPlaylistTrackIds>? trackIds;
	int? shareCount;
	int? commentCount;
	dynamic remixVideo;
	dynamic sharedUsers;
	dynamic historySharedUsers;
  
  PlaylistPlaylist();

  factory PlaylistPlaylist.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistSubscribers {

	bool? defaultAvatar;
	int? province;
	int? authStatus;
	bool? followed;
	String? avatarUrl;
	int? accountStatus;
	int? gender;
	int? city;
	int? birthday;
	int? userId;
	int? userType;
	String? nickname;
	String? signature;
	String? description;
	String? detailDescription;
	int? avatarImgId;
	int? backgroundImgId;
	String? backgroundUrl;
	int? authority;
	bool? mutual;
	dynamic expertTags;
	dynamic experts;
	int? djStatus;
	int? vipType;
	dynamic remarkName;
	int? authenticationTypes;
	dynamic avatarDetail;
	String? avatarImgIdStr;
	bool? anchor;
	String? backgroundImgIdStr;
	@JSONField(name: "avatarImgId_str")
	String? avatarimgidStr;
  
  PlaylistPlaylistSubscribers();

  factory PlaylistPlaylistSubscribers.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistSubscribersFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistSubscribersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistCreator {

	bool? defaultAvatar;
	int? province;
	int? authStatus;
	bool? followed;
	String? avatarUrl;
	int? accountStatus;
	int? gender;
	int? city;
	int? birthday;
	int? userId;
	int? userType;
	String? nickname;
	String? signature;
	String? description;
	String? detailDescription;
	int? avatarImgId;
	int? backgroundImgId;
	String? backgroundUrl;
	int? authority;
	bool? mutual;
	dynamic expertTags;
	dynamic experts;
	int? djStatus;
	int? vipType;
	dynamic remarkName;
	int? authenticationTypes;
	PlaylistPlaylistCreatorAvatarDetail? avatarDetail;
	String? avatarImgIdStr;
	bool? anchor;
	String? backgroundImgIdStr;
	@JSONField(name: "avatarImgId_str")
	String? avatarimgidStr;
  
  PlaylistPlaylistCreator();

  factory PlaylistPlaylistCreator.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistCreatorFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistCreatorToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistCreatorAvatarDetail {

	int? userType;
	int? identityLevel;
	String? identityIconUrl;
  
  PlaylistPlaylistCreatorAvatarDetail();

  factory PlaylistPlaylistCreatorAvatarDetail.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistCreatorAvatarDetailFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistCreatorAvatarDetailToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracks {

	String? name;
	int? id;
	int? pst;
	int? t;
	List<PlaylistPlaylistTracksAr>? ar;
	List<dynamic>? alia;
	double? pop;
	int? st;
	String? rt;
	int? fee;
	int? v;
	dynamic crbt;
	String? cf;
	PlaylistPlaylistTracksAl? al;
	int? dt;
	PlaylistPlaylistTracksH? h;
	PlaylistPlaylistTracksM? m;
	PlaylistPlaylistTracksL? l;
	PlaylistPlaylistTracksSq? sq;
	dynamic hr;
	dynamic a;
	String? cd;
	int? no;
	dynamic rtUrl;
	int? ftype;
	List<dynamic>? rtUrls;
	int? djId;
	int? copyright;
	@JSONField(name: "s_id")
	int? sId;
	int? mark;
	int? originCoverType;
	dynamic originSongSimpleData;
	dynamic tagPicList;
	bool? resourceState;
	int? version;
	dynamic songJumpInfo;
	dynamic entertainmentTags;
	int? single;
	dynamic noCopyrightRcmd;
	int? rtype;
	dynamic rurl;
	int? mst;
	int? cp;
	int? mv;
	int? publishTime;
  
  PlaylistPlaylistTracks();

  factory PlaylistPlaylistTracks.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracksAr {

	int? id;
	String? name;
	List<dynamic>? tns;
	List<dynamic>? alias;
  
  PlaylistPlaylistTracksAr();

  factory PlaylistPlaylistTracksAr.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksArFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksArToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracksAl {

	int? id;
	String? name;
	String? picUrl;
	List<dynamic>? tns;
	int? pic;
  
  PlaylistPlaylistTracksAl();

  factory PlaylistPlaylistTracksAl.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksAlFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksAlToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracksH {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  PlaylistPlaylistTracksH();

  factory PlaylistPlaylistTracksH.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksHFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksHToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracksM {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  PlaylistPlaylistTracksM();

  factory PlaylistPlaylistTracksM.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksMFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksMToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracksL {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  PlaylistPlaylistTracksL();

  factory PlaylistPlaylistTracksL.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksLFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksLToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTracksSq {

	int? br;
	int? fid;
	int? size;
	double? vd;
	int? sr;
  
  PlaylistPlaylistTracksSq();

  factory PlaylistPlaylistTracksSq.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTracksSqFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTracksSqToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPlaylistTrackIds {

	int? id;

  PlaylistPlaylistTrackIds();

  factory PlaylistPlaylistTrackIds.fromJson(Map<String, dynamic> json) => $PlaylistPlaylistTrackIdsFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPlaylistTrackIdsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPrivileges {

	int? id;
	int? fee;
	int? payed;
	int? realPayed;
	int? st;
	int? pl;
	int? dl;
	int? sp;
	int? cp;
	int? subp;
	bool? cs;
	int? maxbr;
	int? fl;
	dynamic pc;
	bool? toast;
	int? flag;
	bool? paidBigBang;
	bool? preSell;
	int? playMaxbr;
	int? downloadMaxbr;
	String? maxBrLevel;
	String? playMaxBrLevel;
	String? downloadMaxBrLevel;
	String? plLevel;
	String? dlLevel;
	String? flLevel;
	dynamic rscl;
	PlaylistPrivilegesFreeTrialPrivilege? freeTrialPrivilege;
	List<PlaylistPrivilegesChargeInfoList>? chargeInfoList;
  
  PlaylistPrivileges();

  factory PlaylistPrivileges.fromJson(Map<String, dynamic> json) => $PlaylistPrivilegesFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPrivilegesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPrivilegesFreeTrialPrivilege {

	bool? resConsumable;
	bool? userConsumable;
	dynamic listenType;
  
  PlaylistPrivilegesFreeTrialPrivilege();

  factory PlaylistPrivilegesFreeTrialPrivilege.fromJson(Map<String, dynamic> json) => $PlaylistPrivilegesFreeTrialPrivilegeFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPrivilegesFreeTrialPrivilegeToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class PlaylistPrivilegesChargeInfoList {

	int? rate;
	dynamic chargeUrl;
	dynamic chargeMessage;
	int? chargeType;
  
  PlaylistPrivilegesChargeInfoList();

  factory PlaylistPrivilegesChargeInfoList.fromJson(Map<String, dynamic> json) => $PlaylistPrivilegesChargeInfoListFromJson(json);

  Map<String, dynamic> toJson() => $PlaylistPrivilegesChargeInfoListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}