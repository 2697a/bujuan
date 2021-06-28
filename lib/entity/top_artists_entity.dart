import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/generated/json/base/json_field.dart';

class TopArtistsEntity with JsonConvert<TopArtistsEntity> {
	int code;
	bool more;
	List<TopArtistsArtists> artists;
}

class TopArtistsArtists with JsonConvert<TopArtistsArtists> {
	String name;
	int id;
	int picId;
	int img1v1Id;
	String briefDesc;
	String picUrl;
	String img1v1Url;
	int albumSize;
	List<String> alias;
	String trans;
	int musicSize;
	int topicPerson;
	dynamic showPrivateMsg;
	dynamic isSubed;
	int accountId;
	@JSONField(name: "picId_str")
	String picidStr;
	@JSONField(name: "img1v1Id_str")
	String img1v1idStr;
	List<String> transNames;
	bool followed;
	dynamic mvSize;
	dynamic publishTime;
	dynamic identifyTag;
	dynamic alg;
	int fansCount;
}
