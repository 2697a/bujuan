import 'package:bujuan/entity/top_artists_entity.dart';

topArtistsEntityFromJson(TopArtistsEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['more'] != null) {
		data.more = json['more'];
	}
	if (json['artists'] != null) {
		data.artists = (json['artists'] as List).map((v) => TopArtistsArtists().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> topArtistsEntityToJson(TopArtistsEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['more'] = entity.more;
	data['artists'] =  entity.artists?.map((v) => v.toJson())?.toList();
	return data;
}

topArtistsArtistsFromJson(TopArtistsArtists data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['picId'] != null) {
		data.picId = json['picId'] is String
				? int.tryParse(json['picId'])
				: json['picId'].toInt();
	}
	if (json['img1v1Id'] != null) {
		data.img1v1Id = json['img1v1Id'] is String
				? int.tryParse(json['img1v1Id'])
				: json['img1v1Id'].toInt();
	}
	if (json['briefDesc'] != null) {
		data.briefDesc = json['briefDesc'].toString();
	}
	if (json['picUrl'] != null) {
		data.picUrl = json['picUrl'].toString();
	}
	if (json['img1v1Url'] != null) {
		data.img1v1Url = json['img1v1Url'].toString();
	}
	if (json['albumSize'] != null) {
		data.albumSize = json['albumSize'] is String
				? int.tryParse(json['albumSize'])
				: json['albumSize'].toInt();
	}
	if (json['alias'] != null) {
		data.alias = (json['alias'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['trans'] != null) {
		data.trans = json['trans'].toString();
	}
	if (json['musicSize'] != null) {
		data.musicSize = json['musicSize'] is String
				? int.tryParse(json['musicSize'])
				: json['musicSize'].toInt();
	}
	if (json['topicPerson'] != null) {
		data.topicPerson = json['topicPerson'] is String
				? int.tryParse(json['topicPerson'])
				: json['topicPerson'].toInt();
	}
	if (json['showPrivateMsg'] != null) {
		data.showPrivateMsg = json['showPrivateMsg'];
	}
	if (json['isSubed'] != null) {
		data.isSubed = json['isSubed'];
	}
	if (json['accountId'] != null) {
		data.accountId = json['accountId'] is String
				? int.tryParse(json['accountId'])
				: json['accountId'].toInt();
	}
	if (json['picId_str'] != null) {
		data.picidStr = json['picId_str'].toString();
	}
	if (json['img1v1Id_str'] != null) {
		data.img1v1idStr = json['img1v1Id_str'].toString();
	}
	if (json['transNames'] != null) {
		data.transNames = (json['transNames'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['followed'] != null) {
		data.followed = json['followed'];
	}
	if (json['mvSize'] != null) {
		data.mvSize = json['mvSize'];
	}
	if (json['publishTime'] != null) {
		data.publishTime = json['publishTime'];
	}
	if (json['identifyTag'] != null) {
		data.identifyTag = json['identifyTag'];
	}
	if (json['alg'] != null) {
		data.alg = json['alg'];
	}
	if (json['fansCount'] != null) {
		data.fansCount = json['fansCount'] is String
				? int.tryParse(json['fansCount'])
				: json['fansCount'].toInt();
	}
	return data;
}

Map<String, dynamic> topArtistsArtistsToJson(TopArtistsArtists entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['picId'] = entity.picId;
	data['img1v1Id'] = entity.img1v1Id;
	data['briefDesc'] = entity.briefDesc;
	data['picUrl'] = entity.picUrl;
	data['img1v1Url'] = entity.img1v1Url;
	data['albumSize'] = entity.albumSize;
	data['alias'] = entity.alias;
	data['trans'] = entity.trans;
	data['musicSize'] = entity.musicSize;
	data['topicPerson'] = entity.topicPerson;
	data['showPrivateMsg'] = entity.showPrivateMsg;
	data['isSubed'] = entity.isSubed;
	data['accountId'] = entity.accountId;
	data['picId_str'] = entity.picidStr;
	data['img1v1Id_str'] = entity.img1v1idStr;
	data['transNames'] = entity.transNames;
	data['followed'] = entity.followed;
	data['mvSize'] = entity.mvSize;
	data['publishTime'] = entity.publishTime;
	data['identifyTag'] = entity.identifyTag;
	data['alg'] = entity.alg;
	data['fansCount'] = entity.fansCount;
	return data;
}