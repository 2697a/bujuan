import 'package:json_annotation/json_annotation.dart';
import '../../../netease_music_api.dart';
import '../../../src/api/bean.dart';
import '../../../src/api/user/bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class Music {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  int? size;
  String? extension;

  int? sr;
  int? dfsId;
  int? bitrate;
  int? playTime;
  double? volumeDelta;

  Music();

  factory Music.fromJson(Map<String, dynamic> json) => _$MusicFromJson(json);

  Map<String, dynamic> toJson() => _$MusicToJson(this);
}

@JsonSerializable()
class Music2 {
  int? br;
  int? fid;
  int? size;
  double? vd;

  Music2();

  factory Music2.fromJson(Map<String, dynamic> json) => _$Music2FromJson(json);

  Map<String, dynamic> toJson() => _$Music2ToJson(this);
}

@JsonSerializable()
class Lyrics {
  String? txt;

  Lyrics();

  factory Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);

  Map<String, dynamic> toJson() => _$LyricsToJson(this);
}

@JsonSerializable()
class Lyrics2 {
  String? lyric;

  int? version;

  Lyrics2();

  factory Lyrics2.fromJson(Map<String, dynamic> json) =>
      _$Lyrics2FromJson(json);

  Map<String, dynamic> toJson() => _$Lyrics2ToJson(this);
}

@JsonSerializable()
class Privilege {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  int? fee;

  int? payed;
  int? st;
  int? pl;
  int? dl;
  int? sp;
  int? cp;
  int? subp;
  bool? cs;
  int? maxbr;
  int? fl;
  bool? toast;
  int? flag;
  bool? preSell;

  Privilege();

  factory Privilege.fromJson(Map<String, dynamic> json) =>
      _$PrivilegeFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegeToJson(this);
}

@JsonSerializable()
class Song {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  int? copyrightId;

  String? disc;
  int? no;
  int? fee;
  int? status;

  bool? starred;
  int? starredNum;
  double? popularity;
  int? score;

  int? duration;
  int? playedNum;
  int? dayPlays;
  int? hearTime;

  String? ringtone;
  String? copyFrom;

  String? commentThreadId;

  List<Artists>? artists;

  Album? album;

  // Lyrics String[]
  dynamic lyrics;

  Privilege? privilege;

  int? copyright;

  String? transName;

  int? mark;
  int? rtype;
  int? mvid;

  String? alg;

  String? reason;

  Music? hMusic;
  Music? mMusic;
  Music? lMusic;
  Music? bMusic;

  // {type: 2, typeDesc: 其它版本可播, songId: null}
  // String noCopyrightRcmd;

  Song();

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}

@JsonSerializable()
class Song2 {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  int? pst;
  int? t;

  List<Artists>? ar;

  double? pop;
  int? st;

  String? rt;

  int? fee;
  int? v;
  String? cf;

  Album? al;

  int? dt;

  Music2? h;
  Music2? m;
  Music2? l;
  Music2? a;

  int? mark;
  int? mv;
  int? rtype;
  int? mst;
  int? cp;
  int? publishTime;
  String? reason;

  Privilege? privilege;
  bool? available;

  Song2();

  factory Song2.fromJson(Map<String, dynamic> json) => _$Song2FromJson(json);

  Map<String, dynamic> toJson() => _$Song2ToJson(this);
}

@JsonSerializable()
class SongDetailWrap extends ServerStatusBean {
  List<Song2>? songs;

  List<Privilege>? privileges;

  SongDetailWrap();

  factory SongDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$SongDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SongDetailWrapToJson(this);
}

@JsonSerializable()
class SongUrl {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? url;

  //码率
  int? br;
  int? size;
  int? code;
  int? expi;
  double? gain;
  int? fee;
  int? payed;
  int? flag;

  bool? canExtend;

  String? md5;

  SongUrl();

  factory SongUrl.fromJson(Map<String, dynamic> json) =>
      _$SongUrlFromJson(json);

  Map<String, dynamic> toJson() => _$SongUrlToJson(this);
}

@JsonSerializable()
class SongUrlListWrap extends ServerStatusBean {
  List<SongUrl>? data;

  SongUrlListWrap();

  factory SongUrlListWrap.fromJson(Map<String, dynamic> json) =>
      _$SongUrlListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SongUrlListWrapToJson(this);
}

@JsonSerializable()
class SongLyricWrap extends ServerStatusBean {
  bool? sgc;
  bool? sfy;
  bool? qfy;

  late Lyrics2 lrc;
  late Lyrics2 klyric;
  late Lyrics2 tlyric;

  SongLyricWrap();

  factory SongLyricWrap.fromJson(Map<String, dynamic> json) =>
      _$SongLyricWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SongLyricWrapToJson(this);
}

@JsonSerializable()
class SongListWrap extends ServerStatusBean {
  List<Song>? songs;

  SongListWrap();

  factory SongListWrap.fromJson(Map<String, dynamic> json) =>
      _$SongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SongListWrapToJson(this);
}

@JsonSerializable()
class SongListWrap2 extends ServerStatusBean {
  List<Song>? data;

  SongListWrap2();

  factory SongListWrap2.fromJson(Map<String, dynamic> json) =>
      _$SongListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$SongListWrap2ToJson(this);
}

@JsonSerializable()
class PersonalizedSongItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  String? name;
  String? picUrl;
  String? copywriter;

  bool? canDislike;

  String? alg;

  int? type;

  late Song song;

  PersonalizedSongItem();

  factory PersonalizedSongItem.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedSongItemFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedSongItemToJson(this);
}

@JsonSerializable()
class PersonalizedSongListWrap extends ServerStatusBean {
  List<PersonalizedSongItem>? result;

  int? category;

  PersonalizedSongListWrap();

  factory PersonalizedSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedSongListWrapToJson(this);
}

@JsonSerializable()
class LikeSongListWrap extends ServerStatusBean {
  int? checkPoint;

  late List<int> ids;

  LikeSongListWrap();

  factory LikeSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$LikeSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$LikeSongListWrapToJson(this);
}

@JsonSerializable()
class CloudSongItem {
  late Song2 simpleSong;

  @JsonKey(fromJson: dynamicToString)
  late String songId;
  String? songName;
  String? fileName;

  int? cover;
  int? fileSize;
  late int addTime;
  int? version;
  String? coverId;
  String? lyricId;

  String? album;
  String? artist;

  int? bitrate;

  CloudSongItem();

  factory CloudSongItem.fromJson(Map<String, dynamic> json) =>
      _$CloudSongItemFromJson(json);

  Map<String, dynamic> toJson() => _$CloudSongItemToJson(this);
}

@JsonSerializable()
class CloudSongListWrap extends ServerStatusListBean {
  String? size;
  String? maxSize;
  int? upgradeSign;

  List<CloudSongItem>? data;

  CloudSongListWrap();

  factory CloudSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$CloudSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$CloudSongListWrapToJson(this);
}

@JsonSerializable()
class RecommendSongReason {
  @JsonKey(fromJson: dynamicToString)
  String? songId;

  String? reason;

  RecommendSongReason();

  factory RecommendSongReason.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongReasonFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongReasonToJson(this);
}

@JsonSerializable()
class RecommendSongListWrap {
  List<Song2>? dailySongs;
  List<Song2>? orderSongs;
  List<RecommendSongReason>? recommendReasons;

  RecommendSongListWrap();

  factory RecommendSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongListWrapToJson(this);
}

@JsonSerializable()
class RecommendSongListWrapX extends ServerStatusBean {
  late RecommendSongListWrap data;

  RecommendSongListWrapX();

  factory RecommendSongListWrapX.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongListWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongListWrapXToJson(this);
}

@JsonSerializable()
class RecommendSongListHistoryWrap {
  List<String>? dates;

  String? purchaseUrl;

  String? description;

  String? noHistoryMessage;

  List<Song2>? songs;

  RecommendSongListHistoryWrap();

  factory RecommendSongListHistoryWrap.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongListHistoryWrapFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongListHistoryWrapToJson(this);
}

@JsonSerializable()
class RecommendSongListHistoryWrapX extends ServerStatusBean {
  late RecommendSongListHistoryWrap data;

  RecommendSongListHistoryWrapX();

  factory RecommendSongListHistoryWrapX.fromJson(Map<String, dynamic> json) =>
      _$RecommendSongListHistoryWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendSongListHistoryWrapXToJson(this);
}

@JsonSerializable()
class ArtistSongListWrap extends ServerStatusBean {
  List<Song2>? songs;

  ArtistSongListWrap();

  factory ArtistSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistSongListWrapToJson(this);
}

@JsonSerializable()
class ArtistNewSongListData {
  bool? hasMore;
  int? newSongCount;
  List<Song2>? newWorks;

  ArtistNewSongListData();

  factory ArtistNewSongListData.fromJson(Map<String, dynamic> json) =>
      _$ArtistNewSongListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistNewSongListDataToJson(this);
}

@JsonSerializable()
class ArtistNewSongListWrap extends ServerStatusBean {
  late ArtistNewSongListData data;

  ArtistNewSongListWrap();

  factory ArtistNewSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistNewSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistNewSongListWrapToJson(this);
}

@JsonSerializable()
class ArtistDetailAndSongListWrap extends ServerStatusBean {
  List<Song2>? hotSongs;

  late Artists artist;

  ArtistDetailAndSongListWrap();

  factory ArtistDetailAndSongListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailAndSongListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDetailAndSongListWrapToJson(this);
}

@JsonSerializable()
class Play {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  @JsonKey(fromJson: dynamicToString)
  String? userId;

  //歌单名
  String? name;
  String? description;
  String? coverImgUrl;
  String? picUrl;

  String? tag;
  List<String>? tags;
  String? copywriter;

  int? createTime;
  int? updateTime;

  @JsonKey(fromJson: dynamicToInt)
  int? playCount;
  int? subscribedCount;
  int? shareCount;
  int? commentCount;
  bool? subscribed;

  int? trackCount;
  int? trackNumberUpdateTime;

  String? commentThreadId;

  String? alg;

  // 歌单类型:
  // 0: 自建?
  // 5: 我喜欢的音乐
  int? specialType;

  NeteaseUserInfo? creator;

  List<NeteaseUserInfo>? subscribers;

  List<PlayTrack>? tracks;
  List<PlayTrackId>? trackIds;

  Play();

  @override
  String toString() {
    return 'Play{id: $id, name: $name}';
  }

  factory Play.fromJson(Map<String, dynamic> json) => _$PlayFromJson(json);

  Map<String, dynamic> toJson() => _$PlayToJson(this);
}

@JsonSerializable()
class PlayTrack {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;
  int? pst;
  int? t;

  List<Artists>? ar;
  double? pop;
  int? st;
  String? rt;
  int? fee;
  int? v;
  String? cf;
  late Album al;
  int? dt;
  Music2? h;
  Music2? m;
  Music2? l;
  Music2? a;
  String? cd;
  int? no;
  int? ftype;
  List<dynamic>? rtUrls;
  int? djId;
  int? copyright;
  int? s_id;
  int? mark;
  int? originCoverType;
  int? single;
  int? rtype;
  int? mst;
  int? cp;
  int? mv;
  int? publishTime;

  PlayTrack();

  factory PlayTrack.fromJson(Map<String, dynamic> json) =>
      _$PlayTrackFromJson(json);

  Map<String, dynamic> toJson() => _$PlayTrackToJson(this);
}

@JsonSerializable()
class PlayTrackId {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  int? v;
  int? t;
  int? at;
  int? lr;

  PlayTrackId();

  factory PlayTrackId.fromJson(Map<String, dynamic> json) =>
      _$PlayTrackIdFromJson(json);

  Map<String, dynamic> toJson() => _$PlayTrackIdToJson(this);
}

@JsonSerializable()
class MultiPlayListWrap extends ServerStatusBean {
  List<Play>? playlists;

  MultiPlayListWrap();

  factory MultiPlayListWrap.fromJson(Map<String, dynamic> json) =>
      _$MultiPlayListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$MultiPlayListWrapToJson(this);
}

@JsonSerializable()
class MultiPlayListWrap2 extends ServerStatusBean {
  List<Play>? playlist;

  MultiPlayListWrap2();

  factory MultiPlayListWrap2.fromJson(Map<String, dynamic> json) =>
      _$MultiPlayListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$MultiPlayListWrap2ToJson(this);
}

@JsonSerializable()
class RecommendPlayListWrap extends ServerStatusBean {
  List<Play>? recommend;

  bool? featureFirst;
  bool? haveRcmdSongs;

  RecommendPlayListWrap();

  factory RecommendPlayListWrap.fromJson(Map<String, dynamic> json) =>
      _$RecommendPlayListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendPlayListWrapToJson(this);
}

@JsonSerializable()
class PersonalizedPlayListWrap extends ServerStatusBean {
  List<Play>? result;

  bool? hasTaste;
  int? category;

  PersonalizedPlayListWrap();

  factory PersonalizedPlayListWrap.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedPlayListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedPlayListWrapToJson(this);
}

@JsonSerializable()
class PlaylistCatalogueItem {
  String? name;
  int? resourceCount;
  String? imgUrl;

  int? type;
  int? category;
  int? resourceType;
  bool? hot;
  bool? activity;

  PlaylistCatalogueItem();

  factory PlaylistCatalogueItem.fromJson(Map<String, dynamic> json) =>
      _$PlaylistCatalogueItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistCatalogueItemToJson(this);
}

@JsonSerializable()
class PlaylistCatalogueWrap extends ServerStatusBean {
  PlaylistCatalogueItem? all;
  List<PlaylistCatalogueItem>? sub;

  Map<int, String>? categories;

  PlaylistCatalogueWrap();

  factory PlaylistCatalogueWrap.fromJson(Map<String, dynamic> json) =>
      _$PlaylistCatalogueWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistCatalogueWrapToJson(this);
}

@JsonSerializable()
class PlaylistHotTag {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  int? category;

  int? usedCount;

  int? type;

  int? position;
  int? highQuality;
  int? highQualityPos;
  int? officialPos;

  int? createTime;

  PlaylistHotTag();

  factory PlaylistHotTag.fromJson(Map<String, dynamic> json) =>
      _$PlaylistHotTagFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistHotTagToJson(this);
}

@JsonSerializable()
class PlaylistHotTagsItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  bool? activity;
  bool? hot;

  int? position;
  int? category;
  int? createTime;

  int? type;

  PlaylistHotTag? playlistTag;

  PlaylistHotTagsItem();

  factory PlaylistHotTagsItem.fromJson(Map<String, dynamic> json) =>
      _$PlaylistHotTagsItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistHotTagsItemToJson(this);
}

@JsonSerializable()
class PlaylistHotTagsWrap extends ServerStatusBean {
  List<PlaylistHotTagsItem>? tags;

  PlaylistHotTagsWrap();

  factory PlaylistHotTagsWrap.fromJson(Map<String, dynamic> json) =>
      _$PlaylistHotTagsWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistHotTagsWrapToJson(this);
}

const PLAYLIST_CATEGORY = [
  {'name': '云音乐新歌榜', 'id': '3779629'},
  {'name': '云音乐热歌榜', 'id': '3778678'},
  {'name': '云音乐原创榜', 'id': '2884035'},
  {'name': '云音乐飙升榜', 'id': '19723756'},
  {'name': '云音乐电音榜', 'id': '10520166'},
  {'name': 'UK排行榜周榜', 'id': '180106'},
  {'name': '美国Billboard周榜', 'id': '60198'},
  {'name': 'KTV嗨榜', 'id': '21845217'},
  {'name': 'iTunes榜', 'id': '11641012'},
  {'name': 'Hit FM Top榜', 'id': '120001'},
  {'name': '日本Oricon周榜', 'id': '60131'},
  {'name': '韩国Melon排行榜周榜', 'id': '3733003'},
  {'name': '韩国Mnet排行榜周榜', 'id': '60255'},
  {'name': '韩国Melon原声周榜', 'id': '46772709'},
  {'name': '中国TOP排行榜(港台榜)', 'id': '112504'},
  {'name': '中国TOP排行榜(内地榜)', 'id': '64016'},
  {'name': '香港电台中文歌曲龙虎榜', 'id': '10169002'},
  {'name': '华语金曲榜', 'id': '4395559'},
  {'name': '中国嘻哈榜', 'id': '1899724'},
  {'name': '法国 NRJ EuroHot 30周榜', 'id': '27135204'},
  {'name': '台湾Hito排行榜', 'id': '112463'},
  {'name': 'Beatport全球电子舞曲榜', 'id': '3812895'},
  {'name': '云音乐ACG音乐榜', 'id': '71385702'},
  {'name': '云音乐说唱榜,', 'id': '991319590'},
  {'name': '云音乐古典音乐榜', 'id': '71384707'},
  {'name': '云音乐电音榜', 'id': '1978921795'},
  {'name': '抖音排行榜', 'id': '2250011882'},
  {'name': '新声榜', 'id': '2617766278'},
  {'name': '云音乐韩语榜', 'id': '745956260'},
  {'name': '英国Q杂志中文版周榜', 'id': '2023401535'},
  {'name': '电竞音乐榜', 'id': '2006508653'},
  {'name': '云音乐欧美热歌榜', 'id': '2809513713'},
  {'name': '云音乐欧美新歌榜', 'id': '2809577409'},
  {'name': '说唱TOP榜', 'id': '2847251561'},
  {'name': '云音乐ACG动画榜', 'id': '3001835560'},
  {'name': '云音乐ACG游戏榜', 'id': '3001795926'},
  {'name': '云音乐ACG VOCALOID榜', 'id': '3001890046'}
];

@JsonSerializable()
class SinglePlayListWrap extends ServerStatusBean {
  Play? playlist;

  SinglePlayListWrap();

  factory SinglePlayListWrap.fromJson(Map<String, dynamic> json) =>
      _$SinglePlayListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SinglePlayListWrapToJson(this);
}

@JsonSerializable()
class PlayListDetailDynamicWrap extends ServerStatusBean {
  int? commentCount;
  int? shareCount;
  int? playCount;
  int? bookedCount;

  bool? subscribed;

  String? remarkName;

  bool? followed;

  PlayListDetailDynamicWrap();

  factory PlayListDetailDynamicWrap.fromJson(Map<String, dynamic> json) =>
      _$PlayListDetailDynamicWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PlayListDetailDynamicWrapToJson(this);
}

@JsonSerializable()
class PlaymodeIntelligenceItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  bool? recommended;

  String? alg;

  Song? songInfo;

  PlaymodeIntelligenceItem();

  factory PlaymodeIntelligenceItem.fromJson(Map<String, dynamic> json) =>
      _$PlaymodeIntelligenceItemFromJson(json);

  Map<String, dynamic> toJson() => _$PlaymodeIntelligenceItemToJson(this);
}

@JsonSerializable()
class PlaymodeIntelligenceListWrap extends ServerStatusBean {
  List<PlaymodeIntelligenceItem>? data;

  PlaymodeIntelligenceListWrap();

  factory PlaymodeIntelligenceListWrap.fromJson(Map<String, dynamic> json) =>
      _$PlaymodeIntelligenceListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PlaymodeIntelligenceListWrapToJson(this);
}

@JsonSerializable()
class Artists {
  @JsonKey(fromJson: dynamicToString)
  late String id;
  @JsonKey(fromJson: dynamicToString)
  String? accountId;

  String? name;

  String? picUrl;


  int? img1v1Id;
  String? img1v1Url;
  String? cover;

  int? albumSize;
  int? musicSize;
  int? mvSize;
  int? topicPerson;

  String? trans;
  String? briefDesc;

  bool? followed;

  int? publishTime;

  Artists();

  factory Artists.fromJson(Map<String, dynamic> json) =>
      _$ArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistsToJson(this);
}

@JsonSerializable()
class ArtistsListWrap extends ServerStatusBean {
  List<Artists>? artists;

  ArtistsListWrap();

  factory ArtistsListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistsListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistsListWrapToJson(this);
}

@JsonSerializable()
class ArtistsTopListWrap {
  List<Artists>? artists;

  int? type;
  int? updateTime;

  ArtistsTopListWrap();

  factory ArtistsTopListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistsTopListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistsTopListWrapToJson(this);
}

@JsonSerializable()
class ArtistsTopListWrapX extends ServerStatusBean {
  ArtistsTopListWrap? list;

  ArtistsTopListWrapX();

  factory ArtistsTopListWrapX.fromJson(Map<String, dynamic> json) =>
      _$ArtistsTopListWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistsTopListWrapXToJson(this);
}

@JsonSerializable()
class ArtistIntroduction {
  String? ti;
  String? txt;

  ArtistIntroduction();

  factory ArtistIntroduction.fromJson(Map<String, dynamic> json) =>
      _$ArtistIntroductionFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistIntroductionToJson(this);
}

@JsonSerializable()
class ArtistDescWrap extends ServerStatusBean {
  List<ArtistIntroduction>? introduction;

  String? briefDesc;

  int? count;

  List<TopicItem2>? topicData;

  ArtistDescWrap();

  factory ArtistDescWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistDescWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDescWrapToJson(this);
}

@JsonSerializable()
class ArtistDetailData {
  bool? blacklist;
  bool? showPriMsg;
  int? videoCount;

  Artists? artist;

  ArtistDetailData();

  factory ArtistDetailData.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDetailDataToJson(this);
}

@JsonSerializable()
class ArtistDetailWrap extends ServerStatusBean {
  ArtistDetailData? data;

  ArtistDetailWrap();

  factory ArtistDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDetailWrapToJson(this);
}

@JsonSerializable()
class Album {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  String? type;
  String? subType;

  int? mark;
  int? size;
  int? publishTime;

  String? picUrl;

  String? tags;

  int? copyrightId;
  int? companyId;
  String? company;

  String? description;
  String? briefDesc;

  Artists? artist;
  List<Artists>? artists;

  bool? isSub;
  bool? paid;
  bool? onSale;

  Album();

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class AlbumDetailWrap extends ServerStatusBean {
  List<Song2>? songs;

  Album? album;

  AlbumDetailWrap();

  factory AlbumDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$AlbumDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDetailWrapToJson(this);
}

@JsonSerializable()
class AlbumDetailDynamicWrap extends ServerStatusBean {
  bool? onSale;
  bool? isSub;

  int? subTime;

  int? commentCount;
  int? likedCount;
  int? shareCount;
  int? subCount;

  AlbumDetailDynamicWrap();

  factory AlbumDetailDynamicWrap.fromJson(Map<String, dynamic> json) =>
      _$AlbumDetailDynamicWrapFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDetailDynamicWrapToJson(this);
}

@JsonSerializable()
class AlbumListWrap extends ServerStatusListBean {
  List<Album>? albums;

  AlbumListWrap();

  factory AlbumListWrap.fromJson(Map<String, dynamic> json) =>
      _$AlbumListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumListWrapToJson(this);
}

@JsonSerializable()
class ArtistAlbumListWrap extends ServerStatusListBean {
  int? time;

  List<Album>? hotAlbums;

  late Artists artist;

  ArtistAlbumListWrap();

  factory ArtistAlbumListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistAlbumListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistAlbumListWrapToJson(this);
}

@JsonSerializable()
class MvCreator {
  @JsonKey(fromJson: dynamicToString)
  String? userId;

  String? userName;

  MvCreator();

  factory MvCreator.fromJson(Map<String, dynamic> json) =>
      _$MvCreatorFromJson(json);

  Map<String, dynamic> toJson() => _$MvCreatorToJson(this);
}

@JsonSerializable()
class Mv {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;

  String? cover;

  int? playCount;
  String? briefDesc;
  String? desc;

  String? arTransName;

  String? artisAlias;
  String? artisTransName;
  String? artistName;
  String? artistImgUrl;
  int? artistId;

  int? mvId;
  String? mvName;
  String? mvCoverUrl;

  int? duration;
  @JsonKey(fromJson: dynamicToString)
  String? publishTime;
  String? publishDate;
  int? mark;

  String? alg;

  List<Artists>? artists;

  Mv();

  factory Mv.fromJson(Map<String, dynamic> json) => _$MvFromJson(json);

  Map<String, dynamic> toJson() => _$MvToJson(this);
}

@JsonSerializable()
class Mv2 {
  int? type;

  String? title;
  int? durationms;

  int? playTime;

  String? vid;
  String? coverUrl;

  String? aliaName;
  String? transName;

  List<MvCreator>? creator;

  Mv2();

  factory Mv2.fromJson(Map<String, dynamic> json) => _$Mv2FromJson(json);

  Map<String, dynamic> toJson() => _$Mv2ToJson(this);
}

@JsonSerializable()
class Mv3 {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;
  String? artistName;
  late String imgurl;
  late String imgurl16v9;

  int? status;

  late Artists artist;

  Mv3();

  factory Mv3.fromJson(Map<String, dynamic> json) => _$Mv3FromJson(json);

  Map<String, dynamic> toJson() => _$Mv3ToJson(this);
}

@JsonSerializable()
class MvListWrap extends ServerStatusListBean {
  List<Mv>? mvs;

  MvListWrap();

  factory MvListWrap.fromJson(Map<String, dynamic> json) =>
      _$MvListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$MvListWrapToJson(this);
}

@JsonSerializable()
class MvListWrap2 extends ServerStatusListBean {
  List<Mv>? data;

  int? updateTime;

  MvListWrap2();

  factory MvListWrap2.fromJson(Map<String, dynamic> json) =>
      _$MvListWrap2FromJson(json);

  Map<String, dynamic> toJson() => _$MvListWrap2ToJson(this);
}

@JsonSerializable()
class PersonalizedMvListWrap extends ServerStatusBean {
  List<Mv>? result;

  int? category;

  PersonalizedMvListWrap();

  factory PersonalizedMvListWrap.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedMvListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalizedMvListWrapToJson(this);
}

@JsonSerializable()
class ArtistMvListWrap extends MvListWrap {
  int? time;

  ArtistMvListWrap();

  factory ArtistMvListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistMvListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistMvListWrapToJson(this);
}

@JsonSerializable()
class ArtistNewMvListData {
  bool? hasMore;
  List<Mv>? newWorks;

  ArtistNewMvListData();

  factory ArtistNewMvListData.fromJson(Map<String, dynamic> json) =>
      _$ArtistNewMvListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistNewMvListDataToJson(this);
}

@JsonSerializable()
class ArtistNewMvListWrap extends ServerStatusBean {
  late ArtistNewMvListData data;

  ArtistNewMvListWrap();

  factory ArtistNewMvListWrap.fromJson(Map<String, dynamic> json) =>
      _$ArtistNewMvListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistNewMvListWrapToJson(this);
}

@JsonSerializable()
class MvDetailWrap extends ServerStatusBean {
  String? loadingPic;
  String? bufferPic;
  String? loadingPicFS;
  String? bufferPicFS;

  bool? subed;

  Mv? data;

  MvDetailWrap();

  factory MvDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$MvDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$MvDetailWrapToJson(this);
}

@JsonSerializable()
class MvDetailInfoWrap extends ServerStatusBean {
  int? likedCount;
  int? shareCount;
  int? commentCount;

  bool? liked;

  MvDetailInfoWrap();

  factory MvDetailInfoWrap.fromJson(Map<String, dynamic> json) =>
      _$MvDetailInfoWrapFromJson(json);

  Map<String, dynamic> toJson() => _$MvDetailInfoWrapToJson(this);
}

@JsonSerializable()
class MvUrl {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? url;
  String? md5;
  String? msg;

  int? r;
  int? size;
  int? expi;
  int? fee;
  int? mvFee;
  int? st;

  MvUrl();

  factory MvUrl.fromJson(Map<String, dynamic> json) => _$MvUrlFromJson(json);

  Map<String, dynamic> toJson() => _$MvUrlToJson(this);
}

@JsonSerializable()
class MvUrlWrap extends ServerStatusBean {
  late MvUrl data;

  MvUrlWrap();

  factory MvUrlWrap.fromJson(Map<String, dynamic> json) =>
      _$MvUrlWrapFromJson(json);

  Map<String, dynamic> toJson() => _$MvUrlWrapToJson(this);
}

@JsonSerializable()
class VideoResolution {
  int? resolution;
  int? size;

  VideoResolution();

  factory VideoResolution.fromJson(Map<String, dynamic> json) =>
      _$VideoResolutionFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResolutionToJson(this);
}

@JsonSerializable()
class VideoUrlInfo {
  late String id;
  String? url;
  int? size;
  int? validityTime;
  bool? needPay;
  int? r;

  VideoUrlInfo();

  factory VideoUrlInfo.fromJson(Map<String, dynamic> json) =>
      _$VideoUrlInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoUrlInfoToJson(this);
}

@JsonSerializable()
class VideoBase {
  String? vid;
  String? title;
  String? description;
  String? scm;
  String? alg;
  String? threadId;
  String? coverUrl;
  String? previewUrl;

  int? width;
  int? height;
  int? praisedCount;
  int? playTime;
  int? durationms;
  int? previewDurationms;

  int? commentCount;
  int? shareCount;

  bool? praised;
  bool? subscribed;
  bool? hasRelatedGameAd;

  List<VideoResolution>? resolutions;

  VideoUrlInfo? urlInfo;
  List<VideoMetaItem>? videoGroup;
  List<Song>? relateSong;

  VideoBase();

  factory VideoBase.fromJson(Map<String, dynamic> json) =>
      _$VideoBaseFromJson(json);

  Map<String, dynamic> toJson() => _$VideoBaseToJson(this);
}

@JsonSerializable()
class Video extends VideoBase {
  late NeteaseUserInfo creator;

  Video();

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}

@JsonSerializable()
class Video2 extends VideoBase {
  List<NeteaseUserInfo>? creator;

  Video2();

  factory Video2.fromJson(Map<String, dynamic> json) => _$Video2FromJson(json);

  Map<String, dynamic> toJson() => _$Video2ToJson(this);
}

@JsonSerializable()
class VideoMetaItem {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? name;
  String? url;
  String? relatedVideoType;

  bool? selectTab;

  VideoMetaItem();

  factory VideoMetaItem.fromJson(Map<String, dynamic> json) =>
      _$VideoMetaItemFromJson(json);

  Map<String, dynamic> toJson() => _$VideoMetaItemToJson(this);
}

@JsonSerializable()
class VideoMetaListWrap extends ServerStatusBean {
  List<VideoMetaItem>? data;

  VideoMetaListWrap();

  factory VideoMetaListWrap.fromJson(Map<String, dynamic> json) =>
      _$VideoMetaListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$VideoMetaListWrapToJson(this);
}

@JsonSerializable()
class VideoWrap {
  int? type;
  bool? displayed;
  String? alg;
  String? extAlg;

  late Video data;

  VideoWrap();

  factory VideoWrap.fromJson(Map<String, dynamic> json) =>
      _$VideoWrapFromJson(json);

  Map<String, dynamic> toJson() => _$VideoWrapToJson(this);
}

@JsonSerializable()
class VideoListWrapX extends ServerStatusListBean {
  List<VideoWrap>? datas;

  int? rcmdLimit;

  VideoListWrapX();

  factory VideoListWrapX.fromJson(Map<String, dynamic> json) =>
      _$VideoListWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListWrapXToJson(this);
}

@JsonSerializable()
class VideoListWrap extends ServerStatusBean {
  List<Video2>? data;

  VideoListWrap();

  factory VideoListWrap.fromJson(Map<String, dynamic> json) =>
      _$VideoListWrapFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListWrapToJson(this);
}

@JsonSerializable()
class VideoDetailWrap extends ServerStatusBean {
  late Video data;

  VideoDetailWrap();

  factory VideoDetailWrap.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailWrapFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailWrapToJson(this);
}

@JsonSerializable()
class VideoDetailInfoWrap extends ServerStatusBean {
  int? likedCount;
  int? shareCount;
  int? commentCount;

  bool? liked;

  VideoDetailInfoWrap();

  factory VideoDetailInfoWrap.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailInfoWrapFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDetailInfoWrapToJson(this);
}

@JsonSerializable()
class VideoUrl {
  @JsonKey(fromJson: dynamicToString)
  late String id;

  String? url;
  int? size;
  int? validityTime;

  bool? needPay;

  int? r;

  VideoUrl();

  factory VideoUrl.fromJson(Map<String, dynamic> json) =>
      _$VideoUrlFromJson(json);

  Map<String, dynamic> toJson() => _$VideoUrlToJson(this);
}

@JsonSerializable()
class VideoUrlWrap extends ServerStatusBean {
  List<VideoUrl>? urls;

  VideoUrlWrap();

  factory VideoUrlWrap.fromJson(Map<String, dynamic> json) =>
      _$VideoUrlWrapFromJson(json);

  Map<String, dynamic> toJson() => _$VideoUrlWrapToJson(this);
}
