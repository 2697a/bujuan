import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/common/bean/playlist_entity.dart';

PlaylistEntity $PlaylistEntityFromJson(Map<String, dynamic> json) {
	final PlaylistEntity playlistEntity = PlaylistEntity();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		playlistEntity.code = code;
	}
	final dynamic? relatedVideos = jsonConvert.convert<dynamic>(json['relatedVideos']);
	if (relatedVideos != null) {
		playlistEntity.relatedVideos = relatedVideos;
	}
	final PlaylistPlaylist? playlist = jsonConvert.convert<PlaylistPlaylist>(json['playlist']);
	if (playlist != null) {
		playlistEntity.playlist = playlist;
	}
	final dynamic? urls = jsonConvert.convert<dynamic>(json['urls']);
	if (urls != null) {
		playlistEntity.urls = urls;
	}
	final List<PlaylistPrivileges>? privileges = jsonConvert.convertListNotNull<PlaylistPrivileges>(json['privileges']);
	if (privileges != null) {
		playlistEntity.privileges = privileges;
	}
	final dynamic? sharedPrivilege = jsonConvert.convert<dynamic>(json['sharedPrivilege']);
	if (sharedPrivilege != null) {
		playlistEntity.sharedPrivilege = sharedPrivilege;
	}
	final dynamic? resEntrance = jsonConvert.convert<dynamic>(json['resEntrance']);
	if (resEntrance != null) {
		playlistEntity.resEntrance = resEntrance;
	}
	return playlistEntity;
}

Map<String, dynamic> $PlaylistEntityToJson(PlaylistEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['relatedVideos'] = entity.relatedVideos;
	data['playlist'] = entity.playlist?.toJson();
	data['urls'] = entity.urls;
	data['privileges'] =  entity.privileges?.map((v) => v.toJson()).toList();
	data['sharedPrivilege'] = entity.sharedPrivilege;
	data['resEntrance'] = entity.resEntrance;
	return data;
}

PlaylistPlaylist $PlaylistPlaylistFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylist playlistPlaylist = PlaylistPlaylist();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		playlistPlaylist.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		playlistPlaylist.name = name;
	}
	final int? coverImgId = jsonConvert.convert<int>(json['coverImgId']);
	if (coverImgId != null) {
		playlistPlaylist.coverImgId = coverImgId;
	}
	final String? coverImgUrl = jsonConvert.convert<String>(json['coverImgUrl']);
	if (coverImgUrl != null) {
		playlistPlaylist.coverImgUrl = coverImgUrl;
	}
	final String? coverimgidStr = jsonConvert.convert<String>(json['coverImgId_str']);
	if (coverimgidStr != null) {
		playlistPlaylist.coverimgidStr = coverimgidStr;
	}
	final int? adType = jsonConvert.convert<int>(json['adType']);
	if (adType != null) {
		playlistPlaylist.adType = adType;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		playlistPlaylist.userId = userId;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		playlistPlaylist.createTime = createTime;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		playlistPlaylist.status = status;
	}
	final bool? opRecommend = jsonConvert.convert<bool>(json['opRecommend']);
	if (opRecommend != null) {
		playlistPlaylist.opRecommend = opRecommend;
	}
	final bool? highQuality = jsonConvert.convert<bool>(json['highQuality']);
	if (highQuality != null) {
		playlistPlaylist.highQuality = highQuality;
	}
	final bool? newImported = jsonConvert.convert<bool>(json['newImported']);
	if (newImported != null) {
		playlistPlaylist.newImported = newImported;
	}
	final int? updateTime = jsonConvert.convert<int>(json['updateTime']);
	if (updateTime != null) {
		playlistPlaylist.updateTime = updateTime;
	}
	final int? trackCount = jsonConvert.convert<int>(json['trackCount']);
	if (trackCount != null) {
		playlistPlaylist.trackCount = trackCount;
	}
	final int? specialType = jsonConvert.convert<int>(json['specialType']);
	if (specialType != null) {
		playlistPlaylist.specialType = specialType;
	}
	final int? privacy = jsonConvert.convert<int>(json['privacy']);
	if (privacy != null) {
		playlistPlaylist.privacy = privacy;
	}
	final int? trackUpdateTime = jsonConvert.convert<int>(json['trackUpdateTime']);
	if (trackUpdateTime != null) {
		playlistPlaylist.trackUpdateTime = trackUpdateTime;
	}
	final String? commentThreadId = jsonConvert.convert<String>(json['commentThreadId']);
	if (commentThreadId != null) {
		playlistPlaylist.commentThreadId = commentThreadId;
	}
	final int? playCount = jsonConvert.convert<int>(json['playCount']);
	if (playCount != null) {
		playlistPlaylist.playCount = playCount;
	}
	final int? trackNumberUpdateTime = jsonConvert.convert<int>(json['trackNumberUpdateTime']);
	if (trackNumberUpdateTime != null) {
		playlistPlaylist.trackNumberUpdateTime = trackNumberUpdateTime;
	}
	final int? subscribedCount = jsonConvert.convert<int>(json['subscribedCount']);
	if (subscribedCount != null) {
		playlistPlaylist.subscribedCount = subscribedCount;
	}
	final int? cloudTrackCount = jsonConvert.convert<int>(json['cloudTrackCount']);
	if (cloudTrackCount != null) {
		playlistPlaylist.cloudTrackCount = cloudTrackCount;
	}
	final bool? ordered = jsonConvert.convert<bool>(json['ordered']);
	if (ordered != null) {
		playlistPlaylist.ordered = ordered;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		playlistPlaylist.description = description;
	}
	final List<String>? tags = jsonConvert.convertListNotNull<String>(json['tags']);
	if (tags != null) {
		playlistPlaylist.tags = tags;
	}
	final dynamic? updateFrequency = jsonConvert.convert<dynamic>(json['updateFrequency']);
	if (updateFrequency != null) {
		playlistPlaylist.updateFrequency = updateFrequency;
	}
	final int? backgroundCoverId = jsonConvert.convert<int>(json['backgroundCoverId']);
	if (backgroundCoverId != null) {
		playlistPlaylist.backgroundCoverId = backgroundCoverId;
	}
	final dynamic? backgroundCoverUrl = jsonConvert.convert<dynamic>(json['backgroundCoverUrl']);
	if (backgroundCoverUrl != null) {
		playlistPlaylist.backgroundCoverUrl = backgroundCoverUrl;
	}
	final int? titleImage = jsonConvert.convert<int>(json['titleImage']);
	if (titleImage != null) {
		playlistPlaylist.titleImage = titleImage;
	}
	final dynamic? titleImageUrl = jsonConvert.convert<dynamic>(json['titleImageUrl']);
	if (titleImageUrl != null) {
		playlistPlaylist.titleImageUrl = titleImageUrl;
	}
	final dynamic? englishTitle = jsonConvert.convert<dynamic>(json['englishTitle']);
	if (englishTitle != null) {
		playlistPlaylist.englishTitle = englishTitle;
	}
	final dynamic? officialPlaylistType = jsonConvert.convert<dynamic>(json['officialPlaylistType']);
	if (officialPlaylistType != null) {
		playlistPlaylist.officialPlaylistType = officialPlaylistType;
	}
	final bool? copied = jsonConvert.convert<bool>(json['copied']);
	if (copied != null) {
		playlistPlaylist.copied = copied;
	}
	final List<PlaylistPlaylistSubscribers>? subscribers = jsonConvert.convertListNotNull<PlaylistPlaylistSubscribers>(json['subscribers']);
	if (subscribers != null) {
		playlistPlaylist.subscribers = subscribers;
	}
	final dynamic? subscribed = jsonConvert.convert<dynamic>(json['subscribed']);
	if (subscribed != null) {
		playlistPlaylist.subscribed = subscribed;
	}
	final PlaylistPlaylistCreator? creator = jsonConvert.convert<PlaylistPlaylistCreator>(json['creator']);
	if (creator != null) {
		playlistPlaylist.creator = creator;
	}
	final List<PlaylistPlaylistTracks>? tracks = jsonConvert.convertListNotNull<PlaylistPlaylistTracks>(json['tracks']);
	if (tracks != null) {
		playlistPlaylist.tracks = tracks;
	}
	final dynamic? videoIds = jsonConvert.convert<dynamic>(json['videoIds']);
	if (videoIds != null) {
		playlistPlaylist.videoIds = videoIds;
	}
	final dynamic? videos = jsonConvert.convert<dynamic>(json['videos']);
	if (videos != null) {
		playlistPlaylist.videos = videos;
	}
	final List<PlaylistPlaylistTrackIds>? trackIds = jsonConvert.convertListNotNull<PlaylistPlaylistTrackIds>(json['trackIds']);
	if (trackIds != null) {
		playlistPlaylist.trackIds = trackIds;
	}
	final dynamic? bannedTrackIds = jsonConvert.convert<dynamic>(json['bannedTrackIds']);
	if (bannedTrackIds != null) {
		playlistPlaylist.bannedTrackIds = bannedTrackIds;
	}
	final int? shareCount = jsonConvert.convert<int>(json['shareCount']);
	if (shareCount != null) {
		playlistPlaylist.shareCount = shareCount;
	}
	final int? commentCount = jsonConvert.convert<int>(json['commentCount']);
	if (commentCount != null) {
		playlistPlaylist.commentCount = commentCount;
	}
	final dynamic? remixVideo = jsonConvert.convert<dynamic>(json['remixVideo']);
	if (remixVideo != null) {
		playlistPlaylist.remixVideo = remixVideo;
	}
	final dynamic? sharedUsers = jsonConvert.convert<dynamic>(json['sharedUsers']);
	if (sharedUsers != null) {
		playlistPlaylist.sharedUsers = sharedUsers;
	}
	final dynamic? historySharedUsers = jsonConvert.convert<dynamic>(json['historySharedUsers']);
	if (historySharedUsers != null) {
		playlistPlaylist.historySharedUsers = historySharedUsers;
	}
	final String? gradeStatus = jsonConvert.convert<String>(json['gradeStatus']);
	if (gradeStatus != null) {
		playlistPlaylist.gradeStatus = gradeStatus;
	}
	final dynamic? score = jsonConvert.convert<dynamic>(json['score']);
	if (score != null) {
		playlistPlaylist.score = score;
	}
	final List<String>? algTags = jsonConvert.convertListNotNull<String>(json['algTags']);
	if (algTags != null) {
		playlistPlaylist.algTags = algTags;
	}
	return playlistPlaylist;
}

Map<String, dynamic> $PlaylistPlaylistToJson(PlaylistPlaylist entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['coverImgId'] = entity.coverImgId;
	data['coverImgUrl'] = entity.coverImgUrl;
	data['coverImgId_str'] = entity.coverimgidStr;
	data['adType'] = entity.adType;
	data['userId'] = entity.userId;
	data['createTime'] = entity.createTime;
	data['status'] = entity.status;
	data['opRecommend'] = entity.opRecommend;
	data['highQuality'] = entity.highQuality;
	data['newImported'] = entity.newImported;
	data['updateTime'] = entity.updateTime;
	data['trackCount'] = entity.trackCount;
	data['specialType'] = entity.specialType;
	data['privacy'] = entity.privacy;
	data['trackUpdateTime'] = entity.trackUpdateTime;
	data['commentThreadId'] = entity.commentThreadId;
	data['playCount'] = entity.playCount;
	data['trackNumberUpdateTime'] = entity.trackNumberUpdateTime;
	data['subscribedCount'] = entity.subscribedCount;
	data['cloudTrackCount'] = entity.cloudTrackCount;
	data['ordered'] = entity.ordered;
	data['description'] = entity.description;
	data['tags'] =  entity.tags;
	data['updateFrequency'] = entity.updateFrequency;
	data['backgroundCoverId'] = entity.backgroundCoverId;
	data['backgroundCoverUrl'] = entity.backgroundCoverUrl;
	data['titleImage'] = entity.titleImage;
	data['titleImageUrl'] = entity.titleImageUrl;
	data['englishTitle'] = entity.englishTitle;
	data['officialPlaylistType'] = entity.officialPlaylistType;
	data['copied'] = entity.copied;
	data['subscribers'] =  entity.subscribers?.map((v) => v.toJson()).toList();
	data['subscribed'] = entity.subscribed;
	data['creator'] = entity.creator?.toJson();
	data['tracks'] =  entity.tracks?.map((v) => v.toJson()).toList();
	data['videoIds'] = entity.videoIds;
	data['videos'] = entity.videos;
	data['trackIds'] =  entity.trackIds?.map((v) => v.toJson()).toList();
	data['bannedTrackIds'] = entity.bannedTrackIds;
	data['shareCount'] = entity.shareCount;
	data['commentCount'] = entity.commentCount;
	data['remixVideo'] = entity.remixVideo;
	data['sharedUsers'] = entity.sharedUsers;
	data['historySharedUsers'] = entity.historySharedUsers;
	data['gradeStatus'] = entity.gradeStatus;
	data['score'] = entity.score;
	data['algTags'] =  entity.algTags;
	return data;
}

PlaylistPlaylistSubscribers $PlaylistPlaylistSubscribersFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistSubscribers playlistPlaylistSubscribers = PlaylistPlaylistSubscribers();
	final bool? defaultAvatar = jsonConvert.convert<bool>(json['defaultAvatar']);
	if (defaultAvatar != null) {
		playlistPlaylistSubscribers.defaultAvatar = defaultAvatar;
	}
	final int? province = jsonConvert.convert<int>(json['province']);
	if (province != null) {
		playlistPlaylistSubscribers.province = province;
	}
	final int? authStatus = jsonConvert.convert<int>(json['authStatus']);
	if (authStatus != null) {
		playlistPlaylistSubscribers.authStatus = authStatus;
	}
	final bool? followed = jsonConvert.convert<bool>(json['followed']);
	if (followed != null) {
		playlistPlaylistSubscribers.followed = followed;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatarUrl']);
	if (avatarUrl != null) {
		playlistPlaylistSubscribers.avatarUrl = avatarUrl;
	}
	final int? accountStatus = jsonConvert.convert<int>(json['accountStatus']);
	if (accountStatus != null) {
		playlistPlaylistSubscribers.accountStatus = accountStatus;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		playlistPlaylistSubscribers.gender = gender;
	}
	final int? city = jsonConvert.convert<int>(json['city']);
	if (city != null) {
		playlistPlaylistSubscribers.city = city;
	}
	final int? birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		playlistPlaylistSubscribers.birthday = birthday;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		playlistPlaylistSubscribers.userId = userId;
	}
	final int? userType = jsonConvert.convert<int>(json['userType']);
	if (userType != null) {
		playlistPlaylistSubscribers.userType = userType;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		playlistPlaylistSubscribers.nickname = nickname;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		playlistPlaylistSubscribers.signature = signature;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		playlistPlaylistSubscribers.description = description;
	}
	final String? detailDescription = jsonConvert.convert<String>(json['detailDescription']);
	if (detailDescription != null) {
		playlistPlaylistSubscribers.detailDescription = detailDescription;
	}
	final int? avatarImgId = jsonConvert.convert<int>(json['avatarImgId']);
	if (avatarImgId != null) {
		playlistPlaylistSubscribers.avatarImgId = avatarImgId;
	}
	final int? backgroundImgId = jsonConvert.convert<int>(json['backgroundImgId']);
	if (backgroundImgId != null) {
		playlistPlaylistSubscribers.backgroundImgId = backgroundImgId;
	}
	final String? backgroundUrl = jsonConvert.convert<String>(json['backgroundUrl']);
	if (backgroundUrl != null) {
		playlistPlaylistSubscribers.backgroundUrl = backgroundUrl;
	}
	final int? authority = jsonConvert.convert<int>(json['authority']);
	if (authority != null) {
		playlistPlaylistSubscribers.authority = authority;
	}
	final bool? mutual = jsonConvert.convert<bool>(json['mutual']);
	if (mutual != null) {
		playlistPlaylistSubscribers.mutual = mutual;
	}
	final dynamic? expertTags = jsonConvert.convert<dynamic>(json['expertTags']);
	if (expertTags != null) {
		playlistPlaylistSubscribers.expertTags = expertTags;
	}
	final dynamic? experts = jsonConvert.convert<dynamic>(json['experts']);
	if (experts != null) {
		playlistPlaylistSubscribers.experts = experts;
	}
	final int? djStatus = jsonConvert.convert<int>(json['djStatus']);
	if (djStatus != null) {
		playlistPlaylistSubscribers.djStatus = djStatus;
	}
	final int? vipType = jsonConvert.convert<int>(json['vipType']);
	if (vipType != null) {
		playlistPlaylistSubscribers.vipType = vipType;
	}
	final dynamic? remarkName = jsonConvert.convert<dynamic>(json['remarkName']);
	if (remarkName != null) {
		playlistPlaylistSubscribers.remarkName = remarkName;
	}
	final int? authenticationTypes = jsonConvert.convert<int>(json['authenticationTypes']);
	if (authenticationTypes != null) {
		playlistPlaylistSubscribers.authenticationTypes = authenticationTypes;
	}
	final PlaylistPlaylistSubscribersAvatarDetail? avatarDetail = jsonConvert.convert<PlaylistPlaylistSubscribersAvatarDetail>(json['avatarDetail']);
	if (avatarDetail != null) {
		playlistPlaylistSubscribers.avatarDetail = avatarDetail;
	}
	final bool? anchor = jsonConvert.convert<bool>(json['anchor']);
	if (anchor != null) {
		playlistPlaylistSubscribers.anchor = anchor;
	}
	final String? avatarImgIdStr = jsonConvert.convert<String>(json['avatarImgIdStr']);
	if (avatarImgIdStr != null) {
		playlistPlaylistSubscribers.avatarImgIdStr = avatarImgIdStr;
	}
	final String? backgroundImgIdStr = jsonConvert.convert<String>(json['backgroundImgIdStr']);
	if (backgroundImgIdStr != null) {
		playlistPlaylistSubscribers.backgroundImgIdStr = backgroundImgIdStr;
	}
	final String? avatarimgidStr = jsonConvert.convert<String>(json['avatarImgId_str']);
	if (avatarimgidStr != null) {
		playlistPlaylistSubscribers.avatarimgidStr = avatarimgidStr;
	}
	return playlistPlaylistSubscribers;
}

Map<String, dynamic> $PlaylistPlaylistSubscribersToJson(PlaylistPlaylistSubscribers entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['defaultAvatar'] = entity.defaultAvatar;
	data['province'] = entity.province;
	data['authStatus'] = entity.authStatus;
	data['followed'] = entity.followed;
	data['avatarUrl'] = entity.avatarUrl;
	data['accountStatus'] = entity.accountStatus;
	data['gender'] = entity.gender;
	data['city'] = entity.city;
	data['birthday'] = entity.birthday;
	data['userId'] = entity.userId;
	data['userType'] = entity.userType;
	data['nickname'] = entity.nickname;
	data['signature'] = entity.signature;
	data['description'] = entity.description;
	data['detailDescription'] = entity.detailDescription;
	data['avatarImgId'] = entity.avatarImgId;
	data['backgroundImgId'] = entity.backgroundImgId;
	data['backgroundUrl'] = entity.backgroundUrl;
	data['authority'] = entity.authority;
	data['mutual'] = entity.mutual;
	data['expertTags'] = entity.expertTags;
	data['experts'] = entity.experts;
	data['djStatus'] = entity.djStatus;
	data['vipType'] = entity.vipType;
	data['remarkName'] = entity.remarkName;
	data['authenticationTypes'] = entity.authenticationTypes;
	data['avatarDetail'] = entity.avatarDetail?.toJson();
	data['anchor'] = entity.anchor;
	data['avatarImgIdStr'] = entity.avatarImgIdStr;
	data['backgroundImgIdStr'] = entity.backgroundImgIdStr;
	data['avatarImgId_str'] = entity.avatarimgidStr;
	return data;
}

PlaylistPlaylistSubscribersAvatarDetail $PlaylistPlaylistSubscribersAvatarDetailFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistSubscribersAvatarDetail playlistPlaylistSubscribersAvatarDetail = PlaylistPlaylistSubscribersAvatarDetail();
	final int? userType = jsonConvert.convert<int>(json['userType']);
	if (userType != null) {
		playlistPlaylistSubscribersAvatarDetail.userType = userType;
	}
	final int? identityLevel = jsonConvert.convert<int>(json['identityLevel']);
	if (identityLevel != null) {
		playlistPlaylistSubscribersAvatarDetail.identityLevel = identityLevel;
	}
	final String? identityIconUrl = jsonConvert.convert<String>(json['identityIconUrl']);
	if (identityIconUrl != null) {
		playlistPlaylistSubscribersAvatarDetail.identityIconUrl = identityIconUrl;
	}
	return playlistPlaylistSubscribersAvatarDetail;
}

Map<String, dynamic> $PlaylistPlaylistSubscribersAvatarDetailToJson(PlaylistPlaylistSubscribersAvatarDetail entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userType'] = entity.userType;
	data['identityLevel'] = entity.identityLevel;
	data['identityIconUrl'] = entity.identityIconUrl;
	return data;
}

PlaylistPlaylistCreator $PlaylistPlaylistCreatorFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistCreator playlistPlaylistCreator = PlaylistPlaylistCreator();
	final bool? defaultAvatar = jsonConvert.convert<bool>(json['defaultAvatar']);
	if (defaultAvatar != null) {
		playlistPlaylistCreator.defaultAvatar = defaultAvatar;
	}
	final int? province = jsonConvert.convert<int>(json['province']);
	if (province != null) {
		playlistPlaylistCreator.province = province;
	}
	final int? authStatus = jsonConvert.convert<int>(json['authStatus']);
	if (authStatus != null) {
		playlistPlaylistCreator.authStatus = authStatus;
	}
	final bool? followed = jsonConvert.convert<bool>(json['followed']);
	if (followed != null) {
		playlistPlaylistCreator.followed = followed;
	}
	final String? avatarUrl = jsonConvert.convert<String>(json['avatarUrl']);
	if (avatarUrl != null) {
		playlistPlaylistCreator.avatarUrl = avatarUrl;
	}
	final int? accountStatus = jsonConvert.convert<int>(json['accountStatus']);
	if (accountStatus != null) {
		playlistPlaylistCreator.accountStatus = accountStatus;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		playlistPlaylistCreator.gender = gender;
	}
	final int? city = jsonConvert.convert<int>(json['city']);
	if (city != null) {
		playlistPlaylistCreator.city = city;
	}
	final int? birthday = jsonConvert.convert<int>(json['birthday']);
	if (birthday != null) {
		playlistPlaylistCreator.birthday = birthday;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		playlistPlaylistCreator.userId = userId;
	}
	final int? userType = jsonConvert.convert<int>(json['userType']);
	if (userType != null) {
		playlistPlaylistCreator.userType = userType;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		playlistPlaylistCreator.nickname = nickname;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		playlistPlaylistCreator.signature = signature;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		playlistPlaylistCreator.description = description;
	}
	final String? detailDescription = jsonConvert.convert<String>(json['detailDescription']);
	if (detailDescription != null) {
		playlistPlaylistCreator.detailDescription = detailDescription;
	}
	final int? avatarImgId = jsonConvert.convert<int>(json['avatarImgId']);
	if (avatarImgId != null) {
		playlistPlaylistCreator.avatarImgId = avatarImgId;
	}
	final int? backgroundImgId = jsonConvert.convert<int>(json['backgroundImgId']);
	if (backgroundImgId != null) {
		playlistPlaylistCreator.backgroundImgId = backgroundImgId;
	}
	final String? backgroundUrl = jsonConvert.convert<String>(json['backgroundUrl']);
	if (backgroundUrl != null) {
		playlistPlaylistCreator.backgroundUrl = backgroundUrl;
	}
	final int? authority = jsonConvert.convert<int>(json['authority']);
	if (authority != null) {
		playlistPlaylistCreator.authority = authority;
	}
	final bool? mutual = jsonConvert.convert<bool>(json['mutual']);
	if (mutual != null) {
		playlistPlaylistCreator.mutual = mutual;
	}
	final dynamic? expertTags = jsonConvert.convert<dynamic>(json['expertTags']);
	if (expertTags != null) {
		playlistPlaylistCreator.expertTags = expertTags;
	}
	final dynamic? experts = jsonConvert.convert<dynamic>(json['experts']);
	if (experts != null) {
		playlistPlaylistCreator.experts = experts;
	}
	final int? djStatus = jsonConvert.convert<int>(json['djStatus']);
	if (djStatus != null) {
		playlistPlaylistCreator.djStatus = djStatus;
	}
	final int? vipType = jsonConvert.convert<int>(json['vipType']);
	if (vipType != null) {
		playlistPlaylistCreator.vipType = vipType;
	}
	final dynamic? remarkName = jsonConvert.convert<dynamic>(json['remarkName']);
	if (remarkName != null) {
		playlistPlaylistCreator.remarkName = remarkName;
	}
	final int? authenticationTypes = jsonConvert.convert<int>(json['authenticationTypes']);
	if (authenticationTypes != null) {
		playlistPlaylistCreator.authenticationTypes = authenticationTypes;
	}
	final PlaylistPlaylistCreatorAvatarDetail? avatarDetail = jsonConvert.convert<PlaylistPlaylistCreatorAvatarDetail>(json['avatarDetail']);
	if (avatarDetail != null) {
		playlistPlaylistCreator.avatarDetail = avatarDetail;
	}
	final bool? anchor = jsonConvert.convert<bool>(json['anchor']);
	if (anchor != null) {
		playlistPlaylistCreator.anchor = anchor;
	}
	final String? avatarImgIdStr = jsonConvert.convert<String>(json['avatarImgIdStr']);
	if (avatarImgIdStr != null) {
		playlistPlaylistCreator.avatarImgIdStr = avatarImgIdStr;
	}
	final String? backgroundImgIdStr = jsonConvert.convert<String>(json['backgroundImgIdStr']);
	if (backgroundImgIdStr != null) {
		playlistPlaylistCreator.backgroundImgIdStr = backgroundImgIdStr;
	}
	return playlistPlaylistCreator;
}

Map<String, dynamic> $PlaylistPlaylistCreatorToJson(PlaylistPlaylistCreator entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['defaultAvatar'] = entity.defaultAvatar;
	data['province'] = entity.province;
	data['authStatus'] = entity.authStatus;
	data['followed'] = entity.followed;
	data['avatarUrl'] = entity.avatarUrl;
	data['accountStatus'] = entity.accountStatus;
	data['gender'] = entity.gender;
	data['city'] = entity.city;
	data['birthday'] = entity.birthday;
	data['userId'] = entity.userId;
	data['userType'] = entity.userType;
	data['nickname'] = entity.nickname;
	data['signature'] = entity.signature;
	data['description'] = entity.description;
	data['detailDescription'] = entity.detailDescription;
	data['avatarImgId'] = entity.avatarImgId;
	data['backgroundImgId'] = entity.backgroundImgId;
	data['backgroundUrl'] = entity.backgroundUrl;
	data['authority'] = entity.authority;
	data['mutual'] = entity.mutual;
	data['expertTags'] = entity.expertTags;
	data['experts'] = entity.experts;
	data['djStatus'] = entity.djStatus;
	data['vipType'] = entity.vipType;
	data['remarkName'] = entity.remarkName;
	data['authenticationTypes'] = entity.authenticationTypes;
	data['avatarDetail'] = entity.avatarDetail?.toJson();
	data['anchor'] = entity.anchor;
	data['avatarImgIdStr'] = entity.avatarImgIdStr;
	data['backgroundImgIdStr'] = entity.backgroundImgIdStr;
	return data;
}

PlaylistPlaylistCreatorAvatarDetail $PlaylistPlaylistCreatorAvatarDetailFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistCreatorAvatarDetail playlistPlaylistCreatorAvatarDetail = PlaylistPlaylistCreatorAvatarDetail();
	final int? userType = jsonConvert.convert<int>(json['userType']);
	if (userType != null) {
		playlistPlaylistCreatorAvatarDetail.userType = userType;
	}
	final int? identityLevel = jsonConvert.convert<int>(json['identityLevel']);
	if (identityLevel != null) {
		playlistPlaylistCreatorAvatarDetail.identityLevel = identityLevel;
	}
	final String? identityIconUrl = jsonConvert.convert<String>(json['identityIconUrl']);
	if (identityIconUrl != null) {
		playlistPlaylistCreatorAvatarDetail.identityIconUrl = identityIconUrl;
	}
	return playlistPlaylistCreatorAvatarDetail;
}

Map<String, dynamic> $PlaylistPlaylistCreatorAvatarDetailToJson(PlaylistPlaylistCreatorAvatarDetail entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userType'] = entity.userType;
	data['identityLevel'] = entity.identityLevel;
	data['identityIconUrl'] = entity.identityIconUrl;
	return data;
}

PlaylistPlaylistTracks $PlaylistPlaylistTracksFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracks playlistPlaylistTracks = PlaylistPlaylistTracks();
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		playlistPlaylistTracks.name = name;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		playlistPlaylistTracks.id = id;
	}
	final int? pst = jsonConvert.convert<int>(json['pst']);
	if (pst != null) {
		playlistPlaylistTracks.pst = pst;
	}
	final int? t = jsonConvert.convert<int>(json['t']);
	if (t != null) {
		playlistPlaylistTracks.t = t;
	}
	final List<PlaylistPlaylistTracksAr>? ar = jsonConvert.convertListNotNull<PlaylistPlaylistTracksAr>(json['ar']);
	if (ar != null) {
		playlistPlaylistTracks.ar = ar;
	}
	final List<dynamic>? alia = jsonConvert.convertListNotNull<dynamic>(json['alia']);
	if (alia != null) {
		playlistPlaylistTracks.alia = alia;
	}
	final double? pop = jsonConvert.convert<double>(json['pop']);
	if (pop != null) {
		playlistPlaylistTracks.pop = pop;
	}
	final int? st = jsonConvert.convert<int>(json['st']);
	if (st != null) {
		playlistPlaylistTracks.st = st;
	}
	final String? rt = jsonConvert.convert<String>(json['rt']);
	if (rt != null) {
		playlistPlaylistTracks.rt = rt;
	}
	final int? fee = jsonConvert.convert<int>(json['fee']);
	if (fee != null) {
		playlistPlaylistTracks.fee = fee;
	}
	final int? v = jsonConvert.convert<int>(json['v']);
	if (v != null) {
		playlistPlaylistTracks.v = v;
	}
	final dynamic? crbt = jsonConvert.convert<dynamic>(json['crbt']);
	if (crbt != null) {
		playlistPlaylistTracks.crbt = crbt;
	}
	final String? cf = jsonConvert.convert<String>(json['cf']);
	if (cf != null) {
		playlistPlaylistTracks.cf = cf;
	}
	final PlaylistPlaylistTracksAl? al = jsonConvert.convert<PlaylistPlaylistTracksAl>(json['al']);
	if (al != null) {
		playlistPlaylistTracks.al = al;
	}
	final int? dt = jsonConvert.convert<int>(json['dt']);
	if (dt != null) {
		playlistPlaylistTracks.dt = dt;
	}
	final PlaylistPlaylistTracksH? h = jsonConvert.convert<PlaylistPlaylistTracksH>(json['h']);
	if (h != null) {
		playlistPlaylistTracks.h = h;
	}
	final PlaylistPlaylistTracksM? m = jsonConvert.convert<PlaylistPlaylistTracksM>(json['m']);
	if (m != null) {
		playlistPlaylistTracks.m = m;
	}
	final PlaylistPlaylistTracksL? l = jsonConvert.convert<PlaylistPlaylistTracksL>(json['l']);
	if (l != null) {
		playlistPlaylistTracks.l = l;
	}
	final PlaylistPlaylistTracksSq? sq = jsonConvert.convert<PlaylistPlaylistTracksSq>(json['sq']);
	if (sq != null) {
		playlistPlaylistTracks.sq = sq;
	}
	final dynamic? hr = jsonConvert.convert<dynamic>(json['hr']);
	if (hr != null) {
		playlistPlaylistTracks.hr = hr;
	}
	final dynamic? a = jsonConvert.convert<dynamic>(json['a']);
	if (a != null) {
		playlistPlaylistTracks.a = a;
	}
	final String? cd = jsonConvert.convert<String>(json['cd']);
	if (cd != null) {
		playlistPlaylistTracks.cd = cd;
	}
	final int? no = jsonConvert.convert<int>(json['no']);
	if (no != null) {
		playlistPlaylistTracks.no = no;
	}
	final dynamic? rtUrl = jsonConvert.convert<dynamic>(json['rtUrl']);
	if (rtUrl != null) {
		playlistPlaylistTracks.rtUrl = rtUrl;
	}
	final int? ftype = jsonConvert.convert<int>(json['ftype']);
	if (ftype != null) {
		playlistPlaylistTracks.ftype = ftype;
	}
	final List<dynamic>? rtUrls = jsonConvert.convertListNotNull<dynamic>(json['rtUrls']);
	if (rtUrls != null) {
		playlistPlaylistTracks.rtUrls = rtUrls;
	}
	final int? djId = jsonConvert.convert<int>(json['djId']);
	if (djId != null) {
		playlistPlaylistTracks.djId = djId;
	}
	final int? copyright = jsonConvert.convert<int>(json['copyright']);
	if (copyright != null) {
		playlistPlaylistTracks.copyright = copyright;
	}
	final int? sId = jsonConvert.convert<int>(json['s_id']);
	if (sId != null) {
		playlistPlaylistTracks.sId = sId;
	}
	final int? mark = jsonConvert.convert<int>(json['mark']);
	if (mark != null) {
		playlistPlaylistTracks.mark = mark;
	}
	final int? originCoverType = jsonConvert.convert<int>(json['originCoverType']);
	if (originCoverType != null) {
		playlistPlaylistTracks.originCoverType = originCoverType;
	}
	final dynamic? originSongSimpleData = jsonConvert.convert<dynamic>(json['originSongSimpleData']);
	if (originSongSimpleData != null) {
		playlistPlaylistTracks.originSongSimpleData = originSongSimpleData;
	}
	final dynamic? tagPicList = jsonConvert.convert<dynamic>(json['tagPicList']);
	if (tagPicList != null) {
		playlistPlaylistTracks.tagPicList = tagPicList;
	}
	final bool? resourceState = jsonConvert.convert<bool>(json['resourceState']);
	if (resourceState != null) {
		playlistPlaylistTracks.resourceState = resourceState;
	}
	final int? version = jsonConvert.convert<int>(json['version']);
	if (version != null) {
		playlistPlaylistTracks.version = version;
	}
	final dynamic? songJumpInfo = jsonConvert.convert<dynamic>(json['songJumpInfo']);
	if (songJumpInfo != null) {
		playlistPlaylistTracks.songJumpInfo = songJumpInfo;
	}
	final dynamic? entertainmentTags = jsonConvert.convert<dynamic>(json['entertainmentTags']);
	if (entertainmentTags != null) {
		playlistPlaylistTracks.entertainmentTags = entertainmentTags;
	}
	final int? single = jsonConvert.convert<int>(json['single']);
	if (single != null) {
		playlistPlaylistTracks.single = single;
	}
	final dynamic? noCopyrightRcmd = jsonConvert.convert<dynamic>(json['noCopyrightRcmd']);
	if (noCopyrightRcmd != null) {
		playlistPlaylistTracks.noCopyrightRcmd = noCopyrightRcmd;
	}
	final int? rtype = jsonConvert.convert<int>(json['rtype']);
	if (rtype != null) {
		playlistPlaylistTracks.rtype = rtype;
	}
	final dynamic? rurl = jsonConvert.convert<dynamic>(json['rurl']);
	if (rurl != null) {
		playlistPlaylistTracks.rurl = rurl;
	}
	final int? mst = jsonConvert.convert<int>(json['mst']);
	if (mst != null) {
		playlistPlaylistTracks.mst = mst;
	}
	final int? cp = jsonConvert.convert<int>(json['cp']);
	if (cp != null) {
		playlistPlaylistTracks.cp = cp;
	}
	final int? mv = jsonConvert.convert<int>(json['mv']);
	if (mv != null) {
		playlistPlaylistTracks.mv = mv;
	}
	final int? publishTime = jsonConvert.convert<int>(json['publishTime']);
	if (publishTime != null) {
		playlistPlaylistTracks.publishTime = publishTime;
	}
	final List<String>? tns = jsonConvert.convertListNotNull<String>(json['tns']);
	if (tns != null) {
		playlistPlaylistTracks.tns = tns;
	}
	return playlistPlaylistTracks;
}

Map<String, dynamic> $PlaylistPlaylistTracksToJson(PlaylistPlaylistTracks entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['pst'] = entity.pst;
	data['t'] = entity.t;
	data['ar'] =  entity.ar?.map((v) => v.toJson()).toList();
	data['alia'] =  entity.alia;
	data['pop'] = entity.pop;
	data['st'] = entity.st;
	data['rt'] = entity.rt;
	data['fee'] = entity.fee;
	data['v'] = entity.v;
	data['crbt'] = entity.crbt;
	data['cf'] = entity.cf;
	data['al'] = entity.al?.toJson();
	data['dt'] = entity.dt;
	data['h'] = entity.h?.toJson();
	data['m'] = entity.m?.toJson();
	data['l'] = entity.l?.toJson();
	data['sq'] = entity.sq?.toJson();
	data['hr'] = entity.hr;
	data['a'] = entity.a;
	data['cd'] = entity.cd;
	data['no'] = entity.no;
	data['rtUrl'] = entity.rtUrl;
	data['ftype'] = entity.ftype;
	data['rtUrls'] =  entity.rtUrls;
	data['djId'] = entity.djId;
	data['copyright'] = entity.copyright;
	data['s_id'] = entity.sId;
	data['mark'] = entity.mark;
	data['originCoverType'] = entity.originCoverType;
	data['originSongSimpleData'] = entity.originSongSimpleData;
	data['tagPicList'] = entity.tagPicList;
	data['resourceState'] = entity.resourceState;
	data['version'] = entity.version;
	data['songJumpInfo'] = entity.songJumpInfo;
	data['entertainmentTags'] = entity.entertainmentTags;
	data['single'] = entity.single;
	data['noCopyrightRcmd'] = entity.noCopyrightRcmd;
	data['rtype'] = entity.rtype;
	data['rurl'] = entity.rurl;
	data['mst'] = entity.mst;
	data['cp'] = entity.cp;
	data['mv'] = entity.mv;
	data['publishTime'] = entity.publishTime;
	data['tns'] =  entity.tns;
	return data;
}

PlaylistPlaylistTracksAr $PlaylistPlaylistTracksArFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracksAr playlistPlaylistTracksAr = PlaylistPlaylistTracksAr();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		playlistPlaylistTracksAr.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		playlistPlaylistTracksAr.name = name;
	}
	final List<dynamic>? tns = jsonConvert.convertListNotNull<dynamic>(json['tns']);
	if (tns != null) {
		playlistPlaylistTracksAr.tns = tns;
	}
	final List<dynamic>? alias = jsonConvert.convertListNotNull<dynamic>(json['alias']);
	if (alias != null) {
		playlistPlaylistTracksAr.alias = alias;
	}
	return playlistPlaylistTracksAr;
}

Map<String, dynamic> $PlaylistPlaylistTracksArToJson(PlaylistPlaylistTracksAr entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['tns'] =  entity.tns;
	data['alias'] =  entity.alias;
	return data;
}

PlaylistPlaylistTracksAl $PlaylistPlaylistTracksAlFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracksAl playlistPlaylistTracksAl = PlaylistPlaylistTracksAl();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		playlistPlaylistTracksAl.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		playlistPlaylistTracksAl.name = name;
	}
	final String? picUrl = jsonConvert.convert<String>(json['picUrl']);
	if (picUrl != null) {
		playlistPlaylistTracksAl.picUrl = picUrl;
	}
	final List<dynamic>? tns = jsonConvert.convertListNotNull<dynamic>(json['tns']);
	if (tns != null) {
		playlistPlaylistTracksAl.tns = tns;
	}
	final String? picStr = jsonConvert.convert<String>(json['pic_str']);
	if (picStr != null) {
		playlistPlaylistTracksAl.picStr = picStr;
	}
	final int? pic = jsonConvert.convert<int>(json['pic']);
	if (pic != null) {
		playlistPlaylistTracksAl.pic = pic;
	}
	return playlistPlaylistTracksAl;
}

Map<String, dynamic> $PlaylistPlaylistTracksAlToJson(PlaylistPlaylistTracksAl entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['picUrl'] = entity.picUrl;
	data['tns'] =  entity.tns;
	data['pic_str'] = entity.picStr;
	data['pic'] = entity.pic;
	return data;
}

PlaylistPlaylistTracksH $PlaylistPlaylistTracksHFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracksH playlistPlaylistTracksH = PlaylistPlaylistTracksH();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		playlistPlaylistTracksH.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		playlistPlaylistTracksH.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		playlistPlaylistTracksH.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		playlistPlaylistTracksH.vd = vd;
	}
	return playlistPlaylistTracksH;
}

Map<String, dynamic> $PlaylistPlaylistTracksHToJson(PlaylistPlaylistTracksH entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	return data;
}

PlaylistPlaylistTracksM $PlaylistPlaylistTracksMFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracksM playlistPlaylistTracksM = PlaylistPlaylistTracksM();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		playlistPlaylistTracksM.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		playlistPlaylistTracksM.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		playlistPlaylistTracksM.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		playlistPlaylistTracksM.vd = vd;
	}
	return playlistPlaylistTracksM;
}

Map<String, dynamic> $PlaylistPlaylistTracksMToJson(PlaylistPlaylistTracksM entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	return data;
}

PlaylistPlaylistTracksL $PlaylistPlaylistTracksLFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracksL playlistPlaylistTracksL = PlaylistPlaylistTracksL();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		playlistPlaylistTracksL.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		playlistPlaylistTracksL.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		playlistPlaylistTracksL.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		playlistPlaylistTracksL.vd = vd;
	}
	return playlistPlaylistTracksL;
}

Map<String, dynamic> $PlaylistPlaylistTracksLToJson(PlaylistPlaylistTracksL entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	return data;
}

PlaylistPlaylistTracksSq $PlaylistPlaylistTracksSqFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTracksSq playlistPlaylistTracksSq = PlaylistPlaylistTracksSq();
	final int? br = jsonConvert.convert<int>(json['br']);
	if (br != null) {
		playlistPlaylistTracksSq.br = br;
	}
	final int? fid = jsonConvert.convert<int>(json['fid']);
	if (fid != null) {
		playlistPlaylistTracksSq.fid = fid;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		playlistPlaylistTracksSq.size = size;
	}
	final double? vd = jsonConvert.convert<double>(json['vd']);
	if (vd != null) {
		playlistPlaylistTracksSq.vd = vd;
	}
	return playlistPlaylistTracksSq;
}

Map<String, dynamic> $PlaylistPlaylistTracksSqToJson(PlaylistPlaylistTracksSq entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['br'] = entity.br;
	data['fid'] = entity.fid;
	data['size'] = entity.size;
	data['vd'] = entity.vd;
	return data;
}

PlaylistPlaylistTrackIds $PlaylistPlaylistTrackIdsFromJson(Map<String, dynamic> json) {
	final PlaylistPlaylistTrackIds playlistPlaylistTrackIds = PlaylistPlaylistTrackIds();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		playlistPlaylistTrackIds.id = id;
	}
	final int? v = jsonConvert.convert<int>(json['v']);
	if (v != null) {
		playlistPlaylistTrackIds.v = v;
	}
	final int? t = jsonConvert.convert<int>(json['t']);
	if (t != null) {
		playlistPlaylistTrackIds.t = t;
	}
	final int? at = jsonConvert.convert<int>(json['at']);
	if (at != null) {
		playlistPlaylistTrackIds.at = at;
	}
	final dynamic? alg = jsonConvert.convert<dynamic>(json['alg']);
	if (alg != null) {
		playlistPlaylistTrackIds.alg = alg;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		playlistPlaylistTrackIds.uid = uid;
	}
	final String? rcmdReason = jsonConvert.convert<String>(json['rcmdReason']);
	if (rcmdReason != null) {
		playlistPlaylistTrackIds.rcmdReason = rcmdReason;
	}
	final dynamic? sc = jsonConvert.convert<dynamic>(json['sc']);
	if (sc != null) {
		playlistPlaylistTrackIds.sc = sc;
	}
	return playlistPlaylistTrackIds;
}

Map<String, dynamic> $PlaylistPlaylistTrackIdsToJson(PlaylistPlaylistTrackIds entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['v'] = entity.v;
	data['t'] = entity.t;
	data['at'] = entity.at;
	data['alg'] = entity.alg;
	data['uid'] = entity.uid;
	data['rcmdReason'] = entity.rcmdReason;
	data['sc'] = entity.sc;
	return data;
}

PlaylistPrivileges $PlaylistPrivilegesFromJson(Map<String, dynamic> json) {
	final PlaylistPrivileges playlistPrivileges = PlaylistPrivileges();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		playlistPrivileges.id = id;
	}
	final int? fee = jsonConvert.convert<int>(json['fee']);
	if (fee != null) {
		playlistPrivileges.fee = fee;
	}
	final int? payed = jsonConvert.convert<int>(json['payed']);
	if (payed != null) {
		playlistPrivileges.payed = payed;
	}
	final int? realPayed = jsonConvert.convert<int>(json['realPayed']);
	if (realPayed != null) {
		playlistPrivileges.realPayed = realPayed;
	}
	final int? st = jsonConvert.convert<int>(json['st']);
	if (st != null) {
		playlistPrivileges.st = st;
	}
	final int? pl = jsonConvert.convert<int>(json['pl']);
	if (pl != null) {
		playlistPrivileges.pl = pl;
	}
	final int? dl = jsonConvert.convert<int>(json['dl']);
	if (dl != null) {
		playlistPrivileges.dl = dl;
	}
	final int? sp = jsonConvert.convert<int>(json['sp']);
	if (sp != null) {
		playlistPrivileges.sp = sp;
	}
	final int? cp = jsonConvert.convert<int>(json['cp']);
	if (cp != null) {
		playlistPrivileges.cp = cp;
	}
	final int? subp = jsonConvert.convert<int>(json['subp']);
	if (subp != null) {
		playlistPrivileges.subp = subp;
	}
	final bool? cs = jsonConvert.convert<bool>(json['cs']);
	if (cs != null) {
		playlistPrivileges.cs = cs;
	}
	final int? maxbr = jsonConvert.convert<int>(json['maxbr']);
	if (maxbr != null) {
		playlistPrivileges.maxbr = maxbr;
	}
	final int? fl = jsonConvert.convert<int>(json['fl']);
	if (fl != null) {
		playlistPrivileges.fl = fl;
	}
	final dynamic? pc = jsonConvert.convert<dynamic>(json['pc']);
	if (pc != null) {
		playlistPrivileges.pc = pc;
	}
	final bool? toast = jsonConvert.convert<bool>(json['toast']);
	if (toast != null) {
		playlistPrivileges.toast = toast;
	}
	final int? flag = jsonConvert.convert<int>(json['flag']);
	if (flag != null) {
		playlistPrivileges.flag = flag;
	}
	final bool? paidBigBang = jsonConvert.convert<bool>(json['paidBigBang']);
	if (paidBigBang != null) {
		playlistPrivileges.paidBigBang = paidBigBang;
	}
	final bool? preSell = jsonConvert.convert<bool>(json['preSell']);
	if (preSell != null) {
		playlistPrivileges.preSell = preSell;
	}
	final int? playMaxbr = jsonConvert.convert<int>(json['playMaxbr']);
	if (playMaxbr != null) {
		playlistPrivileges.playMaxbr = playMaxbr;
	}
	final int? downloadMaxbr = jsonConvert.convert<int>(json['downloadMaxbr']);
	if (downloadMaxbr != null) {
		playlistPrivileges.downloadMaxbr = downloadMaxbr;
	}
	final String? maxBrLevel = jsonConvert.convert<String>(json['maxBrLevel']);
	if (maxBrLevel != null) {
		playlistPrivileges.maxBrLevel = maxBrLevel;
	}
	final String? playMaxBrLevel = jsonConvert.convert<String>(json['playMaxBrLevel']);
	if (playMaxBrLevel != null) {
		playlistPrivileges.playMaxBrLevel = playMaxBrLevel;
	}
	final String? downloadMaxBrLevel = jsonConvert.convert<String>(json['downloadMaxBrLevel']);
	if (downloadMaxBrLevel != null) {
		playlistPrivileges.downloadMaxBrLevel = downloadMaxBrLevel;
	}
	final String? plLevel = jsonConvert.convert<String>(json['plLevel']);
	if (plLevel != null) {
		playlistPrivileges.plLevel = plLevel;
	}
	final String? dlLevel = jsonConvert.convert<String>(json['dlLevel']);
	if (dlLevel != null) {
		playlistPrivileges.dlLevel = dlLevel;
	}
	final String? flLevel = jsonConvert.convert<String>(json['flLevel']);
	if (flLevel != null) {
		playlistPrivileges.flLevel = flLevel;
	}
	final dynamic? rscl = jsonConvert.convert<dynamic>(json['rscl']);
	if (rscl != null) {
		playlistPrivileges.rscl = rscl;
	}
	final PlaylistPrivilegesFreeTrialPrivilege? freeTrialPrivilege = jsonConvert.convert<PlaylistPrivilegesFreeTrialPrivilege>(json['freeTrialPrivilege']);
	if (freeTrialPrivilege != null) {
		playlistPrivileges.freeTrialPrivilege = freeTrialPrivilege;
	}
	final List<PlaylistPrivilegesChargeInfoList>? chargeInfoList = jsonConvert.convertListNotNull<PlaylistPrivilegesChargeInfoList>(json['chargeInfoList']);
	if (chargeInfoList != null) {
		playlistPrivileges.chargeInfoList = chargeInfoList;
	}
	return playlistPrivileges;
}

Map<String, dynamic> $PlaylistPrivilegesToJson(PlaylistPrivileges entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['fee'] = entity.fee;
	data['payed'] = entity.payed;
	data['realPayed'] = entity.realPayed;
	data['st'] = entity.st;
	data['pl'] = entity.pl;
	data['dl'] = entity.dl;
	data['sp'] = entity.sp;
	data['cp'] = entity.cp;
	data['subp'] = entity.subp;
	data['cs'] = entity.cs;
	data['maxbr'] = entity.maxbr;
	data['fl'] = entity.fl;
	data['pc'] = entity.pc;
	data['toast'] = entity.toast;
	data['flag'] = entity.flag;
	data['paidBigBang'] = entity.paidBigBang;
	data['preSell'] = entity.preSell;
	data['playMaxbr'] = entity.playMaxbr;
	data['downloadMaxbr'] = entity.downloadMaxbr;
	data['maxBrLevel'] = entity.maxBrLevel;
	data['playMaxBrLevel'] = entity.playMaxBrLevel;
	data['downloadMaxBrLevel'] = entity.downloadMaxBrLevel;
	data['plLevel'] = entity.plLevel;
	data['dlLevel'] = entity.dlLevel;
	data['flLevel'] = entity.flLevel;
	data['rscl'] = entity.rscl;
	data['freeTrialPrivilege'] = entity.freeTrialPrivilege?.toJson();
	data['chargeInfoList'] =  entity.chargeInfoList?.map((v) => v.toJson()).toList();
	return data;
}

PlaylistPrivilegesFreeTrialPrivilege $PlaylistPrivilegesFreeTrialPrivilegeFromJson(Map<String, dynamic> json) {
	final PlaylistPrivilegesFreeTrialPrivilege playlistPrivilegesFreeTrialPrivilege = PlaylistPrivilegesFreeTrialPrivilege();
	final bool? resConsumable = jsonConvert.convert<bool>(json['resConsumable']);
	if (resConsumable != null) {
		playlistPrivilegesFreeTrialPrivilege.resConsumable = resConsumable;
	}
	final bool? userConsumable = jsonConvert.convert<bool>(json['userConsumable']);
	if (userConsumable != null) {
		playlistPrivilegesFreeTrialPrivilege.userConsumable = userConsumable;
	}
	final dynamic? listenType = jsonConvert.convert<dynamic>(json['listenType']);
	if (listenType != null) {
		playlistPrivilegesFreeTrialPrivilege.listenType = listenType;
	}
	return playlistPrivilegesFreeTrialPrivilege;
}

Map<String, dynamic> $PlaylistPrivilegesFreeTrialPrivilegeToJson(PlaylistPrivilegesFreeTrialPrivilege entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['resConsumable'] = entity.resConsumable;
	data['userConsumable'] = entity.userConsumable;
	data['listenType'] = entity.listenType;
	return data;
}

PlaylistPrivilegesChargeInfoList $PlaylistPrivilegesChargeInfoListFromJson(Map<String, dynamic> json) {
	final PlaylistPrivilegesChargeInfoList playlistPrivilegesChargeInfoList = PlaylistPrivilegesChargeInfoList();
	final int? rate = jsonConvert.convert<int>(json['rate']);
	if (rate != null) {
		playlistPrivilegesChargeInfoList.rate = rate;
	}
	final dynamic? chargeUrl = jsonConvert.convert<dynamic>(json['chargeUrl']);
	if (chargeUrl != null) {
		playlistPrivilegesChargeInfoList.chargeUrl = chargeUrl;
	}
	final dynamic? chargeMessage = jsonConvert.convert<dynamic>(json['chargeMessage']);
	if (chargeMessage != null) {
		playlistPrivilegesChargeInfoList.chargeMessage = chargeMessage;
	}
	final int? chargeType = jsonConvert.convert<int>(json['chargeType']);
	if (chargeType != null) {
		playlistPrivilegesChargeInfoList.chargeType = chargeType;
	}
	return playlistPrivilegesChargeInfoList;
}

Map<String, dynamic> $PlaylistPrivilegesChargeInfoListToJson(PlaylistPrivilegesChargeInfoList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['rate'] = entity.rate;
	data['chargeUrl'] = entity.chargeUrl;
	data['chargeMessage'] = entity.chargeMessage;
	data['chargeType'] = entity.chargeType;
	return data;
}