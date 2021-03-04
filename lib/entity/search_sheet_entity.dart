class SearchSheetEntity {
	SearchSheetResult result;
	int code;

	SearchSheetEntity({this.result, this.code});

	SearchSheetEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new SearchSheetResult.fromJson(json['result']) : null;
		code = json['code'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] = this.result.toJson();
    }
		data['code'] = this.code;
		return data;
	}
}

class SearchSheetResult {
	List<SearchSheetResultPlaylist> playlists;
	int playlistCount;

	SearchSheetResult({this.playlists, this.playlistCount});

	SearchSheetResult.fromJson(Map<String, dynamic> json) {
		if (json['playlists'] != null) {
			playlists = new List<SearchSheetResultPlaylist>();(json['playlists'] as List).forEach((v) { playlists.add(new SearchSheetResultPlaylist.fromJson(v)); });
		}
		playlistCount = json['playlistCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.playlists != null) {
      data['playlists'] =  this.playlists.map((v) => v.toJson()).toList();
    }
		data['playlistCount'] = this.playlistCount;
		return data;
	}
}

class SearchSheetResultPlaylist {
	String coverImgUrl;
	bool subscribed;
	int playCount;
	SearchSheetResultPlaylistsCreator creator;
	int trackCount;
	int bookCount;
	String name;
	String description;
	bool highQuality;
	int id;
	int userId;
	String alg;

	SearchSheetResultPlaylist({this.coverImgUrl, this.subscribed, this.playCount, this.creator, this.trackCount, this.bookCount, this.name, this.description, this.highQuality, this.id, this.userId, this.alg});

	SearchSheetResultPlaylist.fromJson(Map<String, dynamic> json) {
		coverImgUrl = json['coverImgUrl'];
		subscribed = json['subscribed'];
		playCount = json['playCount'];
		creator = json['creator'] != null ? new SearchSheetResultPlaylistsCreator.fromJson(json['creator']) : null;
		trackCount = json['trackCount'];
		bookCount = json['bookCount'];
		name = json['name'];
		description = json['description'];
		highQuality = json['highQuality'];
		id = json['id'];
		userId = json['userId'];
		alg = json['alg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['coverImgUrl'] = this.coverImgUrl;
		data['subscribed'] = this.subscribed;
		data['playCount'] = this.playCount;
		if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
		data['trackCount'] = this.trackCount;
		data['bookCount'] = this.bookCount;
		data['name'] = this.name;
		data['description'] = this.description;
		data['highQuality'] = this.highQuality;
		data['id'] = this.id;
		data['userId'] = this.userId;
		data['alg'] = this.alg;
		return data;
	}
}

class SearchSheetResultPlaylistsCreator {
	int authStatus;
	String nickname;
	dynamic expertTags;
	int userType;
	int userId;
	dynamic experts;

	SearchSheetResultPlaylistsCreator({this.authStatus, this.nickname, this.expertTags, this.userType, this.userId, this.experts});

	SearchSheetResultPlaylistsCreator.fromJson(Map<String, dynamic> json) {
		authStatus = json['authStatus'];
		nickname = json['nickname'];
		expertTags = json['expertTags'];
		userType = json['userType'];
		userId = json['userId'];
		experts = json['experts'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['authStatus'] = this.authStatus;
		data['nickname'] = this.nickname;
		data['expertTags'] = this.expertTags;
		data['userType'] = this.userType;
		data['userId'] = this.userId;
		data['experts'] = this.experts;
		return data;
	}
}
