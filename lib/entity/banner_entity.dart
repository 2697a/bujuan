class BannerEntity {
	int code;
	List<BannerBanner> banners;

	BannerEntity({this.code, this.banners});

	BannerEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['banners'] != null) {
			banners = new List<BannerBanner>();(json['banners'] as List).forEach((v) { banners.add(new BannerBanner.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.banners != null) {
      data['banners'] =  this.banners.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class BannerBanner {
	dynamic adLocation;
	dynamic monitorImpress;
	dynamic extMonitor;
	dynamic program;
	dynamic video;
	dynamic adDispatchJson;
	dynamic monitorType;
	dynamic adid;
	String titleColor;
	String imageUrl;
	bool exclusive;
	dynamic event;
	String scm;
	dynamic song;
	int targetId;
	dynamic adSource;
	int targetType;
	String typeTitle;
	dynamic url;
	String encodeId;
	dynamic extMonitorInfo;
	dynamic monitorClick;
	dynamic monitorImpressList;
	dynamic monitorBlackList;
	dynamic monitorClickList;

	BannerBanner({this.adLocation, this.monitorImpress, this.extMonitor, this.program, this.video, this.adDispatchJson, this.monitorType, this.adid, this.titleColor, this.imageUrl, this.exclusive, this.event, this.scm, this.song, this.targetId, this.adSource, this.targetType, this.typeTitle, this.url, this.encodeId, this.extMonitorInfo, this.monitorClick, this.monitorImpressList, this.monitorBlackList, this.monitorClickList});

	BannerBanner.fromJson(Map<String, dynamic> json) {
		adLocation = json['adLocation'];
		monitorImpress = json['monitorImpress'];
		extMonitor = json['extMonitor'];
		program = json['program'];
		video = json['video'];
		adDispatchJson = json['adDispatchJson'];
		monitorType = json['monitorType'];
		adid = json['adid'];
		titleColor = json['titleColor'];
		imageUrl = json['imageUrl'];
		exclusive = json['exclusive'];
		event = json['event'];
		scm = json['scm'];
		song = json['song'];
		targetId = json['targetId'];
		adSource = json['adSource'];
		targetType = json['targetType'];
		typeTitle = json['typeTitle'];
		url = json['url'];
		encodeId = json['encodeId'];
		extMonitorInfo = json['extMonitorInfo'];
		monitorClick = json['monitorClick'];
		monitorImpressList = json['monitorImpressList'];
		monitorBlackList = json['monitorBlackList'];
		monitorClickList = json['monitorClickList'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['adLocation'] = this.adLocation;
		data['monitorImpress'] = this.monitorImpress;
		data['extMonitor'] = this.extMonitor;
		data['program'] = this.program;
		data['video'] = this.video;
		data['adDispatchJson'] = this.adDispatchJson;
		data['monitorType'] = this.monitorType;
		data['adid'] = this.adid;
		data['titleColor'] = this.titleColor;
		data['imageUrl'] = this.imageUrl;
		data['exclusive'] = this.exclusive;
		data['event'] = this.event;
		data['scm'] = this.scm;
		data['song'] = this.song;
		data['targetId'] = this.targetId;
		data['adSource'] = this.adSource;
		data['targetType'] = this.targetType;
		data['typeTitle'] = this.typeTitle;
		data['url'] = this.url;
		data['encodeId'] = this.encodeId;
		data['extMonitorInfo'] = this.extMonitorInfo;
		data['monitorClick'] = this.monitorClick;
		data['monitorImpressList'] = this.monitorImpressList;
		data['monitorBlackList'] = this.monitorBlackList;
		data['monitorClickList'] = this.monitorClickList;
		return data;
	}
}
