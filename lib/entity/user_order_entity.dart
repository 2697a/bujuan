class UserOrderEntity {
	num code;
	List<UserOrderPlaylist> playlist;
	bool more;

	UserOrderEntity({this.code, this.playlist, this.more});

	UserOrderEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['playlist'] != null) {
			playlist = new List<UserOrderPlaylist>();(json['playlist'] as List).forEach((v) { playlist.add(new UserOrderPlaylist.fromJson(v)); });
		}
		more = json['more'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.playlist != null) {
      data['playlist'] =  this.playlist.map((v) => v.toJson()).toList();
    }
		data['more'] = this.more;
		return data;
	}
}

class UserOrderPlaylist {
	String description;
	num privacy;
	num trackNumberUpdateTime;
	bool subscribed;
	num adType;
	num trackCount;
	String coverimgidStr;
	num specialType;
	dynamic artists;
	num id;
	num totalDuration;
	bool ordered;
	UserOrderPlaylistCreator creator;
	List<Null> subscribers;
	dynamic backgroundCoverUrl;
	bool highQuality;
	String commentThreadId;
	num updateTime;
	num trackUpdateTime;
	num userId;
	dynamic tracks;
	bool anonimous;
	List<String> tags;
	num cloudTrackCount;
	String coverImgUrl;
	num playCount;
	num coverImgId;
	num createTime;
	String name;
	num backgroundCoverId;
	num subscribedCount;
	dynamic updateFrequency;
	num status;
	bool newImported;

	UserOrderPlaylist({this.description, this.privacy, this.trackNumberUpdateTime, this.subscribed, this.adType, this.trackCount, this.coverimgidStr, this.specialType, this.artists, this.id, this.totalDuration, this.ordered, this.creator, this.subscribers, this.backgroundCoverUrl, this.highQuality, this.commentThreadId, this.updateTime, this.trackUpdateTime, this.userId, this.tracks, this.anonimous, this.tags, this.cloudTrackCount, this.coverImgUrl, this.playCount, this.coverImgId, this.createTime, this.name, this.backgroundCoverId, this.subscribedCount, this.updateFrequency, this.status, this.newImported});

	UserOrderPlaylist.fromJson(Map<String, dynamic> json) {
		description = json['description'];
		privacy = json['privacy'];
		trackNumberUpdateTime = json['trackNumberUpdateTime'];
		subscribed = json['subscribed'];
		adType = json['adType'];
		trackCount = json['trackCount'];
		coverimgidStr = json['coverImgId_str'];
		specialType = json['specialType'];
		artists = json['artists'];
		id = json['id'];
		totalDuration = json['totalDuration'];
		ordered = json['ordered'];
		creator = json['creator'] != null ? new UserOrderPlaylistCreator.fromJson(json['creator']) : null;
		if (json['subscribers'] != null) {
			subscribers = new List<Null>();
		}
		backgroundCoverUrl = json['backgroundCoverUrl'];
		highQuality = json['highQuality'];
		commentThreadId = json['commentThreadId'];
		updateTime = json['updateTime'];
		trackUpdateTime = json['trackUpdateTime'];
		userId = json['userId'];
		tracks = json['tracks'];
		anonimous = json['anonimous'];
		tags = json['tags']?.cast<String>();
		cloudTrackCount = json['cloudTrackCount'];
		coverImgUrl = json['coverImgUrl'];
		playCount = json['playCount'];
		coverImgId = json['coverImgId'];
		createTime = json['createTime'];
		name = json['name'];
		backgroundCoverId = json['backgroundCoverId'];
		subscribedCount = json['subscribedCount'];
		updateFrequency = json['updateFrequency'];
		status = json['status'];
		newImported = json['newImported'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['description'] = this.description;
		data['privacy'] = this.privacy;
		data['trackNumberUpdateTime'] = this.trackNumberUpdateTime;
		data['subscribed'] = this.subscribed;
		data['adType'] = this.adType;
		data['trackCount'] = this.trackCount;
		data['coverImgId_str'] = this.coverimgidStr;
		data['specialType'] = this.specialType;
		data['artists'] = this.artists;
		data['id'] = this.id;
		data['totalDuration'] = this.totalDuration;
		data['ordered'] = this.ordered;
		if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
		if (this.subscribers != null) {
      data['subscribers'] =  [];
    }
		data['backgroundCoverUrl'] = this.backgroundCoverUrl;
		data['highQuality'] = this.highQuality;
		data['commentThreadId'] = this.commentThreadId;
		data['updateTime'] = this.updateTime;
		data['trackUpdateTime'] = this.trackUpdateTime;
		data['userId'] = this.userId;
		data['tracks'] = this.tracks;
		data['anonimous'] = this.anonimous;
		data['tags'] = this.tags;
		data['cloudTrackCount'] = this.cloudTrackCount;
		data['coverImgUrl'] = this.coverImgUrl;
		data['playCount'] = this.playCount;
		data['coverImgId'] = this.coverImgId;
		data['createTime'] = this.createTime;
		data['name'] = this.name;
		data['backgroundCoverId'] = this.backgroundCoverId;
		data['subscribedCount'] = this.subscribedCount;
		data['updateFrequency'] = this.updateFrequency;
		data['status'] = this.status;
		data['newImported'] = this.newImported;
		return data;
	}
}

class UserOrderPlaylistCreator {
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

	UserOrderPlaylistCreator({this.birthday, this.detailDescription, this.backgroundUrl, this.gender, this.city, this.signature, this.description, this.remarkName, this.accountStatus, this.avatarImgId, this.defaultAvatar, this.avatarImgIdStr, this.backgroundImgIdStr, this.province, this.nickname, this.expertTags, this.djStatus, this.avatarUrl, this.authStatus, this.vipType, this.followed, this.userId, this.mutual, this.avatarimgidStr, this.authority, this.userType, this.backgroundImgId, this.experts});

	UserOrderPlaylistCreator.fromJson(Map<String, dynamic> json) {
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
