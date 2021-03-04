class SingerEntity {
	int code;
	List<SingerArtist> artists;
	bool more;

	SingerEntity({this.code, this.artists, this.more});

	SingerEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['artists'] != null) {
			artists = new List<SingerArtist>();(json['artists'] as List).forEach((v) { artists.add(new SingerArtist.fromJson(v)); });
		}
		more = json['more'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		data['more'] = this.more;
		return data;
	}
}

class SingerArtist {
	String img1v1Url;
	String picidStr;
	int musicSize;
	String img1v1idStr;
	int img1v1Id;
	bool followed;
	int albumSize;
	String picUrl;
	int accountId;
	int topicPerson;
	String briefDesc;
	List<String> transNames;
	String name;
	List<Null> alias;
	int id;
	int picId;
	String trans;

	SingerArtist({this.img1v1Url, this.picidStr, this.musicSize, this.img1v1idStr, this.img1v1Id, this.followed, this.albumSize, this.picUrl, this.accountId, this.topicPerson, this.briefDesc, this.transNames, this.name, this.alias, this.id, this.picId, this.trans});

	SingerArtist.fromJson(Map<String, dynamic> json) {
		img1v1Url = json['img1v1Url'];
		picidStr = json['picId_str'];
		musicSize = json['musicSize'];
		img1v1idStr = json['img1v1Id_str'];
		img1v1Id = json['img1v1Id'];
		followed = json['followed'];
		albumSize = json['albumSize'];
		picUrl = json['picUrl'];
		accountId = json['accountId'];
		topicPerson = json['topicPerson'];
		briefDesc = json['briefDesc'];
		transNames = json['transNames']?.cast<String>();
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		id = json['id'];
		picId = json['picId'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img1v1Url'] = this.img1v1Url;
		data['picId_str'] = this.picidStr;
		data['musicSize'] = this.musicSize;
		data['img1v1Id_str'] = this.img1v1idStr;
		data['img1v1Id'] = this.img1v1Id;
		data['followed'] = this.followed;
		data['albumSize'] = this.albumSize;
		data['picUrl'] = this.picUrl;
		data['accountId'] = this.accountId;
		data['topicPerson'] = this.topicPerson;
		data['briefDesc'] = this.briefDesc;
		data['transNames'] = this.transNames;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['trans'] = this.trans;
		return data;
	}
}
