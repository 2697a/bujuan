class SearchHotEntity {
	int code;
	List<SearchHotData> data;
	String message;

	SearchHotEntity({this.code, this.data, this.message});

	SearchHotEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<SearchHotData>();(json['data'] as List).forEach((v) { data.add(new SearchHotData.fromJson(v)); });
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['message'] = this.message;
		return data;
	}
}

class SearchHotData {
	int score;
	int iconType;
	String searchWord;
	int source;
	String iconUrl;
	String alg;
	String content;
	String url;

	SearchHotData({this.score, this.iconType, this.searchWord, this.source, this.iconUrl, this.alg, this.content, this.url});

	SearchHotData.fromJson(Map<String, dynamic> json) {
		score = json['score'];
		iconType = json['iconType'];
		searchWord = json['searchWord'];
		source = json['source'];
		iconUrl = json['iconUrl'];
		alg = json['alg'];
		content = json['content'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['score'] = this.score;
		data['iconType'] = this.iconType;
		data['searchWord'] = this.searchWord;
		data['source'] = this.source;
		data['iconUrl'] = this.iconUrl;
		data['alg'] = this.alg;
		data['content'] = this.content;
		data['url'] = this.url;
		return data;
	}
}
