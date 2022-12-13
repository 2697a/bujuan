import 'package:json_annotation/json_annotation.dart';
import '../../../src/api/bean.dart';
import '../../../src/api/dj/bean.dart';
import '../../../src/api/event/bean.dart';
import '../../../src/api/play/bean.dart';
import '../../../src/api/user/bean.dart';

part 'bean.g.dart';

@JsonSerializable()
class SearchSongWrap {
  late List<Song> songs;

  SearchSongWrap();

  factory SearchSongWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchSongWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSongWrapToJson(this);
}

@JsonSerializable()
class SearchSongWrapX extends ServerStatusBean {
  late SearchSongWrap result;

  SearchSongWrapX();

  factory SearchSongWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchSongWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSongWrapXToJson(this);
}

@JsonSerializable()
class SearchAlbumsWrapX extends ServerStatusBean {
  late AlbumListWrap result;

  SearchAlbumsWrapX();

  factory SearchAlbumsWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchAlbumsWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAlbumsWrapXToJson(this);
}

@JsonSerializable()
class SearchArtistsWrap {
  late List<Artists> artists;

  SearchArtistsWrap();

  factory SearchArtistsWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchArtistsWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchArtistsWrapToJson(this);
}

@JsonSerializable()
class SearchArtistsWrapX extends ServerStatusBean {
  late SearchArtistsWrap result;

  SearchArtistsWrapX();

  factory SearchArtistsWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchArtistsWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchArtistsWrapXToJson(this);
}

@JsonSerializable()
class SearchPlaylistWrap {
  late List<Play> playlists;

  SearchPlaylistWrap();

  factory SearchPlaylistWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchPlaylistWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPlaylistWrapToJson(this);
}

@JsonSerializable()
class SearchPlaylistWrapX extends ServerStatusBean {
  late SearchPlaylistWrap result;

  SearchPlaylistWrapX();

  factory SearchPlaylistWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchPlaylistWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPlaylistWrapXToJson(this);
}

@JsonSerializable()
class SearchUserWrapX extends ServerStatusBean {
  late UserListWrap result;

  SearchUserWrapX();

  factory SearchUserWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchUserWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserWrapXToJson(this);
}

@JsonSerializable()
class SearchMvWrapX extends ServerStatusBean {
  late MvListWrap result;

  SearchMvWrapX();

  factory SearchMvWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchMvWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMvWrapXToJson(this);
}

@JsonSerializable()
class SearchLyricsWrap {
  late List<Song> songs;

  SearchLyricsWrap();

  factory SearchLyricsWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchLyricsWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLyricsWrapToJson(this);
}

@JsonSerializable()
class SearchLyricsWrapX extends ServerStatusBean {
  late SearchLyricsWrap result;

  SearchLyricsWrapX();

  factory SearchLyricsWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchLyricsWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLyricsWrapXToJson(this);
}

@JsonSerializable()
class SearchDjradiorap {
  late List<DjRadio> djRadios;

  SearchDjradiorap();

  factory SearchDjradiorap.fromJson(Map<String, dynamic> json) =>
      _$SearchDjradiorapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDjradiorapToJson(this);
}

@JsonSerializable()
class SearchDjradioWrapX extends ServerStatusBean {
  late SearchDjradiorap result;

  SearchDjradioWrapX();

  factory SearchDjradioWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchDjradioWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDjradioWrapXToJson(this);
}

@JsonSerializable()
class SearchVideoWrap {
  late List<Mv2> videos;

  SearchVideoWrap();

  factory SearchVideoWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchVideoWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchVideoWrapToJson(this);
}

@JsonSerializable()
class SearchVideoWrapX extends ServerStatusBean {
  late SearchVideoWrap result;

  SearchVideoWrapX();

  factory SearchVideoWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchVideoWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchVideoWrapXToJson(this);
}

@JsonSerializable()
class SearchComplexSong {
  late List<Song2> songs;

  String? moreText;

  String? highText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexSong();

  factory SearchComplexSong.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexSongFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexSongToJson(this);
}

@JsonSerializable()
class SearchComplexMlog {
  late List<MyLog> mlogs;

  String? moreText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexMlog();

  factory SearchComplexMlog.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexMlogFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexMlogToJson(this);
}

@JsonSerializable()
class SearchComplexPlaylist {
  late List<Play> playLists;

  String? moreText;

  String? highText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexPlaylist();

  factory SearchComplexPlaylist.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexPlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexPlaylistToJson(this);
}

@JsonSerializable()
class SearchComplexArtist {
  late List<Artists> artists;

  String? moreText;

  String? highText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexArtist();

  factory SearchComplexArtist.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexArtistFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexArtistToJson(this);
}

@JsonSerializable()
class SearchComplexAlbum {
  late List<Album> albums;

  String? moreText;

  String? highText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexAlbum();

  factory SearchComplexAlbum.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexAlbumToJson(this);
}

@JsonSerializable()
class SearchComplexVideo {
  late List<Video2> videos;

  String? moreText;

  String? highText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexVideo();

  factory SearchComplexVideo.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexVideoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexVideoToJson(this);
}

@JsonSerializable()
class SearchComplexSimQueryItem {
  String? keyword;
  String? alg;

  SearchComplexSimQueryItem();

  factory SearchComplexSimQueryItem.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexSimQueryItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexSimQueryItemToJson(this);
}

@JsonSerializable()
class SearchComplexSimQuery {
  late List<SearchComplexSimQueryItem> sim_querys;
  bool? more;

  SearchComplexSimQuery();

  factory SearchComplexSimQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexSimQueryFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexSimQueryToJson(this);
}

@JsonSerializable()
class SearchComplexTalk {
  List<NeteaseUserInfo>? users;

  String? moreText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexTalk();

  factory SearchComplexTalk.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexTalkFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexTalkToJson(this);
}

@JsonSerializable()
class SearchComplexUser {
  late List<NeteaseUserInfo> users;

  String? moreText;

  bool? more;

  late List<int> resourceIds;

  SearchComplexUser();

  factory SearchComplexUser.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexUserFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexUserToJson(this);
}

@JsonSerializable()
class SearchComplexWrap {
  SearchComplexSong? song;
  SearchComplexMlog? mlog;
  SearchComplexPlaylist? playList;
  SearchComplexArtist? artist;
  SearchComplexAlbum? album;
  SearchComplexVideo? video;
  SearchComplexSimQuery? sim_query;
  SearchComplexTalk? talk;
  SearchComplexUser? user;

  List<String>? order;

  SearchComplexWrap();

  factory SearchComplexWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexWrapToJson(this);
}

@JsonSerializable()
class SearchComplexWrapX extends ServerStatusBean {
  late SearchComplexWrap result;

  SearchComplexWrapX();

  factory SearchComplexWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchComplexWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchComplexWrapXToJson(this);
}

@JsonSerializable()
class SearchKey {
  String? showKeyword;
  int? action;
  String? realkeyword;
  int? searchType;
  String? alg;
  int? gap;

  SearchKey();

  factory SearchKey.fromJson(Map<String, dynamic> json) =>
      _$SearchKeyFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeyToJson(this);
}

@JsonSerializable()
class SearchKeyWrap extends ServerStatusBean {
  late SearchKey data;

  SearchKeyWrap();

  factory SearchKeyWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchKeyWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeyWrapToJson(this);
}

@JsonSerializable()
class SearchHotKey {
  String? first;
  int? second;
  late int iconType;

  SearchHotKey();

  factory SearchHotKey.fromJson(Map<String, dynamic> json) =>
      _$SearchHotKeyFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHotKeyToJson(this);
}

@JsonSerializable()
class SearchHotKeyWrap {
  late List<SearchHotKey> hots;

  SearchHotKeyWrap();

  factory SearchHotKeyWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchHotKeyWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHotKeyWrapToJson(this);
}

@JsonSerializable()
class SearchKeyWrapX extends ServerStatusBean {
  late SearchHotKeyWrap result;

  SearchKeyWrapX();

  factory SearchKeyWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchKeyWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeyWrapXToJson(this);
}

@JsonSerializable()
class SearchKeyDetailedItem {
  String? searchWord;
  String? content;

  String? iconUrl;
  String? url;
  String? alg;

  int? score;
  int? source;
  late int iconType;

  SearchKeyDetailedItem();

  factory SearchKeyDetailedItem.fromJson(Map<String, dynamic> json) =>
      _$SearchKeyDetailedItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeyDetailedItemToJson(this);
}

@JsonSerializable()
class SearchKeyDetailedWrap extends ServerStatusBean {
  late List<SearchKeyDetailedItem> data;

  SearchKeyDetailedWrap();

  factory SearchKeyDetailedWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchKeyDetailedWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchKeyDetailedWrapToJson(this);
}

@JsonSerializable()
class SearchSuggestItem {
  String? keyword;
  int? type;
  String? alg;
  String? lastKeyword;

  SearchSuggestItem();

  factory SearchSuggestItem.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSuggestItemToJson(this);
}

@JsonSerializable()
class SearchSuggestWrap {
  late List<SearchSuggestItem> allMatch;

  SearchSuggestWrap();

  factory SearchSuggestWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSuggestWrapToJson(this);
}

@JsonSerializable()
class SearchSuggestWrapX extends ServerStatusBean {
  late SearchSuggestWrap result;

  SearchSuggestWrapX();

  factory SearchSuggestWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSuggestWrapXToJson(this);
}

@JsonSerializable()
class SearchMultiMatchWrap {
  List<Song>? song;
  List<Play>? playList;
  List<Artists>? artist;
  List<Album>? album;

  late List<String> orders;

  SearchMultiMatchWrap();

  factory SearchMultiMatchWrap.fromJson(Map<String, dynamic> json) =>
      _$SearchMultiMatchWrapFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMultiMatchWrapToJson(this);
}

@JsonSerializable()
class SearchMultiMatchWrapX extends ServerStatusBean {
  late SearchMultiMatchWrap result;

  SearchMultiMatchWrapX();

  factory SearchMultiMatchWrapX.fromJson(Map<String, dynamic> json) =>
      _$SearchMultiMatchWrapXFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMultiMatchWrapXToJson(this);
}
