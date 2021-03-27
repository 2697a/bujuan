import 'dart:convert';
import 'dart:io';

import 'package:bujuan/api/netease_cloud_music.dart';
import 'package:bujuan/entity/ablum_newest.dart';
import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/main.dart';
import 'package:bujuan/entity/banner_entity.dart';
import 'package:bujuan/entity/cloud_entity.dart';
import 'package:bujuan/entity/login_entity.dart';
import 'package:bujuan/entity/lyric_entity.dart';
import 'package:bujuan/entity/music_talk.dart';
import 'package:bujuan/entity/new_song_entity.dart';
import 'package:bujuan/entity/personal_entity.dart';
import 'package:bujuan/entity/play_history_entity.dart';
import 'package:bujuan/entity/search_song_entity.dart';
import 'package:bujuan/entity/sheet_by_classify.dart';
import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/entity/today_song_entity.dart';
import 'package:bujuan/entity/top_entity.dart';
import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class NetUtils {
  static final NetUtils _netUtils = NetUtils._internal(); //1
  factory NetUtils() {
    return _netUtils;
  }

  NetUtils._internal();

  ///统一请求'msg' -> 'data inconstant when unbooked playlist, pid:2427280345 userId:302618605'
  Future<Map> _doHandler(String url, {cacheName, Map param = const {}}) async {
    var answer = await cloudMusicApi(url, parameter: param, cookie: await _getCookie());
    var map;
    if (answer.status == 200) {
      if (answer.cookie != null && answer.cookie.length > 0) {
        await _saveCookie(answer.cookie);
      }
      map = answer.body;
      if (!GetUtils.isNullOrBlank(cacheName) && map['code'] == 200) _saveCache(cacheName, map);
      // log('$url======${jsonEncode(map)}');
    }
    return map;
  }

  ///简陋的本地文件缓存
  _saveCache(String cacheName, dynamic data) {
    debugPrint('简陋的本地文件缓存');
    var directory = Get.find<FileService>().directory.value;
    File file = File('${directory.path}$cacheName');
    if (file.existsSync()) file.deleteSync();
    file.createSync();
    file.writeAsStringSync(jsonEncode(data));
  }

  ///保存cookie
  Future<void> _saveCookie(List<Cookie> cookies) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cookie = new PersistCookieJar(dir: tempPath, ignoreExpires: true);
    cookie.saveFromResponse(Uri.parse('https://music.163.com/weapi/'), cookies);
  }

  ///获取cookie
  Future<List<Cookie>> _getCookie() async {
    var directory = Get.find<FileService>().directory.value;
    String tempPath = directory.path;
    CookieJar cookie = new PersistCookieJar(dir: tempPath, ignoreExpires: true);
    return cookie.loadForRequest(Uri.parse('https://music.163.com/weapi/'));
  }

  ///手机号登录
  Future<LoginEntity> loginByPhone(String phone, String password) async {
    var login;
    var map = await _doHandler('/login/cellphone', param: {'phone': phone, 'password': password});
    if (map != null) {
      login = LoginEntity.fromJson(map);
    }
    return login;
  }

  ///邮箱登录
  Future<LoginEntity> loginByEmail(String email, String password) async {
    var login;
    var map = await _doHandler('/login', param: {'email': email, 'password': password});
    if (map != null) login = LoginEntity.fromJson(map);
    return login;
  }

  ///刷新登录，token换token(总把新桃换旧符)
  Future<Map> refreshLogin() async {
    var map = await _doHandler('/login/refresh');
    return map;
  }

  ///获取歌单详情
  Future<SheetDetailsEntity> getPlayListDetails(id, {count, forcedRefresh = false}) async {
    SheetDetailsEntity sheetDetails;
    if (await BuJuanUtil.checkFileExists('$id') && !forcedRefresh) {
      debugPrint("$id歌单已缓存，直接拿哈");
      var data = await BuJuanUtil.readStringFile('$id');
      if (data != null) sheetDetails = SheetDetailsEntity.fromJson(data);
    } else {
      debugPrint("$id歌单未缓存");
      var map = await _doHandler('/playlist/detail', param: {'id': id});
      if (map != null) sheetDetails = SheetDetailsEntity.fromJson(map);
      var trackIds2 = sheetDetails.playlist.trackIds;
      // if (count != null) {
      //   trackIds2 = trackIds2.sublist(0, 3);
      // } else {
      if (trackIds2.length > 1000) trackIds2 = trackIds2.sublist(0, 1000);
      // }
      List<int> ids = [];
      await Future.forEach(trackIds2, (id) => ids.add(id.id));
      var list = await getSongDetails(ids.join(','));
      sheetDetails.playlist.tracks = list;
      _saveCache('$id', sheetDetails.toJson());
    }

    return sheetDetails;
  }

  ///获取歌曲详情
  Future<List<SheetDetailsPlaylistTrack>> getSongDetails(ids) async {
    var songDetails;
    var map = await _doHandler('/song/detail', param: {'ids': ids});
    if (map != null) {
      var body = map['songs'];
      List<SheetDetailsPlaylistTrack> songs = [];
      await Future.forEach(body, (element) {
        var sheetDetailsPlaylistTrack = SheetDetailsPlaylistTrack.fromJson(element);
        songs.add(sheetDetailsPlaylistTrack);
      });
      songDetails = songs;
    }
    return songDetails;
  }

  ///每日推荐
  Future<List<SheetDetailsPlaylistTrack>> getTodaySongs() async {
    var todaySongs;
    var map = await _doHandler('/recommend/songs');
    var todaySongEntity = TodaySongEntity.fromJson(map);
    if (map != null) {
      List<int> ids = [];
      await Future.forEach(todaySongEntity.recommend, (id) => ids.add(id.id));
      todaySongs = await getSongDetails(ids.join(','));
    }
    return todaySongs;
  }

  ///获取个人信息
  Future<UserProfileEntity> getUserProfile(userId) async {
    var profile;
    var map = await _doHandler('/user/detail', param: {'uid': userId}, cacheName: CACHE_USER_PROFILE);
    if (map != null) profile = UserProfileEntity.fromJson(Map<String, dynamic>.from(map));
    return profile;
  }

  ///获取用户歌单
  Future<UserOrderEntity> getUserPlayList(userId,{forcedRefresh = false}) async {
    var playlist;
    if (await BuJuanUtil.checkFileExists(CACHE_USER_PLAY_LIST)&&!forcedRefresh) {
      debugPrint("用户歌单已缓存，直接拿哈");
      var data = await BuJuanUtil.readStringFile(CACHE_USER_PLAY_LIST);
      if (data != null) playlist = UserOrderEntity.fromJson(data);
    } else {
      debugPrint("用户歌单未缓存");
      var map = await _doHandler('/user/playlist', param: {'uid': userId}, cacheName: CACHE_USER_PLAY_LIST);
      if (map != null) playlist = UserOrderEntity.fromJson(map);
    }
    return playlist;
  }

  ///推荐歌单
  Future<PersonalEntity> getRecommendResource({forcedRefresh = false}) async {
    var playlist;
    if (await BuJuanUtil.checkFileExists(CACHE_TODAY_SHEET)&&!forcedRefresh) {
      debugPrint("推荐歌单已缓存，直接拿哈");
      var data = await BuJuanUtil.readStringFile(CACHE_TODAY_SHEET);
      if (data != null) playlist = PersonalEntity.fromJson(data);
    } else {
      debugPrint("推荐歌单未缓存");
      var map = await _doHandler('/personalized', cacheName: CACHE_TODAY_SHEET);
      if (map != null) playlist = PersonalEntity.fromJson(map);
    }
    return playlist;
  }

  ///banner
  Future<BannerEntity> getBanner() async {
    var banner;
    var map = await _doHandler('/banner');
    if (map != null) banner = BannerEntity.fromJson(map);
    return banner;
  }

  ///新歌推荐
  Future<NewSongEntity> getNewSongs({forcedRefresh = false}) async {
    var newSongs;
    if (await BuJuanUtil.checkFileExists(CACHE_NEW_SONG)&&!forcedRefresh) {
      debugPrint("新歌推荐已缓存，直接拿哈");
      var data = await BuJuanUtil.readStringFile(CACHE_NEW_SONG);
      if (data != null) newSongs = NewSongEntity.fromJson(data);
    } else {
      debugPrint("新歌推荐未缓存");
      var map = await _doHandler('/personalized/newsong', cacheName: CACHE_NEW_SONG);
      if (map != null) newSongs = NewSongEntity.fromJson(map);
    }
    return newSongs;
  }

  ///新歌推荐
  Future<AlbumNewest> getNewAlbum() async {
    var newAlbum;
    var map = await _doHandler('/album/newest');
    if (map != null) newAlbum = AlbumNewest.fromJson(map);
    return newAlbum;
  }

  ///获取歌曲播放地址
  Future<String> getSongUrl(songId) async {
    var songUrl = '';
    var map = await _doHandler('/song/url', param: {'id': songId, 'br': '128000'});
    if (map != null) songUrl = map['data'][0]['url'];
    return songUrl;
  }

  ///根据id获取排行榜/top/list
  Future<TopEntity> getTopData(id) async {
    var top;
    var map = await _doHandler('/top/list', param: {'idx': id});
    if (map != null) top = TopEntity.fromJson(map);
    return top;
  }

  ///根据ID删除创建歌单
  Future<bool> delPlayList(id) async {
    var del = false;
    var map = await _doHandler('/playlist/del', param: {'id': id});
    del = map != null;
    return del;
  }

  ///1收藏0取消收藏
  Future<bool> subPlaylist(bool isSub, id) async {
    bool sub = false;
    var map = await _doHandler('/playlist/subscribe', param: {'t': isSub ? 1 : 0, 'id': id});
    sub = map != null;
    return sub;
  }

  ///創建歌單
  Future<bool> createPlayList(name) async {
    bool create = false;
    var map = await _doHandler('/playlist/create', param: {'name': name});
    create = map != null;
    return create;
  }

  ///搜索// 1: 单曲, 10: 专辑, 100: 歌手, 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频
  Future<SearchSongEntity> search(content, type) async {
    var searchData;
    var map = await _doHandler('/search', param: {'keywords': content, 'type': type});
    if (map != null) searchData = SearchSongEntity.fromJson(map);
    return searchData;
  }

  ///听歌历史
  Future<PlayHistoryEntity> getHistory(uid) async {
    var history;
    var map = await _doHandler('/user/record', param: {'uid': uid});
    if (map != null) history = PlayHistoryEntity.fromJson(map);
    return history;
  }

  ///歌词
  Future<LyricEntity> getMusicLyric(id) async {
    var lyric;
    if (await BuJuanUtil.checkFileExists('$id')) {
      debugPrint("lyric已缓存，直接拿哈");
      var data = await BuJuanUtil.readStringFile('$id');
      if (data != null) lyric = LyricEntity.fromJson(data);
    } else {
      debugPrint("lyric未缓存");
      var map = await _doHandler('/lyric', param: {'id': id}, cacheName: '$id');
      if (map != null) lyric = LyricEntity.fromJson(map);
    }
    return lyric;
  }

  ///获取云盘数据
  Future<List<SheetDetailsPlaylistTrack>> getCloudData(offset) async {
    CloudEntity cloud;
    var map = await _doHandler('/user/cloud', param: {'offset': offset});
    if (map != null) cloud = CloudEntity.fromJson(map);
    List<int> ids = [];
    await Future.forEach(cloud.data, (id) => ids.add(id.songId));
    var list = await getSongDetails(ids.join(','));
    return list;
  }

  ///根据分类获取歌单
  Future<SheetByClassify> getSheetByClassify(cat, offset) async {
    var sheetByClassify;
    var map = await _doHandler('/top/playlist', param: {'cat': cat, 'offset': offset});
    if (map != null) sheetByClassify = SheetByClassify.fromJson(map);
    return sheetByClassify;
  }

  ///获取歌曲评论
  Future<MusicTalk> getMusicTalk(id, type, pageNo) async {
    var talk;
    var map = await _doHandler('/comment/new', param: {'id': id, 'type': type, 'pageNo': pageNo});
    if (map != null) talk = MusicTalk.fromJson(map);
    return talk;
  }

  ///获取歌曲楼层评论
  Future<void> getMusicFloorTalk() async {
    await _doHandler('');
  }

//播放音乐
// Future setPlayListAndPlayById(List<SongInfo> list, int index, String id) async {
// var playList = await FlutterStarrySky().getPlayList();
// if (playList == null) await GlobalStore.store.dispatch(GlobalActionCreator.changeCurrSong(list[index]));
// await FlutterStarrySky().setPlayListAndPlayById(list, index, '$id');
// }

}
