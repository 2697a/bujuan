class SearchSongEntity {
	SearchSongResult result;
	int code;

	SearchSongEntity({this.result, this.code});

	SearchSongEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new SearchSongResult.fromJson(json['result']) : null;
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

class SearchSongResult {
	List<SearchSongResultSong> songs;
	int songCount;

	SearchSongResult({this.songs, this.songCount});

	SearchSongResult.fromJson(Map<String, dynamic> json) {
		if (json['songs'] != null) {
			songs = new List<SearchSongResultSong>();(json['songs'] as List).forEach((v) { songs.add(new SearchSongResultSong.fromJson(v)); });
		}
		songCount = json['songCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.songs != null) {
      data['songs'] =  this.songs.map((v) => v.toJson()).toList();
    }
		data['songCount'] = this.songCount;
		return data;
	}
}

class SearchSongResultSong {
	SearchSongResultSongsAlbum album;
	int fee;
	dynamic rUrl;
	int duration;
	int rtype;
	int ftype;
	List<SearchSongResultSongsArtist> artists;
	int copyrightId;
	int mvid;
	String name;
	List<Null> alias;
	int id;
	int mark;
	int status;

	SearchSongResultSong({this.album, this.fee, this.rUrl, this.duration, this.rtype, this.ftype, this.artists, this.copyrightId, this.mvid, this.name, this.alias, this.id, this.mark, this.status});

	SearchSongResultSong.fromJson(Map<String, dynamic> json) {
		album = json['album'] != null ? new SearchSongResultSongsAlbum.fromJson(json['album']) : null;
		fee = json['fee'];
		rUrl = json['rUrl'];
		duration = json['duration'];
		rtype = json['rtype'];
		ftype = json['ftype'];
		if (json['artists'] != null) {
			artists = new List<SearchSongResultSongsArtist>();(json['artists'] as List).forEach((v) { artists.add(new SearchSongResultSongsArtist.fromJson(v)); });
		}
		copyrightId = json['copyrightId'];
		mvid = json['mvid'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		id = json['id'];
		mark = json['mark'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.album != null) {
      data['album'] = this.album.toJson();
    }
		data['fee'] = this.fee;
		data['rUrl'] = this.rUrl;
		data['duration'] = this.duration;
		data['rtype'] = this.rtype;
		data['ftype'] = this.ftype;
		if (this.artists != null) {
      data['artists'] =  this.artists.map((v) => v.toJson()).toList();
    }
		data['copyrightId'] = this.copyrightId;
		data['mvid'] = this.mvid;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['id'] = this.id;
		data['mark'] = this.mark;
		data['status'] = this.status;
		return data;
	}
}

class SearchSongResultSongsAlbum {
	int publishTime;
	int size;
	SearchSongResultSongsAlbumArtist artist;
	int copyrightId;
	String name;
	int id;
	int picId;
	int mark;
	int status;

	SearchSongResultSongsAlbum({this.publishTime, this.size, this.artist, this.copyrightId, this.name, this.id, this.picId, this.mark, this.status});

	SearchSongResultSongsAlbum.fromJson(Map<String, dynamic> json) {
		publishTime = json['publishTime'];
		size = json['size'];
		artist = json['artist'] != null ? new SearchSongResultSongsAlbumArtist.fromJson(json['artist']) : null;
		copyrightId = json['copyrightId'];
		name = json['name'];
		id = json['id'];
		picId = json['picId'];
		mark = json['mark'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['publishTime'] = this.publishTime;
		data['size'] = this.size;
		if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
		data['copyrightId'] = this.copyrightId;
		data['name'] = this.name;
		data['id'] = this.id;
		data['picId'] = this.picId;
		data['mark'] = this.mark;
		data['status'] = this.status;
		return data;
	}
}

class SearchSongResultSongsAlbumArtist {
	dynamic picUrl;
	String img1v1Url;
	int img1v1;
	String name;
	List<Null> alias;
	int id;
	int albumSize;
	int picId;
	dynamic trans;

	SearchSongResultSongsAlbumArtist({this.picUrl, this.img1v1Url, this.img1v1, this.name, this.alias, this.id, this.albumSize, this.picId, this.trans});

	SearchSongResultSongsAlbumArtist.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		img1v1 = json['img1v1'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		id = json['id'];
		albumSize = json['albumSize'];
		picId = json['picId'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['img1v1'] = this.img1v1;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['id'] = this.id;
		data['albumSize'] = this.albumSize;
		data['picId'] = this.picId;
		data['trans'] = this.trans;
		return data;
	}
}

class SearchSongResultSongsArtist {
	dynamic picUrl;
	String img1v1Url;
	int img1v1;
	String name;
	List<Null> alias;
	int id;
	int albumSize;
	int picId;
	dynamic trans;

	SearchSongResultSongsArtist({this.picUrl, this.img1v1Url, this.img1v1, this.name, this.alias, this.id, this.albumSize, this.picId, this.trans});

	SearchSongResultSongsArtist.fromJson(Map<String, dynamic> json) {
		picUrl = json['picUrl'];
		img1v1Url = json['img1v1Url'];
		img1v1 = json['img1v1'];
		name = json['name'];
		if (json['alias'] != null) {
			alias = new List<Null>();
		}
		id = json['id'];
		albumSize = json['albumSize'];
		picId = json['picId'];
		trans = json['trans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['picUrl'] = this.picUrl;
		data['img1v1Url'] = this.img1v1Url;
		data['img1v1'] = this.img1v1;
		data['name'] = this.name;
		if (this.alias != null) {
      data['alias'] =  [];
    }
		data['id'] = this.id;
		data['albumSize'] = this.albumSize;
		data['picId'] = this.picId;
		data['trans'] = this.trans;
		return data;
	}
}
