class HighqualityEntity {
	num lasttime;
	num total;
	num code;
	bool more;
	List<HighqualityPlaylist> playlists;

	HighqualityEntity({this.lasttime, this.total, this.code, this.more, this.playlists});

	HighqualityEntity.fromJson(Map<String, dynamic> json) {
		lasttime = json['lasttime'];
		total = json['total'];
		code = json['code'];
		more = json['more'];
		if (json['playlists'] != null) {
			playlists = new List<HighqualityPlaylist>();(json['playlists'] as List).forEach((v) { playlists.add(new HighqualityPlaylist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lasttime'] = this.lasttime;
		data['total'] = this.total;
		data['code'] = this.code;
		data['more'] = this.more;
		if (this.playlists != null) {
      data['playlists'] =  this.playlists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class HighqualityPlaylist {
	String description;
	num privacy;
	num trackNumberUpdateTime;
	bool subscribed;
	num shareCount;
	num trackCount;
	num adType;
	String coverimgidStr;
	num specialType;
	String copywriter;
	num id;
	String tag;
	num totalDuration;
	bool ordered;
	HighqualityPlaylistsCreator creator;
	List<HighqualityPlaylistsSubscriber> subscribers;
	String commentThreadId;
	bool highQuality;
	num updateTime;
	num trackUpdateTime;
	num userId;
	dynamic tracks;
	List<String> tags;
	bool anonimous;
	num commentCount;
	num cloudTrackCount;
	String coverImgUrl;
	num playCount;
	num coverImgId;
	num createTime;
	String name;
	num subscribedCount;
	num status;
	bool newImported;

	HighqualityPlaylist({this.description, this.privacy, this.trackNumberUpdateTime, this.subscribed, this.shareCount, this.trackCount, this.adType, this.coverimgidStr, this.specialType, this.copywriter, this.id, this.tag, this.totalDuration, this.ordered, this.creator, this.subscribers, this.commentThreadId, this.highQuality, this.updateTime, this.trackUpdateTime, this.userId, this.tracks, this.tags, this.anonimous, this.commentCount, this.cloudTrackCount, this.coverImgUrl, this.playCount, this.coverImgId, this.createTime, this.name, this.subscribedCount, this.status, this.newImported});

	HighqualityPlaylist.fromJson(Map<String, dynamic> json) {
		description = json['description'];
		privacy = json['privacy'];
		trackNumberUpdateTime = json['trackNumberUpdateTime'];
		subscribed = json['subscribed'];
		shareCount = json['shareCount'];
		trackCount = json['trackCount'];
		adType = json['adType'];
		coverimgidStr = json['coverImgId_str'];
		specialType = json['specialType'];
		copywriter = json['copywriter'];
		id = json['id'];
		tag = json['tag'];
		totalDuration = json['totalDuration'];
		ordered = json['ordered'];
		creator = json['creator'] != null ? new HighqualityPlaylistsCreator.fromJson(json['creator']) : null;
		if (json['subscribers'] != null) {
			subscribers = new List<HighqualityPlaylistsSubscriber>();(json['subscribers'] as List).forEach((v) { subscribers.add(new HighqualityPlaylistsSubscriber.fromJson(v)); });
		}
		commentThreadId = json['commentThreadId'];
		highQuality = json['highQuality'];
		updateTime = json['updateTime'];
		trackUpdateTime = json['trackUpdateTime'];
		userId = json['userId'];
		tracks = json['tracks'];
		tags = json['tags']?.cast<String>();
		anonimous = json['anonimous'];
		commentCount = json['commentCount'];
		cloudTrackCount = json['cloudTrackCount'];
		coverImgUrl = json['coverImgUrl'];
		playCount = json['playCount'];
		coverImgId = json['coverImgId'];
		createTime = json['createTime'];
		name = json['name'];
		subscribedCount = json['subscribedCount'];
		status = json['status'];
		newImported = json['newImported'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['description'] = this.description;
		data['privacy'] = this.privacy;
		data['trackNumberUpdateTime'] = this.trackNumberUpdateTime;
		data['subscribed'] = this.subscribed;
		data['shareCount'] = this.shareCount;
		data['trackCount'] = this.trackCount;
		data['adType'] = this.adType;
		data['coverImgId_str'] = this.coverimgidStr;
		data['specialType'] = this.specialType;
		data['copywriter'] = this.copywriter;
		data['id'] = this.id;
		data['tag'] = this.tag;
		data['totalDuration'] = this.totalDuration;
		data['ordered'] = this.ordered;
		if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
		if (this.subscribers != null) {
      data['subscribers'] =  this.subscribers.map((v) => v.toJson()).toList();
    }
		data['commentThreadId'] = this.commentThreadId;
		data['highQuality'] = this.highQuality;
		data['updateTime'] = this.updateTime;
		data['trackUpdateTime'] = this.trackUpdateTime;
		data['userId'] = this.userId;
		data['tracks'] = this.tracks;
		data['tags'] = this.tags;
		data['anonimous'] = this.anonimous;
		data['commentCount'] = this.commentCount;
		data['cloudTrackCount'] = this.cloudTrackCount;
		data['coverImgUrl'] = this.coverImgUrl;
		data['playCount'] = this.playCount;
		data['coverImgId'] = this.coverImgId;
		data['createTime'] = this.createTime;
		data['name'] = this.name;
		data['subscribedCount'] = this.subscribedCount;
		data['status'] = this.status;
		data['newImported'] = this.newImported;
		return data;
	}
}

class HighqualityPlaylistsCreator {
	num birthday;
	String detailDescription;
	String backgroundUrl;
	num gender;
	num city;
	String signature;
	String description;
	dynamic remarkName;
	num accountStatus;
	num avatarImgId;
	bool defaultAvatar;
	String avatarImgIdStr;
	String backgroundImgIdStr;
	num province;
	String nickname;
	List<String> expertTags;
	num djStatus;
	String avatarUrl;
	num authStatus;
	num vipType;
	bool followed;
	num userId;
	bool mutual;
	String avatarimgidStr;
	num authority;
	num userType;
	num backgroundImgId;
	dynamic experts;

	HighqualityPlaylistsCreator({this.birthday, this.detailDescription, this.backgroundUrl, this.gender, this.city, this.signature, this.description, this.remarkName, this.accountStatus, this.avatarImgId, this.defaultAvatar, this.avatarImgIdStr, this.backgroundImgIdStr, this.province, this.nickname, this.expertTags, this.djStatus, this.avatarUrl, this.authStatus, this.vipType, this.followed, this.userId, this.mutual, this.avatarimgidStr, this.authority, this.userType, this.backgroundImgId, this.experts});

	HighqualityPlaylistsCreator.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		detailDescription = json['detailDescription'];
		backgroundUrl = json['backgroundUrl'];
		gender = json['gender'];
		city = json['city'];
		signature = json['signature'];
		description = json['description'];
		remarkName = json['remarkName'];
		accountStatus = json['accountStatus'];
		avatarImgId = json['avatarImgId'];
		defaultAvatar = json['defaultAvatar'];
		avatarImgIdStr = json['avatarImgIdStr'];
		backgroundImgIdStr = json['backgroundImgIdStr'];
		province = json['province'];
		nickname = json['nickname'];
		expertTags = json['expertTags']?.cast<String>();
		djStatus = json['djStatus'];
		avatarUrl = json['avatarUrl'];
		authStatus = json['authStatus'];
		vipType = json['vipType'];
		followed = json['followed'];
		userId = json['userId'];
		mutual = json['mutual'];
		avatarimgidStr = json['avatarImgId_str'];
		authority = json['authority'];
		userType = json['userType'];
		backgroundImgId = json['backgroundImgId'];
		experts = json['experts'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['detailDescription'] = this.detailDescription;
		data['backgroundUrl'] = this.backgroundUrl;
		data['gender'] = this.gender;
		data['city'] = this.city;
		data['signature'] = this.signature;
		data['description'] = this.description;
		data['remarkName'] = this.remarkName;
		data['accountStatus'] = this.accountStatus;
		data['avatarImgId'] = this.avatarImgId;
		data['defaultAvatar'] = this.defaultAvatar;
		data['avatarImgIdStr'] = this.avatarImgIdStr;
		data['backgroundImgIdStr'] = this.backgroundImgIdStr;
		data['province'] = this.province;
		data['nickname'] = this.nickname;
		data['expertTags'] = this.expertTags;
		data['djStatus'] = this.djStatus;
		data['avatarUrl'] = this.avatarUrl;
		data['authStatus'] = this.authStatus;
		data['vipType'] = this.vipType;
		data['followed'] = this.followed;
		data['userId'] = this.userId;
		data['mutual'] = this.mutual;
		data['avatarImgId_str'] = this.avatarimgidStr;
		data['authority'] = this.authority;
		data['userType'] = this.userType;
		data['backgroundImgId'] = this.backgroundImgId;
		data['experts'] = this.experts;
		return data;
	}
}

class HighqualityPlaylistsSubscriber {
	num birthday;
	String detailDescription;
	String backgroundUrl;
	num gender;
	num city;
	String signature;
	String description;
	dynamic remarkName;
	num accountStatus;
	num avatarImgId;
	bool defaultAvatar;
	String avatarImgIdStr;
	String backgroundImgIdStr;
	num province;
	String nickname;
	dynamic expertTags;
	num djStatus;
	String avatarUrl;
	num authStatus;
	num vipType;
	bool followed;
	num userId;
	bool mutual;
	String avatarimgidStr;
	num authority;
	num userType;
	num backgroundImgId;
	dynamic experts;

	HighqualityPlaylistsSubscriber({this.birthday, this.detailDescription, this.backgroundUrl, this.gender, this.city, this.signature, this.description, this.remarkName, this.accountStatus, this.avatarImgId, this.defaultAvatar, this.avatarImgIdStr, this.backgroundImgIdStr, this.province, this.nickname, this.expertTags, this.djStatus, this.avatarUrl, this.authStatus, this.vipType, this.followed, this.userId, this.mutual, this.avatarimgidStr, this.authority, this.userType, this.backgroundImgId, this.experts});

	HighqualityPlaylistsSubscriber.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		detailDescription = json['detailDescription'];
		backgroundUrl = json['backgroundUrl'];
		gender = json['gender'];
		city = json['city'];
		signature = json['signature'];
		description = json['description'];
		remarkName = json['remarkName'];
		accountStatus = json['accountStatus'];
		avatarImgId = json['avatarImgId'];
		defaultAvatar = json['defaultAvatar'];
		avatarImgIdStr = json['avatarImgIdStr'];
		backgroundImgIdStr = json['backgroundImgIdStr'];
		province = json['province'];
		nickname = json['nickname'];
		expertTags = json['expertTags'];
		djStatus = json['djStatus'];
		avatarUrl = json['avatarUrl'];
		authStatus = json['authStatus'];
		vipType = json['vipType'];
		followed = json['followed'];
		userId = json['userId'];
		mutual = json['mutual'];
		avatarimgidStr = json['avatarImgId_str'];
		authority = json['authority'];
		userType = json['userType'];
		backgroundImgId = json['backgroundImgId'];
		experts = json['experts'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['detailDescription'] = this.detailDescription;
		data['backgroundUrl'] = this.backgroundUrl;
		data['gender'] = this.gender;
		data['city'] = this.city;
		data['signature'] = this.signature;
		data['description'] = this.description;
		data['remarkName'] = this.remarkName;
		data['accountStatus'] = this.accountStatus;
		data['avatarImgId'] = this.avatarImgId;
		data['defaultAvatar'] = this.defaultAvatar;
		data['avatarImgIdStr'] = this.avatarImgIdStr;
		data['backgroundImgIdStr'] = this.backgroundImgIdStr;
		data['province'] = this.province;
		data['nickname'] = this.nickname;
		data['expertTags'] = this.expertTags;
		data['djStatus'] = this.djStatus;
		data['avatarUrl'] = this.avatarUrl;
		data['authStatus'] = this.authStatus;
		data['vipType'] = this.vipType;
		data['followed'] = this.followed;
		data['userId'] = this.userId;
		data['mutual'] = this.mutual;
		data['avatarImgId_str'] = this.avatarimgidStr;
		data['authority'] = this.authority;
		data['userType'] = this.userType;
		data['backgroundImgId'] = this.backgroundImgId;
		data['experts'] = this.experts;
		return data;
	}
}
