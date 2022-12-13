// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSetting _$UserSettingFromJson(Map<String, dynamic> json) {
  return UserSetting()
    ..userId = dynamicToString(json['userId'])
    ..profileSetting = json['profileSetting'] as int?
    ..ageSetting = json['ageSetting'] as int?
    ..areaSetting = json['areaSetting'] as int?
    ..collegeSetting = json['collegeSetting'] as int?
    ..villageAgeSetting = json['villageAgeSetting'] as int?
    ..followSingerSetting = json['followSingerSetting'] as int?
    ..personalServiceSetting = json['personalServiceSetting'] as int?
    ..concertSetting = json['concertSetting'] as int?
    ..socialSetting = json['socialSetting'] as int?
    ..shareSetting = json['shareSetting'] as int?
    ..playRecordSetting = json['playRecordSetting'] as int?
    ..broadcastSetting = json['broadcastSetting'] as int?
    ..commentSetting = json['commentSetting'] as int?
    ..phoneFriendSetting = json['phoneFriendSetting'] as bool?
    ..allowFollowedCanSeeMyPlayRecord =
        json['allowFollowedCanSeeMyPlayRecord'] as bool?
    ..finishedFollowGuide = json['finishedFollowGuide'] as bool?
    ..allowOfflinePrivateMessageNotify =
        json['allowOfflinePrivateMessageNotify'] as bool?
    ..allowOfflineForwardNotify = json['allowOfflineForwardNotify'] as bool?
    ..allowOfflineCommentNotify = json['allowOfflineCommentNotify'] as bool?
    ..allowOfflineCommentReplyNotify =
        json['allowOfflineCommentReplyNotify'] as bool?
    ..allowOfflineNotify = json['allowOfflineNotify'] as bool?
    ..allowVideoSubscriptionNotify =
        json['allowVideoSubscriptionNotify'] as bool?
    ..sendMiuiMsg = json['sendMiuiMsg'] as bool?
    ..allowImportDoubanPlaylist = json['allowImportDoubanPlaylist'] as bool?
    ..importedDoubanPlaylist = json['importedDoubanPlaylist'] as bool
    ..importedXiamiPlaylist = json['importedXiamiPlaylist'] as bool
    ..allowImportXiamiPlaylist = json['allowImportXiamiPlaylist'] as bool?
    ..allowSubscriptionNotify = json['allowSubscriptionNotify'] as bool?
    ..allowLikedNotify = json['allowLikedNotify'] as bool?
    ..allowNewFollowerNotify = json['allowNewFollowerNotify'] as bool?
    ..needRcmdEvent = json['needRcmdEvent'] as bool?
    ..allowPlaylistShareNotify = json['allowPlaylistShareNotify'] as bool?
    ..allowDJProgramShareNotify = json['allowDJProgramShareNotify'] as bool?
    ..allowDJRadioSubscriptionNotify =
        json['allowDJRadioSubscriptionNotify'] as bool?
    ..allowPeopleCanSeeMyPlaynNotify =
        json['allowPeopleCanSeeMyPlaynNotify'] as bool?
    ..peopleNearbyCanSeeMe = json['peopleNearbyCanSeeMe'] as bool?
    ..allowDJProgramSubscriptionNotify =
        json['allowDJProgramSubscriptionNotify'] as bool?;
}

Map<String, dynamic> _$UserSettingToJson(UserSetting instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'profileSetting': instance.profileSetting,
      'ageSetting': instance.ageSetting,
      'areaSetting': instance.areaSetting,
      'collegeSetting': instance.collegeSetting,
      'villageAgeSetting': instance.villageAgeSetting,
      'followSingerSetting': instance.followSingerSetting,
      'personalServiceSetting': instance.personalServiceSetting,
      'concertSetting': instance.concertSetting,
      'socialSetting': instance.socialSetting,
      'shareSetting': instance.shareSetting,
      'playRecordSetting': instance.playRecordSetting,
      'broadcastSetting': instance.broadcastSetting,
      'commentSetting': instance.commentSetting,
      'phoneFriendSetting': instance.phoneFriendSetting,
      'allowFollowedCanSeeMyPlayRecord':
          instance.allowFollowedCanSeeMyPlayRecord,
      'finishedFollowGuide': instance.finishedFollowGuide,
      'allowOfflinePrivateMessageNotify':
          instance.allowOfflinePrivateMessageNotify,
      'allowOfflineForwardNotify': instance.allowOfflineForwardNotify,
      'allowOfflineCommentNotify': instance.allowOfflineCommentNotify,
      'allowOfflineCommentReplyNotify': instance.allowOfflineCommentReplyNotify,
      'allowOfflineNotify': instance.allowOfflineNotify,
      'allowVideoSubscriptionNotify': instance.allowVideoSubscriptionNotify,
      'sendMiuiMsg': instance.sendMiuiMsg,
      'allowImportDoubanPlaylist': instance.allowImportDoubanPlaylist,
      'importedDoubanPlaylist': instance.importedDoubanPlaylist,
      'importedXiamiPlaylist': instance.importedXiamiPlaylist,
      'allowImportXiamiPlaylist': instance.allowImportXiamiPlaylist,
      'allowSubscriptionNotify': instance.allowSubscriptionNotify,
      'allowLikedNotify': instance.allowLikedNotify,
      'allowNewFollowerNotify': instance.allowNewFollowerNotify,
      'needRcmdEvent': instance.needRcmdEvent,
      'allowPlaylistShareNotify': instance.allowPlaylistShareNotify,
      'allowDJProgramShareNotify': instance.allowDJProgramShareNotify,
      'allowDJRadioSubscriptionNotify': instance.allowDJRadioSubscriptionNotify,
      'allowPeopleCanSeeMyPlaynNotify': instance.allowPeopleCanSeeMyPlaynNotify,
      'peopleNearbyCanSeeMe': instance.peopleNearbyCanSeeMe,
      'allowDJProgramSubscriptionNotify':
          instance.allowDJProgramSubscriptionNotify,
    };

UserSettingWrap _$UserSettingWrapFromJson(Map<String, dynamic> json) {
  return UserSettingWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..setting = UserSetting.fromJson(json['setting'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserSettingWrapToJson(UserSettingWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'setting': instance.setting,
    };

NeteaseSimpleUserInfo _$NeteaseSimpleUserInfoFromJson(
    Map<String, dynamic> json) {
  return NeteaseSimpleUserInfo()
    ..userId = dynamicToString(json['userId'])
    ..nickname = json['nickname'] as String?
    ..avatar = json['avatar'] as String?
    ..followed = json['followed'] as bool?;
}

Map<String, dynamic> _$NeteaseSimpleUserInfoToJson(
        NeteaseSimpleUserInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'followed': instance.followed,
    };

NeteaseUserInfo _$NeteaseUserInfoFromJson(Map<String, dynamic> json) {
  return NeteaseUserInfo()
    ..userId = dynamicToString(json['userId'])
    ..nickname = json['nickname'] as String?
    ..avatarUrl = json['avatarUrl'] as String?
    ..backgroundUrl = json['backgroundUrl'] as String?
    ..signature = json['signature'] as String?
    ..description = json['description'] as String?
    ..detailDescription = json['detailDescription'] as String?
    ..recommendReason = json['recommendReason'] as String?
    ..gender = json['gender'] as int?
    ..authority = json['authority'] as int?
    ..birthday = json['birthday'] as int?
    ..city = json['city'] as int?
    ..province = json['province'] as int?
    ..vipType = json['vipType'] as int?
    ..authenticationTypes = json['authenticationTypes'] as int?
    ..authStatus = json['authStatus'] as int?
    ..djStatus = json['djStatus'] as int?
    ..accountStatus = json['accountStatus'] as int?
    ..expertTags =
        (json['expertTags'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..alg = json['alg'] as String?
    ..followed = json['followed'] as bool?
    ..mutual = json['mutual'] as bool?
    ..anchor = json['anchor'] as bool?
    ..defaultAvatar = json['defaultAvatar'] as bool?;
}

Map<String, dynamic> _$NeteaseUserInfoToJson(NeteaseUserInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'backgroundUrl': instance.backgroundUrl,
      'signature': instance.signature,
      'description': instance.description,
      'detailDescription': instance.detailDescription,
      'recommendReason': instance.recommendReason,
      'gender': instance.gender,
      'authority': instance.authority,
      'birthday': instance.birthday,
      'city': instance.city,
      'province': instance.province,
      'vipType': instance.vipType,
      'authenticationTypes': instance.authenticationTypes,
      'authStatus': instance.authStatus,
      'djStatus': instance.djStatus,
      'accountStatus': instance.accountStatus,
      'expertTags': instance.expertTags,
      'alg': instance.alg,
      'followed': instance.followed,
      'mutual': instance.mutual,
      'anchor': instance.anchor,
      'defaultAvatar': instance.defaultAvatar,
    };

NeteaseUserDetail _$NeteaseUserDetailFromJson(Map<String, dynamic> json) {
  return NeteaseUserDetail()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..createTime = json['createTime'] as int?
    ..createDays = json['createDays'] as int?
    ..profile =
        NeteaseAccountProfile.fromJson(json['profile'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NeteaseUserDetailToJson(NeteaseUserDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'createTime': instance.createTime,
      'createDays': instance.createDays,
      'profile': instance.profile,
    };

NeteaseUserSubcount _$NeteaseUserSubcountFromJson(Map<String, dynamic> json) {
  return NeteaseUserSubcount()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..programCount = json['programCount'] as int?
    ..djRadioCount = json['djRadioCount'] as int?
    ..mvCount = json['mvCount'] as int?
    ..artistCount = json['artistCount'] as int?
    ..newProgramCount = json['newProgramCount'] as int?
    ..createDjRadioCount = json['createDjRadioCount'] as int?
    ..createdPlaylistCount = json['createdPlaylistCount'] as int?
    ..subPlaylistCount = json['subPlaylistCount'] as int?;
}

Map<String, dynamic> _$NeteaseUserSubcountToJson(
        NeteaseUserSubcount instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'programCount': instance.programCount,
      'djRadioCount': instance.djRadioCount,
      'mvCount': instance.mvCount,
      'artistCount': instance.artistCount,
      'newProgramCount': instance.newProgramCount,
      'createDjRadioCount': instance.createDjRadioCount,
      'createdPlaylistCount': instance.createdPlaylistCount,
      'subPlaylistCount': instance.subPlaylistCount,
    };

NeteaseUserLevel _$NeteaseUserLevelFromJson(Map<String, dynamic> json) {
  return NeteaseUserLevel()
    ..info = json['info'] as String
    ..progress = (json['progress'] as num?)?.toDouble()
    ..nextPlayCount = json['nextPlayCount'] as int?
    ..nextLoginCount = json['nextLoginCount'] as int?
    ..nowPlayCount = json['nowPlayCount'] as int?
    ..nowLoginCount = json['nowLoginCount'] as int?
    ..level = json['level'] as int?;
}

Map<String, dynamic> _$NeteaseUserLevelToJson(NeteaseUserLevel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'progress': instance.progress,
      'nextPlayCount': instance.nextPlayCount,
      'nextLoginCount': instance.nextLoginCount,
      'nowPlayCount': instance.nowPlayCount,
      'nowLoginCount': instance.nowLoginCount,
      'level': instance.level,
    };

NeteaseUserLevelWrap _$NeteaseUserLevelWrapFromJson(Map<String, dynamic> json) {
  return NeteaseUserLevelWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..full = json['full'] as bool?
    ..data = NeteaseUserLevel.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NeteaseUserLevelWrapToJson(
        NeteaseUserLevelWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'full': instance.full,
      'data': instance.data,
    };

UserFollowListWrap _$UserFollowListWrapFromJson(Map<String, dynamic> json) {
  return UserFollowListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..follow = (json['follow'] as List<dynamic>)
        .map((e) => NeteaseAccountProfile.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserFollowListWrapToJson(UserFollowListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'follow': instance.follow,
    };

UserFollowedListWrap _$UserFollowedListWrapFromJson(Map<String, dynamic> json) {
  return UserFollowedListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..followeds = (json['followeds'] as List<dynamic>)
        .map((e) => NeteaseAccountProfile.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserFollowedListWrapToJson(
        UserFollowedListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'followeds': instance.followeds,
    };

UserListWrap _$UserListWrapFromJson(Map<String, dynamic> json) {
  return UserListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..userprofiles = (json['userprofiles'] as List<dynamic>)
        .map((e) => NeteaseUserInfo.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UserListWrapToJson(UserListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'userprofiles': instance.userprofiles,
    };

ArtistsSubListWrap _$ArtistsSubListWrapFromJson(Map<String, dynamic> json) {
  return ArtistsSubListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..data = (json['data'] as List<dynamic>)
        .map((e) => Artists.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$ArtistsSubListWrapToJson(ArtistsSubListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'data': instance.data,
    };

MvSubListWrap _$MvSubListWrapFromJson(Map<String, dynamic> json) {
  return MvSubListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..data = (json['data'] as List<dynamic>)
        .map((e) => Mv2.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$MvSubListWrapToJson(MvSubListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'data': instance.data,
    };

AlbumSubListWrap _$AlbumSubListWrapFromJson(Map<String, dynamic> json) {
  return AlbumSubListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..more = json['more'] as bool?
    ..hasMore = json['hasMore'] as bool?
    ..count = json['count'] as int?
    ..total = json['total'] as int?
    ..data = (json['data'] as List<dynamic>)
        .map((e) => Album.fromJson(e as Map<String, dynamic>))
        .toList()
    ..paidCount = json['paidCount'] as int?;
}

Map<String, dynamic> _$AlbumSubListWrapToJson(AlbumSubListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'more': instance.more,
      'hasMore': instance.hasMore,
      'count': instance.count,
      'total': instance.total,
      'data': instance.data,
      'paidCount': instance.paidCount,
    };

PlayRecordItem _$PlayRecordItemFromJson(Map<String, dynamic> json) {
  return PlayRecordItem()
    ..playCount = json['playCount'] as int?
    ..score = json['score'] as int?
    ..song = Song.fromJson(json['song'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlayRecordItemToJson(PlayRecordItem instance) =>
    <String, dynamic>{
      'playCount': instance.playCount,
      'score': instance.score,
      'song': instance.song,
    };

PlayRecordListWrap _$PlayRecordListWrapFromJson(Map<String, dynamic> json) {
  return PlayRecordListWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..allData = (json['allData'] as List<dynamic>)
        .map((e) => PlayRecordItem.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PlayRecordListWrapToJson(PlayRecordListWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'allData': instance.allData,
    };

PlaylistCreateWrap _$PlaylistCreateWrapFromJson(Map<String, dynamic> json) {
  return PlaylistCreateWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..id = dynamicToString(json['id'])
    ..playlist = Play.fromJson(json['playlist'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PlaylistCreateWrapToJson(PlaylistCreateWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'id': instance.id,
      'playlist': instance.playlist,
    };

PlaylistSubscribersWrap _$PlaylistSubscribersWrapFromJson(
    Map<String, dynamic> json) {
  return PlaylistSubscribersWrap()
    ..code = dynamicToInt(json['code'])
    ..message = json['message'] as String?
    ..msg = json['msg'] as String?
    ..subscribers = (json['subscribers'] as List<dynamic>)
        .map((e) => NeteaseUserInfo.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$PlaylistSubscribersWrapToJson(
        PlaylistSubscribersWrap instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'msg': instance.msg,
      'subscribers': instance.subscribers,
    };
