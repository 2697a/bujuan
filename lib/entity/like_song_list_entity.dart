class LikeSongListEntity {
	int code;
	List<int> ids;
	int checkPoint;

	LikeSongListEntity({this.code, this.ids, this.checkPoint});

	LikeSongListEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		ids = json['ids']?.cast<int>();
		checkPoint = json['checkPoint'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['ids'] = this.ids;
		data['checkPoint'] = this.checkPoint;
		return data;
	}
}
