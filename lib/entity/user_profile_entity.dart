class UserProfileEntity {
	UserProfileUserpoint userPoint;
	bool adValid;
	int code;
	int level;
	int createTime;
	int listenSongs;
	int createDays;
	UserProfileProfile profile;
	List<UserProfileBinding> bindings;
	bool pcSign;
	bool mobileSign;
	bool peopleCanSeeMyPlayRecord;

	UserProfileEntity({this.userPoint, this.adValid, this.code, this.level, this.createTime, this.listenSongs, this.createDays, this.profile, this.bindings, this.pcSign, this.mobileSign, this.peopleCanSeeMyPlayRecord});

	UserProfileEntity.fromJson(Map<String, dynamic> json) {
		userPoint = json['userPoint'] != null ? new UserProfileUserpoint.fromJson(json['userPoint']) : null;
		adValid = json['adValid'];
		code = json['code'];
		level = json['level'];
		createTime = json['createTime'];
		listenSongs = json['listenSongs'];
		createDays = json['createDays'];
		profile = json['profile'] != null ? new UserProfileProfile.fromJson(json['profile']) : null;
		if (json['bindings'] != null) {
			bindings = new List<UserProfileBinding>();(json['bindings'] as List).forEach((v) { bindings.add(new UserProfileBinding.fromJson(v)); });
		}
		pcSign = json['pcSign'];
		mobileSign = json['mobileSign'];
		peopleCanSeeMyPlayRecord = json['peopleCanSeeMyPlayRecord'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.userPoint != null) {
      data['userPoint'] = this.userPoint.toJson();
    }
		data['adValid'] = this.adValid;
		data['code'] = this.code;
		data['level'] = this.level;
		data['createTime'] = this.createTime;
		data['listenSongs'] = this.listenSongs;
		data['createDays'] = this.createDays;
		if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
		if (this.bindings != null) {
      data['bindings'] =  this.bindings.map((v) => v.toJson()).toList();
    }
		data['pcSign'] = this.pcSign;
		data['mobileSign'] = this.mobileSign;
		data['peopleCanSeeMyPlayRecord'] = this.peopleCanSeeMyPlayRecord;
		return data;
	}
}

class UserProfileUserpoint {
	int balance;
	int blockBalance;
	int updateTime;
	int userId;
	int version;
	int status;

	UserProfileUserpoint({this.balance, this.blockBalance, this.updateTime, this.userId, this.version, this.status});

	UserProfileUserpoint.fromJson(Map<String, dynamic> json) {
		balance = json['balance'];
		blockBalance = json['blockBalance'];
		updateTime = json['updateTime'];
		userId = json['userId'];
		version = json['version'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['balance'] = this.balance;
		data['blockBalance'] = this.blockBalance;
		data['updateTime'] = this.updateTime;
		data['userId'] = this.userId;
		data['version'] = this.version;
		data['status'] = this.status;
		return data;
	}
}

class UserProfileProfile {
	int birthday;
	String detailDescription;
	String backgroundUrl;
	int gender;
	int city;
	String signature;
	int followeds;
	String description;
	dynamic remarkName;
	int eventCount;
	int allSubscribedCount;
	int playlistBeSubscribedCount;
	int accountStatus;
	int avatarImgId;
	bool defaultAvatar;
	String backgroundImgIdStr;
	String avatarImgIdStr;
	int province;
	List<Null> artistIdentity;
	String nickname;
	dynamic expertTags;
	int sDJPCount;
	int newFollows;
	int djStatus;
	String avatarUrl;
	int authStatus;
	int follows;
	int vipType;
	bool blacklist;
	int userId;
	bool followed;
	bool mutual;
	String avatarimgidStr;
	dynamic followTime;
	int authority;
	int cCount;
	int userType;
	int backgroundImgId;
	UserProfileProfileExperts experts;
	int playlistCount;
	int sCount;

	UserProfileProfile({this.birthday, this.detailDescription, this.backgroundUrl, this.gender, this.city, this.signature, this.followeds, this.description, this.remarkName, this.eventCount, this.allSubscribedCount, this.playlistBeSubscribedCount, this.accountStatus, this.avatarImgId, this.defaultAvatar, this.backgroundImgIdStr, this.avatarImgIdStr, this.province, this.artistIdentity, this.nickname, this.expertTags, this.sDJPCount, this.newFollows, this.djStatus, this.avatarUrl, this.authStatus, this.follows, this.vipType, this.blacklist, this.userId, this.followed, this.mutual, this.avatarimgidStr, this.followTime, this.authority, this.cCount, this.userType, this.backgroundImgId, this.experts, this.playlistCount, this.sCount});

	UserProfileProfile.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		detailDescription = json['detailDescription'];
		backgroundUrl = json['backgroundUrl'];
		gender = json['gender'];
		city = json['city'];
		signature = json['signature'];
		followeds = json['followeds'];
		description = json['description'];
		remarkName = json['remarkName'];
		eventCount = json['eventCount'];
		allSubscribedCount = json['allSubscribedCount'];
		playlistBeSubscribedCount = json['playlistBeSubscribedCount'];
		accountStatus = json['accountStatus'];
		avatarImgId = json['avatarImgId'];
		defaultAvatar = json['defaultAvatar'];
		backgroundImgIdStr = json['backgroundImgIdStr'];
		avatarImgIdStr = json['avatarImgIdStr'];
		province = json['province'];
		if (json['artistIdentity'] != null) {
			artistIdentity = new List<Null>();
		}
		nickname = json['nickname'];
		expertTags = json['expertTags'];
		sDJPCount = json['sDJPCount'];
		newFollows = json['newFollows'];
		djStatus = json['djStatus'];
		avatarUrl = json['avatarUrl'];
		authStatus = json['authStatus'];
		follows = json['follows'];
		vipType = json['vipType'];
		blacklist = json['blacklist'];
		userId = json['userId'];
		followed = json['followed'];
		mutual = json['mutual'];
		avatarimgidStr = json['avatarImgId_str'];
		followTime = json['followTime'];
		authority = json['authority'];
		cCount = json['cCount'];
		userType = json['userType'];
		backgroundImgId = json['backgroundImgId'];
		playlistCount = json['playlistCount'];
		sCount = json['sCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['detailDescription'] = this.detailDescription;
		data['backgroundUrl'] = this.backgroundUrl;
		data['gender'] = this.gender;
		data['city'] = this.city;
		data['signature'] = this.signature;
		data['followeds'] = this.followeds;
		data['description'] = this.description;
		data['remarkName'] = this.remarkName;
		data['eventCount'] = this.eventCount;
		data['allSubscribedCount'] = this.allSubscribedCount;
		data['playlistBeSubscribedCount'] = this.playlistBeSubscribedCount;
		data['accountStatus'] = this.accountStatus;
		data['avatarImgId'] = this.avatarImgId;
		data['defaultAvatar'] = this.defaultAvatar;
		data['backgroundImgIdStr'] = this.backgroundImgIdStr;
		data['avatarImgIdStr'] = this.avatarImgIdStr;
		data['province'] = this.province;
		if (this.artistIdentity != null) {
      data['artistIdentity'] =  [];
    }
		data['nickname'] = this.nickname;
		data['expertTags'] = this.expertTags;
		data['sDJPCount'] = this.sDJPCount;
		data['newFollows'] = this.newFollows;
		data['djStatus'] = this.djStatus;
		data['avatarUrl'] = this.avatarUrl;
		data['authStatus'] = this.authStatus;
		data['follows'] = this.follows;
		data['vipType'] = this.vipType;
		data['blacklist'] = this.blacklist;
		data['userId'] = this.userId;
		data['followed'] = this.followed;
		data['mutual'] = this.mutual;
		data['avatarImgId_str'] = this.avatarimgidStr;
		data['followTime'] = this.followTime;
		data['authority'] = this.authority;
		data['cCount'] = this.cCount;
		data['userType'] = this.userType;
		data['backgroundImgId'] = this.backgroundImgId;
		if (this.experts != null) {
      data['experts'] = this.experts.toJson();
    }
		data['playlistCount'] = this.playlistCount;
		data['sCount'] = this.sCount;
		return data;
	}
}

class UserProfileProfileExperts {



	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}

class UserProfileBinding {
	int expiresIn;
	bool expired;
	dynamic tokenJsonStr;
	int refreshTime;
	int id;
	int type;
	int userId;
	int bindingTime;
	String url;

	UserProfileBinding({this.expiresIn, this.expired, this.tokenJsonStr, this.refreshTime, this.id, this.type, this.userId, this.bindingTime, this.url});

	UserProfileBinding.fromJson(Map<String, dynamic> json) {
		expiresIn = json['expiresIn'];
		expired = json['expired'];
		tokenJsonStr = json['tokenJsonStr'];
		refreshTime = json['refreshTime'];
		id = json['id'];
		type = json['type'];
		userId = json['userId'];
		bindingTime = json['bindingTime'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['expiresIn'] = this.expiresIn;
		data['expired'] = this.expired;
		data['tokenJsonStr'] = this.tokenJsonStr;
		data['refreshTime'] = this.refreshTime;
		data['id'] = this.id;
		data['type'] = this.type;
		data['userId'] = this.userId;
		data['bindingTime'] = this.bindingTime;
		data['url'] = this.url;
		return data;
	}
}
