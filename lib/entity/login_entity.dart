class LoginEntity {
	num code;
	num lognumype;
	LoginProfile profile;
	List<LoginBinding> bindings;
	LoginAccount account;

	LoginEntity({this.code, this.lognumype, this.profile, this.bindings, this.account});

	LoginEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		lognumype = json['lognumype'];
		profile = json['profile'] != null ? new LoginProfile.fromJson(json['profile']) : null;
		if (json['bindings'] != null) {
			bindings = new List<LoginBinding>();(json['bindings'] as List).forEach((v) { bindings.add(new LoginBinding.fromJson(v)); });
		}
		account = json['account'] != null ? new LoginAccount.fromJson(json['account']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['lognumype'] = this.lognumype;
		if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
		if (this.bindings != null) {
      data['bindings'] =  this.bindings.map((v) => v.toJson()).toList();
    }
		if (this.account != null) {
      data['account'] = this.account.toJson();
    }
		return data;
	}
}

class LoginProfile {
	num birthday;
	String detailDescription;
	String backgroundUrl;
	num gender;
	num city;
	String signature;
	num followeds;
	String description;
	dynamic remarkName;
	num eventCount;
	num playlistBeSubscribedCount;
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
	num follows;
	num vipType;
	num userId;
	bool followed;
	bool mutual;
	String avatarimgidStr;
	num authority;
	num backgroundImgId;
	num userType;
	LoginProfileExperts experts;
	num playlistCount;

	LoginProfile({this.birthday, this.detailDescription, this.backgroundUrl, this.gender, this.city, this.signature, this.followeds, this.description, this.remarkName, this.eventCount, this.playlistBeSubscribedCount, this.accountStatus, this.avatarImgId, this.defaultAvatar, this.avatarImgIdStr, this.backgroundImgIdStr, this.province, this.nickname, this.expertTags, this.djStatus, this.avatarUrl, this.authStatus, this.follows, this.vipType, this.userId, this.followed, this.mutual, this.avatarimgidStr, this.authority, this.backgroundImgId, this.userType, this.experts, this.playlistCount});

	LoginProfile.fromJson(Map<String, dynamic> json) {
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
		playlistBeSubscribedCount = json['playlistBeSubscribedCount'];
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
		follows = json['follows'];
		vipType = json['vipType'];
		userId = json['userId'];
		followed = json['followed'];
		mutual = json['mutual'];
		avatarimgidStr = json['avatarImgId_str'];
		authority = json['authority'];
		backgroundImgId = json['backgroundImgId'];
		userType = json['userType'];
		experts = json['experts'] != null ? new LoginProfileExperts.fromJson(json['experts']) : null;
		playlistCount = json['playlistCount'];
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
		data['playlistBeSubscribedCount'] = this.playlistBeSubscribedCount;
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
		data['follows'] = this.follows;
		data['vipType'] = this.vipType;
		data['userId'] = this.userId;
		data['followed'] = this.followed;
		data['mutual'] = this.mutual;
		data['avatarImgId_str'] = this.avatarimgidStr;
		data['authority'] = this.authority;
		data['backgroundImgId'] = this.backgroundImgId;
		data['userType'] = this.userType;
		if (this.experts != null) {
      data['experts'] = this.experts.toJson();
    }
		data['playlistCount'] = this.playlistCount;
		return data;
	}
}

class LoginProfileExperts {



	LoginProfileExperts.fromJson(Map<String, dynamic> json);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}

class LoginBinding {
	num expiresIn;
	bool expired;
	String tokenJsonStr;
	num refreshTime;
	num id;
	num type;
	num userId;
	num bindingTime;
	String url;

	LoginBinding({this.expiresIn, this.expired, this.tokenJsonStr, this.refreshTime, this.id, this.type, this.userId, this.bindingTime, this.url});

	LoginBinding.fromJson(Map<String, dynamic> json) {
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

class LoginAccount {
//	String salt;
	num vipType;
	String userName;
	num type;
	num ban;
	bool anonimousUser;
	num createTime;
	num tokenVersion;
	num id;
	num whitelistAuthority;
	num baoyueVersion;
	num viptypeVersion;
	num donateVersion;
	num status;

	LoginAccount({this.vipType, this.userName, this.type, this.ban, this.anonimousUser, this.createTime, this.tokenVersion, this.id, this.whitelistAuthority, this.baoyueVersion, this.viptypeVersion, this.donateVersion, this.status});

	LoginAccount.fromJson(Map<String, dynamic> json) {
//		salt = json['salt'];
		vipType = json['vipType'];
		userName = json['userName'];
		type = json['type'];
		ban = json['ban'];
		anonimousUser = json['anonimousUser'];
		createTime = json['createTime'];
		tokenVersion = json['tokenVersion'];
		id = json['id'];
		whitelistAuthority = json['whitelistAuthority'];
		baoyueVersion = json['baoyueVersion'];
		viptypeVersion = json['viptypeVersion'];
		donateVersion = json['donateVersion'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['salt'] = this.salt;
		data['vipType'] = this.vipType;
		data['userName'] = this.userName;
		data['type'] = this.type;
		data['ban'] = this.ban;
		data['anonimousUser'] = this.anonimousUser;
		data['createTime'] = this.createTime;
		data['tokenVersion'] = this.tokenVersion;
		data['id'] = this.id;
		data['whitelistAuthority'] = this.whitelistAuthority;
		data['baoyueVersion'] = this.baoyueVersion;
		data['viptypeVersion'] = this.viptypeVersion;
		data['donateVersion'] = this.donateVersion;
		data['status'] = this.status;
		return data;
	}
}
