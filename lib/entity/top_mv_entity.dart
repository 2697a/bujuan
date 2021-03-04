class TopMvEntity {
	num code;
	List<TopMvData> data;
	bool hasMore;
	num updateTime;

	TopMvEntity({this.code, this.data, this.hasMore, this.updateTime});

	TopMvEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<TopMvData>();(json['data'] as List).forEach((v) { data.add(new TopMvData.fromJson(v)); });
		}
		hasMore = json['hasMore'];
		updateTime = json['updateTime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['hasMore'] = this.hasMore;
		data['updateTime'] = this.updateTime;
		return data;
	}
}

class TopMvData {
	num lastRank;
	num artistId;
	String cover;
	num duration;
	num playCount;
	num score;
	bool subed;
	String briefDesc;
	List<TopMvDataArtist> artists;
	String name;
	List<String> alias;
	String artistName;
	num id;
	num mark;
	dynamic desc;

	TopMvData({this.lastRank, this.artistId, this.cover, this.duration, this.playCount, this.score, this.subed, this.briefDesc, this.artists, this.name, this.alias, this.artistName, this.id, this.mark, this.desc});

	TopMvData.fromJson(Map<String, dynamic> json) {
		lastRank = json['lastRank'];
		artistId = json['artistId'];
		cover = json['cover'];
		duration = json['duration'];
		playCount = json['playCount'];
		score = json['score'];
		subed = json['subed'];
		briefDesc = json['briefDesc'];
		if (json['artists'] != null) {
			artists = new List<TopMvDataArtist>();(json['artists'] as List).forEach((v) { artists.add(new TopMvDataArtist.fromJson(v)); });
		}
		name = json['name'];
		alias = json['alias']?.cast<String>();
		artistName = json['artistName'];
		id = json['id'];
		mark = json['mark'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lastRank'] = this.lastRank;
		data['artistId'] = this.artistId;
		data['cover'] = this.cover;
		data['duration'] = this.duration;
		data['playCount'] = this.playCount;
		data['score'] = this.score;
		data['subed'] = this.subed;
		data['briefDesc'] = this.briefDesc;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		data['name'] = this.name;
		data['alias'] = this.alias;
		data['artistName'] = this.artistName;
		data['id'] = this.id;
		data['mark'] = this.mark;
		data['desc'] = this.desc;
		return data;
	}
}

class TopMvDataArtist {
	String name;
	num id;

	TopMvDataArtist({this.name, this.id});

	TopMvDataArtist.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
