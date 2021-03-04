class SearchSingerEntity {
	SearchSingerResult result;
	int code;

	SearchSingerEntity({this.result, this.code});

	SearchSingerEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new SearchSingerResult.fromJson(json['result']) : null;
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

class SearchSingerResult {
	int artistCount;
	List<SearchSingerResultArtist> artists;

	SearchSingerResult({this.artistCount, this.artists});

	SearchSingerResult.fromJson(Map<String, dynamic> json) {
		artistCount = json['artistCount'];
		if (json['artists'] != null) {
			artists = new List<SearchSingerResultArtist>();(json['artists'] as List).forEach((v) { artists.add(new SearchSingerResultArtist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['artistCount'] = this.artistCount;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchSingerResultArtist {
	String img1v1Url;
	int mvSize;
	bool followed;
	int albumSize;
	List<String> alia;
	String picUrl;
	int accountId;
	int img1v1;
	String name;
	List<Null> alias;
	int id;
	String alg;
	int picId;
	dynamic trans;

	SearchSingerResultArtist({this.img1v1Url, this.mvSize, this.followed, this.albumSize, this.alia, this.picUrl, this.accountId, this.img1v1, this.name, this.alias, this.id, this.alg, this.picId, this.trans});

	SearchSingerResultArtist.fromJson(Map<String, dynamic> json) {
		img1v1Url = json['img1v1Url'];
		mvSize = json['mvSize'];
		followed = json['followed'];
		albumSize = json['albumSize'];
		alia = json['alia']?.cast<String>();
		picUrl = json['picUrl'];
		accountId = json['accountId'];
		img1v1 = json['img1v1'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		id = json['id'];
		alg = json['alg'];
		picId = json['picId'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img1v1Url'] = this.img1v1Url;
		data['mvSize'] = this.mvSize;
		data['followed'] = this.followed;
		data['albumSize'] = this.albumSize;
		data['alia'] = this.alia;
		data['picUrl'] = this.picUrl;
		data['accountId'] = this.accountId;
		data['img1v1'] = this.img1v1;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['id'] = this.id;
		data['alg'] = this.alg;
		data['picId'] = this.picId;
		data['trans'] = this.trans;
		return data;
	}
}
