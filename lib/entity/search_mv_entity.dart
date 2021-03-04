class SearchMvEntity {
	SearchMvResult result;
	int code;

	SearchMvEntity({this.result, this.code});

	SearchMvEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new SearchMvResult.fromJson(json['result']) : null;
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

class SearchMvResult {
	int mvCount;
	List<SearchMvResultMv> mvs;

	SearchMvResult({this.mvCount, this.mvs});

	SearchMvResult.fromJson(Map<String, dynamic> json) {
		mvCount = json['mvCount'];
		if (json['mvs'] != null) {
			mvs = new List<SearchMvResultMv>();(json['mvs'] as List).forEach((v) { mvs.add(new SearchMvResultMv.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mvCount'] = this.mvCount;
		if (this.mvs != null) {
      data['mvs'] =  this.mvs.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchMvResultMv {
	String arTransName;
	int artistId;
	String cover;
	int duration;
	int playCount;
	String briefDesc;
	List<SearchMvResultMvsArtist> artists;
	dynamic transNames;
	String name;
	dynamic alias;
	String artistName;
	int id;
	String alg;
	int mark;
	dynamic desc;

	SearchMvResultMv({this.arTransName, this.artistId, this.cover, this.duration, this.playCount, this.briefDesc, this.artists, this.transNames, this.name, this.alias, this.artistName, this.id, this.alg, this.mark, this.desc});

	SearchMvResultMv.fromJson(Map<String, dynamic> json) {
		arTransName = json['arTransName'];
		artistId = json['artistId'];
		cover = json['cover'];
		duration = json['duration'];
		playCount = json['playCount'];
		briefDesc = json['briefDesc'];
		if (json['artists'] != null) {
			artists = new List<SearchMvResultMvsArtist>();(json['artists'] as List).forEach((v) { artists.add(new SearchMvResultMvsArtist.fromJson(v)); });
		}
		transNames = json['transNames'];
		name = json['name'];
		alias = json['alias'];
		artistName = json['artistName'];
		id = json['id'];
		alg = json['alg'];
		mark = json['mark'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['arTransName'] = this.arTransName;
		data['artistId'] = this.artistId;
		data['cover'] = this.cover;
		data['duration'] = this.duration;
		data['playCount'] = this.playCount;
		data['briefDesc'] = this.briefDesc;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		data['transNames'] = this.transNames;
		data['name'] = this.name;
		data['alias'] = this.alias;
		data['artistName'] = this.artistName;
		data['id'] = this.id;
		data['alg'] = this.alg;
		data['mark'] = this.mark;
		data['desc'] = this.desc;
		return data;
	}
}

class SearchMvResultMvsArtist {
	dynamic transNames;
	String name;
	List<String> alias;
	int id;

	SearchMvResultMvsArtist({this.transNames, this.name, this.alias, this.id});

	SearchMvResultMvsArtist.fromJson(Map<String, dynamic> json) {
		transNames = json['transNames'];
		name = json['name'];
		alias = json['alias']?.cast<String>();
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['transNames'] = this.transNames;
		data['name'] = this.name;
		data['alias'] = this.alias;
		data['id'] = this.id;
		return data;
	}
}
