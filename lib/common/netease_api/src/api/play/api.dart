import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../netease_music_api.dart';
import '../../../src/api/bean.dart';
import '../../../src/dio_ext.dart';
import '../../../src/netease_handler.dart';

mixin ApiPlay {
  DioMetaData playlistSubscribersDioMetaData(String pid, {int offset = 0, int limit = 30}) {
    var params = {'id': pid, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/playlist/subscribers'), data: params, options: joinOptions());
  }

  /// 歌单收藏者
  Future<PlaylistSubscribersWrap> playlistSubscribers(String pid, {int offset = 0, int limit = 30}) {
    return Https.dioProxy.postUri(playlistSubscribersDioMetaData(pid, offset: offset, limit: limit)).then((Response value) {
      return PlaylistSubscribersWrap.fromJson(value.data);
    });
  }

  DioMetaData subscribePlayListDioMetaData(String pid, {bool subscribe = true}) {
    var params = {'id': pid};
    return DioMetaData(joinUri('/weapi/playlist/${subscribe ? 'subscribe' : 'unsubscribe'}'), data: params, options: joinOptions());
  }

  /// 歌单收藏
  Future<ServerStatusBean> subscribePlayList(String pid, {bool subscribe = true}) {
    return Https.dioProxy.postUri(subscribePlayListDioMetaData(pid, subscribe: subscribe)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData playlistCatalogueDioMetaData() {
    return DioMetaData(joinUri('/weapi/playlist/catalogue'), data: {}, options: joinOptions());
  }

  /// 歌单分类
  Future<PlaylistCatalogueWrap> playlistCatalogue() {
    return Https.dioProxy.postUri(playlistCatalogueDioMetaData()).then((Response value) {
      return PlaylistCatalogueWrap.fromJson(value.data);
    });
  }

  DioMetaData playlistHotTagsDioMetaData() {
    return DioMetaData(joinUri('/weapi/playlist/hottags'), data: {}, options: joinOptions());
  }

  /// 热门歌单tags
  Future<PlaylistHotTagsWrap> playlistHotTags() {
    return Https.dioProxy.postUri(playlistHotTagsDioMetaData()).then((Response value) {
      return PlaylistHotTagsWrap.fromJson(value.data);
    });
  }

  DioMetaData highqualityPlaylistHotTagsDioMetaData() {
    return DioMetaData(joinUri('/api/playlist/highquality/tags'), data: {}, options: joinOptions());
  }

  /// 精品歌单tags
  Future<PlaylistHotTagsWrap> highqualityPlaylistHotTags() {
    return Https.dioProxy.postUri(highqualityPlaylistHotTagsDioMetaData()).then((Response value) {
      return PlaylistHotTagsWrap.fromJson(value.data);
    });
  }

  DioMetaData highqualityPlayListDioMetaData({String category = '全部', int limit = 30, bool total = true, int lastTime = 0}) {
    var params = {'cat': category, 'limit': limit, 'lastTime': lastTime, 'total': total};
    return DioMetaData(joinUri('/weapi/playlist/highquality/list'), data: params, options: joinOptions());
  }

  /// 精品歌单
  /// [category] tag, 比如 " 华语 "、" 古风 " 、" 欧美 "、" 流行 ", 默认为 "全部",可从歌单分类接口获取[playlistCatalogue]
  Future<MultiPlayListWrap> highqualityPlayList({String category = '全部', int limit = 30, bool total = true, int lastTime = 0}) {
    return Https.dioProxy.postUri(highqualityPlayListDioMetaData(category: category, limit: limit, total: total, lastTime: lastTime)).then((Response value) {
      return MultiPlayListWrap.fromJson(value.data);
    });
  }

  DioMetaData relatedPlayListDioMetaData(String songId) {
    return DioMetaData(joinUri('/playlist?id=$songId'), options: joinOptions(userAgent: UserAgent.Pc));
  }

  /// 歌曲相关歌单列表
  /// [songId] 歌曲id
  Future<MultiPlayListWrap> relatedPlayList(String songId) {
    return Https.dioProxy.getUri(relatedPlayListDioMetaData(songId)).then((Response value) {
      var listWrap = MultiPlayListWrap();
      listWrap.code = RET_CODE_OK;
      listWrap.playlists = [];
      try {
        const pattern =
            r'<div class="cver u-cover u-cover-3">[\s\S]*?<img src="([^"]+)">[\s\S]*?<a class="sname f-fs1 s-fc0" href="([^"]+)"[^>]*>([^<]+?)<\/a>[\s\S]*?<a class="nm nm f-thide s-fc3" href="([^"]+)"[^>]*>([^<]+?)<\/a>';
        var matchs = RegExp(pattern, multiLine: true).allMatches(value.data);
        for (var match in matchs) {
          try {
            var item = Play();
            item.id = match.group(2)?.substring('/playlist?id='.length) ?? '';
            item.name = match.group(3) ?? '';
            item.coverImgUrl = match.group(1)?.substring(0, match.group(1)?.length ?? 0 - '?param=50y50'.length) ?? '';
            item.creator = NeteaseUserInfo();
            item.creator?.userId = match.group(4)?.substring('/user/home?id='.length) ?? '';
            item.creator?.nickname = match.group(5) ?? '';
            listWrap.playlists?.add(item);
          } catch (ignore) {}
        }
      } catch (e) {
        listWrap.code = RET_CODE_UNKNOW;
      }
      return listWrap;
    });
  }

  DioMetaData personalizedPlaylistDioMetaData({int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset, 'n': 1000};
    return DioMetaData(joinUri('/weapi/personalized/playlist'), data: params, options: joinOptions());
  }

  /// 推荐歌单
  Future<PersonalizedPlayListWrap> personalizedPlaylist({int offset = 0, int limit = 30}) {
    return Https.dioProxy.postUri(personalizedPlaylistDioMetaData(offset: offset, limit: limit)).then((Response value) {
      return PersonalizedPlayListWrap.fromJson(value.data);
    });
  }

  DioMetaData recommendPlaylistDioMetaData() {
    return DioMetaData(joinUri('/weapi/v1/discovery/recommend/resource'), data: {}, options: joinOptions());
  }

  /// 每日推荐歌单
  /// !需要登录
  Future<RecommendPlayListWrap> recommendPlaylist() {
    return Https.dioProxy.postUri(recommendPlaylistDioMetaData()).then((Response value) {
      return RecommendPlayListWrap.fromJson(value.data);
    });
  }

  DioMetaData playmodeIntelligenceListDioMetaData(String songId, String playlistId, {String? startMusicId, int count = 1}) {
    var params = {'songId': songId, 'type': 'fromPlayOne', 'playlistId': playlistId, 'startMusicId': startMusicId ?? songId, 'count': count};
    return DioMetaData(joinUri('/weapi/playmode/intelligence/list'), data: params, options: joinOptions());
  }

  /// 心动模式/智能播放
  /// [songId]  歌曲 id
  /// [playlistId]  歌单 id
  /// [startMusicId]  要开始播放的歌曲的 id
  Future<PlaymodeIntelligenceListWrap> playmodeIntelligenceList(String songId, String playlistId, {String? startMusicId, int count = 1}) {
    return Https.dioProxy.postUri(playmodeIntelligenceListDioMetaData(songId, playlistId, startMusicId: startMusicId, count: count)).then((Response value) {
      return PlaymodeIntelligenceListWrap.fromJson(value.data);
    });
  }

  DioMetaData playListSimiListDioMetaData(String songId, {int offset = 0, int limit = 30}) {
    var params = {'songid': songId, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/discovery/simiPlaylist'), data: params, options: joinOptions());
  }

  /// 相似歌单
  /// [songId] 歌曲 id
  Future<MultiPlayListWrap> playListSimiList(String songId, {int offset = 0, int limit = 30}) {
    return Https.dioProxy.postUri(playListSimiListDioMetaData(songId, offset: offset, limit: limit)).then((Response value) {
      return MultiPlayListWrap.fromJson(value.data);
    });
  }

  DioMetaData playListDetailDioMetaData(String categoryId, {int subCount = 5}) {
    var params = {'id': categoryId, 'n': 1000, 's': '$subCount', 'shareUserId': '0'};
    return DioMetaData(Uri.parse('https://music.163.com/api/v6/playlist/detail'), data: params, options: joinOptions());
  }

  /// 歌单详情
  /// https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=%e8%8e%b7%e5%8f%96%e6%ad%8c%e5%8d%95%e8%af%a6%e6%83%85
  /// [categoryId] 可从歌单分类接口获取[playlistCatalogue]
  Future<SinglePlayListWrap> playListDetail(String categoryId, {int subCount = 5}) {
    return Https.dioProxy.postUri(playListDetailDioMetaData(categoryId, subCount: subCount)).then((Response value) {
      return SinglePlayListWrap.fromJson(value.data);
    });
  }

  DioMetaData playListDetailDynamicDioMetaData(String playlistId, {int subCount = 8}) {
    var params = {'id': playlistId, 'n': 1000, 's': '$subCount'};
    return DioMetaData(joinUri('/api/playlist/detail/dynamic'), data: params, options: joinOptions(userAgent: UserAgent.Pc, cookies: {'os': 'android'}));
  }

  /// 歌单详情 获取歌单详情动态部分,如评论数,是否收藏,播放数
  Future<PlayListDetailDynamicWrap> playListDetailDynamic(String playlistId, {int subCount = 8}) {
    return Https.dioProxy.postUri(playListDetailDynamicDioMetaData(playlistId, subCount: subCount)).then((Response value) {
      return PlayListDetailDynamicWrap.fromJson(value.data);
    });
  }

  DioMetaData categorySongListDioMetaData({
    String category = '全部',
    String order = 'hot',
    int offset = 0,
    int limit = 30,
    bool total = true,
  }) {
    var params = {'cat': category, 'order': order, 'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/playlist/list'), data: params, options: joinOptions());
  }

  /// 分类歌单歌曲列表
  /// [category] tag, 比如 " 华语 "、" 古风 " 、" 欧美 "、" 流行 ", 默认为 "全部",可从歌单分类接口获取[playlistCatalogue]
  /// [order] 'new':最新  'hot':最热 默认为 'hot'
  Future<MultiPlayListWrap> categorySongList({
    String category = '全部',
    String order = 'hot',
    int offset = 0,
    int limit = 30,
    bool total = true,
  }) {
    return Https.dioProxy.postUri(categorySongListDioMetaData(category: category, order: order, offset: offset, limit: limit, total: total)).then((Response value) {
      return MultiPlayListWrap.fromJson(value.data);
    });
  }

  DioMetaData recommendSongListDioMetaData() {
    return DioMetaData(joinUri('/api/v3/discovery/recommend/songs'), data: {}, options: joinOptions(cookies: {'os': 'ios'}));
  }

  /// 推荐音乐列表
  /// !需要登录
  Future<RecommendSongListWrapX> recommendSongList() {
    return Https.dioProxy.postUri(recommendSongListDioMetaData()).then((Response value) {
      return RecommendSongListWrapX.fromJson(value.data);
    });
  }

  DioMetaData recommendSongListHistoryDioMetaData() {
    return DioMetaData(joinUri('/api/discovery/recommend/songs/history/recent'), data: {}, options: joinOptions(cookies: {'os': 'ios'}));
  }

  /// 历史推荐音乐列表 可用日期列表
  /// !需要登录
  Future<RecommendSongListHistoryWrapX> recommendSongListHistory() {
    return Https.dioProxy.postUri(recommendSongListHistoryDioMetaData()).then((Response value) {
      return RecommendSongListHistoryWrapX.fromJson(value.data);
    });
  }

  DioMetaData recommendSongListHistoryDetailDioMetaData({String date = ''}) {
    var params = {'date': date};
    return DioMetaData(joinUri('/api/discovery/recommend/songs/history/detail'), data: params, options: joinOptions(cookies: {'os': 'ios'}));
  }

  /// 历史推荐音乐列表 详细音乐列表数据
  /// !需要登录
  Future<RecommendSongListHistoryWrapX> recommendSongListHistoryDetail({String date = ''}) {
    return Https.dioProxy.postUri(recommendSongListHistoryDetailDioMetaData(date: date)).then((Response value) {
      return RecommendSongListHistoryWrapX.fromJson(value.data);
    });
  }

  DioMetaData yunbeiRecommendSongDioMetaData(String songId, {String reason = '好歌献给你', String fromUserId = '-1'}) {
    return DioMetaData(joinUri('/weapi/yunbei/rcmd/song/submit'),
        data: {
          'songId': songId,
          'reason': reason,
          'fromUserId': fromUserId,
          'scene': '',
        },
        options: joinOptions());
  }

  /// 云贝推歌
  /// !需要登录
  Future<ServerStatusBean> yunbeiRecommendSong(String songId, {String reason = '好歌献给你', String fromUserId = '-1'}) {
    return Https.dioProxy.postUri(yunbeiRecommendSongDioMetaData(songId, reason: reason, fromUserId: fromUserId)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData yunbeiRecommendSongHistoryListDioMetaData({int size = 20, String cursor = ''}) {
    return DioMetaData(joinUri('/weapi/yunbei/rcmd/song/history/list'),
        data: {
          'size': size,
          'cursor': cursor,
        },
        options: joinOptions());
  }

  /// 云贝推歌历史记录
  /// !需要登录
  Future<ServerStatusBean> yunbeiRecommendSongHistoryList({int size = 20, String cursor = ''}) {
    return Https.dioProxy.postUri(yunbeiRecommendSongHistoryListDioMetaData(size: size, cursor: cursor)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData userRadioDioMetaData() {
    return DioMetaData(joinUri('/weapi/v1/radio/get'), data: {}, options: joinOptions());
  }

  /// 私人FM
  /// !需要登录
  Future<SongListWrap2> userRadio() {
    return Https.dioProxy.postUri(userRadioDioMetaData()).then((Response value) {
      return SongListWrap2.fromJson(value.data);
    });
  }

  DioMetaData userRadioTrashDioMetaData(String songId, {int time = 3, String alg = 'RT'}) {
    var params = {'songId': songId};
    return DioMetaData(joinUri('/weapi/radio/trash/add?alg=$alg&songId=$songId&time=$time'), data: params, options: joinOptions());
  }

  /// 私人FM 垃圾桶
  /// !需要登录
  Future<SongListWrap> userRadioTrash(String songId, {int time = 3, String alg = 'RT'}) {
    return Https.dioProxy.postUri(userRadioTrashDioMetaData(songId, time: time, alg: alg)).then((Response value) {
      return SongListWrap.fromJson(value.data);
    });
  }

  DioMetaData personalizedSongListDioMetaData() {
    var params = {'type': 'recommend'};
    return DioMetaData(joinUri('/api/personalized/newsong'), data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 推荐新歌
  Future<PersonalizedSongListWrap> personalizedSongList() {
    return Https.dioProxy.postUri(personalizedSongListDioMetaData()).then((Response value) {
      return PersonalizedSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData newSongListDioMetaData({String areaId = '0'}) {
    var params = {'areaId': areaId, 'total': true};
    return DioMetaData(joinUri('/weapi/v1/discovery/new/songs'), data: params, options: joinOptions());
  }

  /// 新歌速递
  /// [areaId] 全部:0 华语:7 欧美:96 日本:8 韩国:16 默认0
  Future<SongListWrap2> newSongList({String areaId = '8'}) {
    return Https.dioProxy.postUri(newSongListDioMetaData(areaId: areaId)).then((Response value) {
      return SongListWrap2.fromJson(value.data);
    });
  }

  DioMetaData userSongSimiListDioMetaData(String songId) {
    var params = {'songid': songId};
    return DioMetaData(joinUri('/weapi/discovery/simiUser'), data: params, options: joinOptions());
  }

  /// 最近5个听了这首歌的用户
  Future<UserListWrap> userSongSimiList(String songId) {
    return Https.dioProxy.postUri(userSongSimiListDioMetaData(songId)).then((Response value) {
      return UserListWrap.fromJson(value.data);
    });
  }

  DioMetaData songSimiListDioMetaData(String songId, {int offset = 0, int limit = 30}) {
    var params = {'songid': songId, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/v1/discovery/simiSong'), data: params, options: joinOptions());
  }

  /// 相似mv
  Future<SongListWrap> songSimiList(String songId, {int offset = 0, int limit = 30}) {
    return Https.dioProxy.postUri(songSimiListDioMetaData(songId, offset: offset, limit: limit)).then((Response value) {
      return SongListWrap.fromJson(value.data);
    });
  }

  DioMetaData likeSongListDioMetaData(String userId) {
    var params = {'uid': userId};
    return DioMetaData(joinUri('/weapi/song/like/get'), data: params, options: joinOptions());
  }

  /// 喜欢的歌曲(无序)
  Future<LikeSongListWrap> likeSongList(String userId) {
    return Https.dioProxy.postUri(likeSongListDioMetaData(userId)).then((Response value) {
      return LikeSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData cloudSongDioMetaData({int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/v1/cloud/get'), data: params, options: joinOptions());
  }

  /// 获取云盘?音乐?
  /// !需要登录
  Future<CloudSongListWrap> cloudSong({int offset = 0, int limit = 30}) {
    return Https.dioProxy.postUri(cloudSongDioMetaData(offset: offset, limit: limit)).then((Response value) {
      return CloudSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData cloudSongDetailDioMetaData(List<String> songIds) {
    var params = {'songIds': songIds};
    return DioMetaData(joinUri('/weapi/v1/cloud/get/byids'), data: params, options: joinOptions());
  }

  /// 获取云盘?音乐?详情
  /// !需要登录
  Future<ServerStatusBean> cloudSongDetail(List<String> songIds) {
    return Https.dioProxy.postUri(cloudSongDetailDioMetaData(songIds)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData cloudSongDeleteDioMetaData(List<String> songIds) {
    var params = {'songIds': songIds};
    return DioMetaData(joinUri('/weapi/cloud/del'), data: params, options: joinOptions());
  }

  /// 删除云盘?音乐?
  /// !需要登录
  Future<CloudSongListWrap> cloudSongDelete(List<String> songIds) {
    return Https.dioProxy.postUri(cloudSongDeleteDioMetaData(songIds)).then((Response value) {
      return CloudSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData cloudUserSongMatchDioMetaData(String userId, String songId, String adjustSongId) {
    var params = {
      'userId': userId,
      'songId': songId,
      'adjustSongId': adjustSongId,
    };
    return DioMetaData(joinUri('/api/cloud/user/song/match'), data: params, options: joinOptions(cookies: {'os': 'ios', 'appver': '8.0.00'}));
  }

  /// 云盘歌曲信息匹配纠正,如需取消匹配,adjustSongId需要传0
  /// TODO 数据结构
  /// !需要登录
  Future<ServerStatusBean> cloudUserSongMatch(String userId, String songId, String adjustSongId) {
    return Https.dioProxy.postUri(cloudUserSongMatchDioMetaData(userId, songId, adjustSongId)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData likeSongDioMetaData(String songId, bool like, {int time = 3, String alg = 'itembased'}) {
    var params = {'trackId': songId, 'like': like};
    return DioMetaData(joinUri('/weapi/radio/like?alg=$alg&trackId=$songId&time=$time'),
        data: params,
        options: joinOptions(
          userAgent: UserAgent.Pc,
          cookies: {'os': 'pc', 'appver': '2.9.7'},
        ));
  }

  /// 歌曲 红心与取消红心
  Future<ServerStatusBean> likeSong(String songId, bool like, {int time = 3, String alg = 'itembased'}) {
    return Https.dioProxy.postUri(likeSongDioMetaData(songId, like, time: time, alg: alg)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  /// 听歌打卡
  /// [id] 歌单或专辑 id
  /// [time] 歌曲播放时间,单位为秒
  Future<ServerStatusBean> punchSong(String songId, String id, {int time = 0}) {
    return NeteaseMusicApi().weblog(songId, id, 'play', 'song', 'playend');
  }

  DioMetaData songDetailDioMetaData(List<String> songIds) {
    var params = {
      // 'ids': songIds,
      'c': songIds.map((e) => jsonEncode({'id': e})).toList()
    };
    return DioMetaData(joinUri('/api/v3/song/detail'), data: params, options: joinOptions());
  }

  /// 音乐详情
  Future<SongDetailWrap> songDetail(List<String> songIds) {
    return Https.dioProxy.postUri(songDetailDioMetaData(songIds)).then((Response value) {
      return SongDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData songUrlDioMetaData(List<String> songIds, {int br = 999000}) {
    var params = {'ids': songIds, 'br': br};
    return DioMetaData(Uri.parse('https://interface3.music.163.com/eapi/song/enhance/player/url'),
        data: params, options: joinOptions(encryptType: EncryptType.EApi, cookies: {'os': 'pc'}, eApiUrl: '/api/song/enhance/player/url'));
  }

  /// 音乐url
  /// https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=%e8%8e%b7%e5%8f%96%e9%9f%b3%e4%b9%90-url
  /// 说明 : 使用歌单详情接口后 , 能得到的音乐的 id, 但不能得到的音乐 url, 调用此接口, 传入的音乐 id( 可多个 , 用逗号隔开 ), 可以获取对应的音乐的 url,未登录状态返回试听片段(返回字段包含被截取的正常歌曲的开始时间和结束时间)
  /// 注 : 部分用户反馈获取的 url 会 403,hwaphon找到的 解决方案是当获取到音乐的 id 后，将 https://music.163.com/song/media/outer/url?id=id.mp3 以 src 赋予 Audio 即可播放
  /// [br] 码率,默认设置了 999000 即最大码率,如果要 320k 则可设置为 320000,其他类推
  Future<SongUrlListWrap> songUrl(List<String> songIds, {int br = 320000}) {
    return Https.dioProxy.postUri(songUrlDioMetaData(songIds, br: br)).then((Response value) {
      return SongUrlListWrap.fromJson(value.data);
    });
  }

  DioMetaData songDownloadUrlDioMetaData(List<String> songIds, {String level = 'exhigh'}) {
    var params = {
      'ids': songIds,
      'level': level,
      'encodeType': 'flac',
    };
    return DioMetaData(Uri.parse('https://interface.music.163.com/eapi/song/enhance/player/url/v1'),
        data: params, options: joinOptions(encryptType: EncryptType.EApi, eApiUrl: '/api/song/enhance/player/url/v1'));
  }

  /// 音乐url
  /// https://binaryify.github.io/NeteaseCloudMusicApi/#/?id=%e8%8e%b7%e5%8f%96%e9%9f%b3%e4%b9%90-url
  /// 说明 : 使用歌单详情接口后 , 能得到的音乐的 id, 但不能得到的音乐 url, 调用此接口, 传入的音乐 id( 可多个 , 用逗号隔开 ), 可以获取对应的音乐的 url,未登录状态返回试听片段(返回字段包含被截取的正常歌曲的开始时间和结束时间)
  /// 注 : 部分用户反馈获取的 url 会 403,hwaphon找到的 解决方案是当获取到音乐的 id 后，将 https://music.163.com/song/media/outer/url?id=id.mp3 以 src 赋予 Audio 即可播放
  /// [br] 码率,默认设置了 999000 即最大码率,如果要 320k 则可设置为 320000,其他类推
  Future<SongUrlListWrap> songDownloadUrl(List<String> songIds, {String level = 'exhigh'}) {
    return Https.dioProxy.postUri(songDownloadUrlDioMetaData(songIds, level: level)).then((Response value) {
      return SongUrlListWrap.fromJson(value.data);
    });
  }

  DioMetaData songLyricDioMetaData(String songId) {
    var params = {'id': songId, 'lv': -1, 'kv': -1, 'tv': -1};
    return DioMetaData(joinUri('/api/song/lyric'), data: params, options: joinOptions(encryptType: EncryptType.WeApi, cookies: {'os': 'pc'}));
  }

  /// 音乐歌词
  Future<SongLyricWrap> songLyric(String songId) {
    return Https.dioProxy.postUri(songLyricDioMetaData(songId)).then((Response value) {
      return SongLyricWrap.fromJson(value.data);
    });
  }

  DioMetaData songAvailableCheckDioMetaData(List<String> songIds, {int br = 999000}) {
    var params = {'ids': songIds, 'br': br};
    return DioMetaData(joinUri('/weapi/song/enhance/player/url'), data: params, options: joinOptions());
  }

  /// 音乐是否可用
  /// [br] 码率,默认设置了 999000 即最大码率,如果要 320k 则可设置为 320000,其他类推
  /// [SongUrlListWrap.code] 200
  Future<SongUrlListWrap> songAvailableCheck(List<String> songIds, {int br = 999000}) {
    return Https.dioProxy.postUri(songAvailableCheckDioMetaData(songIds, br: br)).then((Response value) {
      return SongUrlListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistListDioMetaData(int initial, {int offset = 0, int limit = 30, bool total = true, int type = 1, int area = -1}) {
    var params = {'initial': initial, 'type': type, 'area': area, 'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/v1/artist/list'), data: params, options: joinOptions());
  }

  /// 分类 歌手列表
  /// [type]   -1:全部 1:男歌手 2:女歌手 3:乐队
  /// [area]   -1:全部 7:华语 96:欧美 8:日本 16:韩国 0:其他
  /// [initial] 取值 a-z/A-Z
  Future<ArtistsListWrap> artistList(int initial, {int offset = 0, int limit = 30, bool total = true, int type = 1, int area = -1}) {
    return Https.dioProxy.postUri(artistListDioMetaData(initial, offset: offset, limit: limit, total: total, type: type, area: area)).then((Response value) {
      return ArtistsListWrap.fromJson(value.data);
    });
  }

  DioMetaData topArtistDioMetaData({int offset = 0, int limit = 30, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/artist/top'), data: params, options: joinOptions());
  }

  /// 热门歌手
  Future<ArtistsListWrap> topArtist({int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(topArtistDioMetaData(offset: offset, limit: limit, total: total)).then((Response value) {
      return ArtistsListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistTopListDioMetaData({int type = 1, int offset = 0, int limit = 30, bool total = true}) {
    var params = {'type': type, 'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/toplist/artist'), data: params, options: joinOptions());
  }

  /// 歌手排行榜
  /// type : 地区 1: 华语   2: 欧美   3: 韩国  4: 日本
  Future<ArtistsTopListWrapX> artistTopList({int type = 1, int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(artistTopListDioMetaData(type: type, offset: offset, limit: limit, total: total)).then((Response value) {
      return ArtistsTopListWrapX.fromJson(value.data);
    });
  }

  DioMetaData artistSimiListDioMetaData(String artistId) {
    var params = {'artistid': artistId};
    return DioMetaData(joinUri('/weapi/discovery/simiArtist'), data: params, options: joinOptions());
  }

  /// 相似歌手
  Future<ArtistsListWrap> artistSimiList(String artistId) {
    return Https.dioProxy.postUri(artistSimiListDioMetaData(artistId)).then((Response value) {
      return ArtistsListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistDescDioMetaData(String artistId) {
    var params = {'id': artistId};
    return DioMetaData(joinUri('/weapi/artist/introduction'), data: params, options: joinOptions());
  }

  /// 歌手介绍
  Future<ArtistDescWrap> artistDesc(String artistId) {
    return Https.dioProxy.postUri(artistDescDioMetaData(artistId)).then((Response value) {
      return ArtistDescWrap.fromJson(value.data);
    });
  }

  DioMetaData artistDetailDioMetaData(String artistId) {
    var params = {'id': artistId};
    return DioMetaData(joinUri('/api/artist/head/info/get'), data: params, options: joinOptions());
  }

  /// 歌手详情
  Future<ArtistDetailWrap> artistDetail(String artistId) {
    return Https.dioProxy.postUri(artistDetailDioMetaData(artistId)).then((Response value) {
      return ArtistDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData artistTopSongListDioMetaData(String artistId) {
    var params = {'id': artistId};
    return DioMetaData(joinUri('/api/artist/top/song'), data: params, options: joinOptions());
  }

  /// 歌手热门50首歌曲
  Future<ArtistSongListWrap> artistTopSongList(String artistId) {
    return Https.dioProxy.postUri(artistTopSongListDioMetaData(artistId)).then((Response value) {
      return ArtistSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistALLSongListDioMetaData(
    String artistId, {
    bool privateCloud = true,
    int workType = 1,
    order = 'hot',
    int offset = 0,
    int limit = 100,
  }) {
    var params = {'id': artistId, 'private_cloud': privateCloud, 'work_type': workType, 'order': order, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/v1/artist/songs'), data: params, options: joinOptions());
  }

  /// 歌手全部歌曲
  /// [order] hot time
  Future<ArtistSongListWrap> artistALLSongList(
    String artistId, {
    bool privateCloud = true,
    int workType = 1,
    order = 'hot',
    int offset = 0,
    int limit = 100,
  }) {
    return Https.dioProxy.postUri(artistALLSongListDioMetaData(artistId)).then((Response value) {
      return ArtistSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistFollowedNewSongListDioMetaData({int before = 0, int limit = 20}) {
    var params = {'limit': limit, 'startTimestamp': before};
    return DioMetaData(joinUri('/api/sub/artist/new/works/song/list'), data: params, options: joinOptions(cookies: {'os': 'ios', 'appver': '8.0.00'}));
  }

  /// 已关注的歌手新歌曲
  /// !需要登录
  Future<ArtistNewSongListWrap> artistFollowedNewSongList({int before = 0, int limit = 20}) {
    return Https.dioProxy.postUri(artistFollowedNewSongListDioMetaData(before: before, limit: limit)).then((Response value) {
      return ArtistNewSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistDetailAndSongListDioMetaData(String artistId) {
    return DioMetaData(joinUri('/weapi/v1/artist/$artistId'), data: {}, options: joinOptions());
  }

  /// 歌手信息+歌曲
  Future<ArtistDetailAndSongListWrap> artistDetailAndSongList(String artistId) {
    return Https.dioProxy.postUri(artistDetailAndSongListDioMetaData(artistId)).then((Response value) {
      return ArtistDetailAndSongListWrap.fromJson(value.data);
    });
  }

  DioMetaData allMvListDioMetaData({String area = '全部', String type = '全部', String order = '上升最快', int offset = 0, int limit = 30, bool total = true}) {
    var params = {
      'tags': jsonEncode({'地区': area, '类型': type, '排序': order}),
      'total': total,
      'limit': limit,
      'offset': offset
    };
    return DioMetaData(Uri.parse('https://interface.music.163.com/api/mv/all'), data: params, options: joinOptions());
  }

  /// 全部MV
  /// [area] 全部,内地,港台,欧美,日本,韩国  默认全部
  /// [type] 全部,官方版,原生,现场版,网易出品  默认全部
  /// [order] 上升最快,最热,最新  默认上升最快
  Future<MvListWrap2> allMvList({String area = '全部', String type = '全部', String order = '上升最快', int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(allMvListDioMetaData(area: area, type: type, order: order, offset: offset, limit: limit, total: total)).then((Response value) {
      return MvListWrap2.fromJson(value.data);
    });
  }

  DioMetaData topMvListDioMetaData({String area = '', int offset = 0, int limit = 30, bool total = true}) {
    var params = {'area': area, 'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/mv/toplist'), data: params, options: joinOptions());
  }

  /// MV排行
  /// [area] 全部:'',内地,港台,欧美,日本,韩国  默认全部
  Future<MvListWrap2> topMvList({String area = '', int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(topMvListDioMetaData(area: area, offset: offset, limit: limit, total: total)).then((Response value) {
      return MvListWrap2.fromJson(value.data);
    });
  }

  DioMetaData newestMvListDioMetaData({String area = '', int offset = 0, int limit = 30, bool total = true}) {
    var params = {'area': area, 'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(Uri.parse('https://interface.music.163.com/weapi/mv/first'), data: params, options: joinOptions());
  }

  /// 最新MV
  /// [area] 全部:'',内地,港台,欧美,日本,韩国  默认全部
  Future<MvListWrap2> newestMvList({String area = '', int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(newestMvListDioMetaData(area: area, offset: offset, limit: limit, total: total)).then((Response value) {
      return MvListWrap2.fromJson(value.data);
    });
  }

  DioMetaData neteaseMvListDioMetaData({int offset = 0, int limit = 30, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(Uri.parse('https://interface.music.163.com/api/mv/exclusive/rcmd'), data: params, options: joinOptions());
  }

  /// 网易出品MV
  Future<MvListWrap2> neteaseMvList({int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(neteaseMvListDioMetaData(offset: offset, limit: limit, total: total)).then((Response value) {
      return MvListWrap2.fromJson(value.data);
    });
  }

  DioMetaData personalizedMvListDioMetaData() {
    return DioMetaData(joinUri('/weapi/personalized/mv'), data: {}, options: joinOptions());
  }

  /// 推荐MV
  Future<PersonalizedMvListWrap> personalizedMvList() {
    return Https.dioProxy.postUri(personalizedMvListDioMetaData()).then((Response value) {
      return PersonalizedMvListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistMvListDioMetaData(String artistId, {int offset = 0, int limit = 30, bool total = true}) {
    var params = {'artistId': artistId, 'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/artist/mvs'), data: params, options: joinOptions());
  }

  /// 歌手MV列表
  Future<ArtistMvListWrap> artistMvList(String artistId, {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(artistMvListDioMetaData(artistId, offset: offset, limit: limit, total: total)).then((Response value) {
      return ArtistMvListWrap.fromJson(value.data);
    });
  }

  DioMetaData artistFollowedNewMvListDioMetaData({int before = 0, int limit = 20}) {
    if (before == 0) {
      before = DateTime.now().millisecondsSinceEpoch;
    }
    var params = {'limit': limit, 'startTimestamp': before};
    return DioMetaData(joinUri('/api/sub/artist/new/works/mv/list'), data: params, options: joinOptions(cookies: {'os': 'ios', 'appver': '8.0.00'}));
  }

  /// 已关注歌手新MV列表
  /// !需要登录
  Future<ArtistNewMvListWrap> artistFollowedNewMvList({int before = 0, int limit = 20}) {
    return Https.dioProxy.postUri(artistFollowedNewMvListDioMetaData(before: before, limit: limit)).then((Response value) {
      return ArtistNewMvListWrap.fromJson(value.data);
    });
  }

  DioMetaData mvSimiListDioMetaData(String mvId) {
    var params = {'mvid': mvId};
    return DioMetaData(joinUri('/weapi/discovery/simiMV'), data: params, options: joinOptions());
  }

  /// 相似MV
  Future<MvListWrap> mvSimiList(String mvId) {
    return Https.dioProxy.postUri(mvSimiListDioMetaData(mvId)).then((Response value) {
      return MvListWrap.fromJson(value.data);
    });
  }

  DioMetaData mvDetailDioMetaData(String mvId) {
    var params = {'id': mvId};
    return DioMetaData(joinUri('/weapi/mv/detail'), data: params, options: joinOptions());
  }

  /// MV详情
  Future<MvDetailWrap> mvDetail(String mvId) {
    return Https.dioProxy.postUri(mvDetailDioMetaData(mvId)).then((Response value) {
      return MvDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData mvDetailInfoDioMetaData(String mvId) {
    var params = {'threadid': 'R_MV_5_$mvId', 'composeliked': true};
    return DioMetaData(joinUri('/api/comment/commentthread/info'), data: params, options: joinOptions());
  }

  /// MV 点赞转发评论数数据
  Future<MvDetailInfoWrap> mvDetailInfo(String mvId) {
    return Https.dioProxy.postUri(mvDetailInfoDioMetaData(mvId)).then((Response value) {
      return MvDetailInfoWrap.fromJson(value.data);
    });
  }

  DioMetaData mvUrlDioMetaData(String mvId, {int resolution = 1080}) {
    var params = {'id': mvId, 'r': resolution};
    return DioMetaData(joinUri('/weapi/song/enhance/play/mv/url'), data: params, options: joinOptions());
  }

  /// MV链接
  Future<MvUrlWrap> mvUrl(String mvId, {int resolution = 1080}) {
    return Https.dioProxy.postUri(mvUrlDioMetaData(mvId, resolution: resolution)).then((Response value) {
      return MvUrlWrap.fromJson(value.data);
    });
  }

  DioMetaData videoCategoryListDioMetaData({int offset = 0, int limit = 99, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/cloudvideo/category/list'), data: params, options: joinOptions());
  }

  /// 视频分类列表
  Future<VideoMetaListWrap> videoCategoryList({int offset = 0, int limit = 99, bool total = true}) {
    return Https.dioProxy.postUri(videoCategoryListDioMetaData(offset: offset, limit: limit, total: total)).then((Response value) {
      return VideoMetaListWrap.fromJson(value.data);
    });
  }

  DioMetaData videoGroupListDioMetaData() {
    return DioMetaData(joinUri('/api/cloudvideo/group/list'), data: {}, options: joinOptions());
  }

  /// 视频标签列表
  Future<VideoMetaListWrap> videoGroupList() {
    return Https.dioProxy.postUri(videoGroupListDioMetaData()).then((Response value) {
      return VideoMetaListWrap.fromJson(value.data);
    });
  }

  DioMetaData videoListByGroupDioMetaData(String groupId, {int offset = 0, bool total = true}) {
    var params = {'groupId': groupId, 'offset': offset, 'need_preview_url': true, 'total': total};
    return DioMetaData(joinUri('/api/videotimeline/videogroup/otherclient/get'), data: params, options: joinOptions());
  }

  /// 视频标签下的视频
  /// groupId 从[videoGroupList]获取
  Future<VideoListWrapX> videoListByGroup(String groupId, {int offset = 0, bool total = true}) {
    return Https.dioProxy.postUri(videoListByGroupDioMetaData(groupId, offset: offset, total: total)).then((Response value) {
      return VideoListWrapX.fromJson(value.data);
    });
  }

  DioMetaData videoListOtherDioMetaData(String groupId, {int offset = 0, bool total = true}) {
    var params = {"groupId": 0, "offset": offset, "need_preview_url": 'true', "total": total};
    return DioMetaData(joinUri('/api/videotimeline/otherclient/get'), data: params, options: joinOptions());
  }

  /// 视频列表
  Future<VideoListWrapX> videoListOther(String groupId, {int offset = 0, bool total = true}) {
    return Https.dioProxy.postUri(videoListOtherDioMetaData(groupId, offset: offset, total: total)).then((Response value) {
      return VideoListWrapX.fromJson(value.data);
    });
  }

  DioMetaData videoListDioMetaData({int offset = 0}) {
    var params = {"offset": offset, "filterLives": '[]', "withProgramInfo": 'true', "needUrl": 'true', "resolution": '480'};
    return DioMetaData(joinUri('/api/videotimeline/get'), data: params, options: joinOptions(encryptType: EncryptType.EApi, eApiUrl: '/api/videotimeline/get'));
  }

  /// 视频列表
  Future<VideoListWrapX> videoList({int offset = 0}) {
    return Https.dioProxy.postUri(videoListDioMetaData(offset: offset)).then((Response value) {
      return VideoListWrapX.fromJson(value.data);
    });
  }

  DioMetaData relatedVideoListDioMetaData(String videoId) {
    var params = {'id': videoId, 'type': RegExp(r'^\d+$').hasMatch(videoId) ? 0 : 1};
    return DioMetaData(joinUri('/weapi/cloudvideo/v1/allvideo/rcmd'), data: params, options: joinOptions());
  }

  /// 相关视频
  Future<VideoListWrap> relatedVideoList(String videoId) {
    return Https.dioProxy.postUri(relatedVideoListDioMetaData(videoId)).then((Response value) {
      return VideoListWrap.fromJson(value.data);
    });
  }

  DioMetaData videoDetailDioMetaData(String videoId) {
    var params = {'id': videoId};
    return DioMetaData(joinUri('/weapi/cloudvideo/v1/video/detail'), data: params, options: joinOptions());
  }

  /// 视频详情
  Future<VideoDetailWrap> videoDetail(String videoId) {
    return Https.dioProxy.postUri(videoDetailDioMetaData(videoId)).then((Response value) {
      return VideoDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData videoDetailInfoDioMetaData(String videoId) {
    var params = {'threadid': 'R_VI_62_$videoId', 'composeliked': true};
    return DioMetaData(joinUri('/api/comment/commentthread/info'), data: params, options: joinOptions());
  }

  /// 视频点赞转发评论数数据
  Future<VideoDetailInfoWrap> videoDetailInfo(String videoId) {
    return Https.dioProxy.postUri(videoDetailInfoDioMetaData(videoId)).then((Response value) {
      return VideoDetailInfoWrap.fromJson(value.data);
    });
  }

  DioMetaData videoUrlDioMetaData(List<String> videoIds, {int resolution = 1080}) {
    var params = {'ids': jsonEncode(videoIds), 'resolution': resolution};
    return DioMetaData(joinUri('/weapi/cloudvideo/playurl'), data: params, options: joinOptions());
  }

  /// 视频url
  Future<VideoUrlWrap> videoUrl(List<String> videoIds, {int resolution = 1080}) {
    return Https.dioProxy.postUri(videoUrlDioMetaData(videoIds, resolution: resolution)).then((Response value) {
      return VideoUrlWrap.fromJson(value.data);
    });
  }

  DioMetaData mlogMylikeDioMetaData({int time = -1, int limit = 12}) {
    var params = {'time': time, 'limit': limit};
    return DioMetaData(joinUri('/api/mlog/playlist/mylike/bytime/get'), data: params, options: joinOptions());
  }

  /// 获取点赞过的视频
  Future<MyLogMyLikeWrap> mlogMylike({int time = -1, int limit = 12}) {
    return Https.dioProxy.postUri(mlogMylikeDioMetaData(time: time, limit: limit)).then((Response value) {
      return MyLogMyLikeWrap.fromJson(value.data);
    });
  }

  DioMetaData artistAlbumListDioMetaData(String artistId, {int offset = 0, int limit = 30, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/artist/albums/$artistId'), data: params, options: joinOptions());
  }

  /// 歌手专辑列表
  Future<ArtistAlbumListWrap> artistAlbumList(String artistId, {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(artistAlbumListDioMetaData(artistId, offset: offset, limit: limit, total: total)).then((Response value) {
      return ArtistAlbumListWrap.fromJson(value.data);
    });
  }

  DioMetaData newAlbumListDioMetaData({int offset = 0, int limit = 30, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/album/new'), data: params, options: joinOptions());
  }

  /// 新碟上架
  Future<AlbumListWrap> newAlbumList({int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy.postUri(newAlbumListDioMetaData(offset: offset, limit: limit, total: total)).then((Response value) {
      return AlbumListWrap.fromJson(value.data);
    });
  }

  DioMetaData newAlbumListByAreaDioMetaData({String area = 'ALL', String type = "new", String year = "", String month = "", int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/discovery/new/albums/area'), data: params, options: joinOptions());
  }

  /// 新碟上架 筛选
  /// [area] ALL:全部,ZH:华语,EA:欧美,KR:韩国,JP:日本
  /// [type] new:全部 hot:热门,默认为 new
  /// [year] 年,默认本年
  /// [month] 月,默认本月
  Future<AlbumListWrap> newAlbumListByArea({String area = 'ALL', String type = "new", String year = "", String month = "", int offset = 0, int limit = 30}) {
    return Https.dioProxy.postUri(newAlbumListByAreaDioMetaData(area: area, type: type, year: year, month: month, offset: offset, limit: limit)).then((Response value) {
      return AlbumListWrap.fromJson(value.data);
    });
  }

  DioMetaData newestAlbumListDioMetaData() {
    return DioMetaData(joinUri('/api/discovery/newAlbum'), data: {}, options: joinOptions());
  }

  /// 最新专辑
  Future<AlbumListWrap> newestAlbumList() {
    return Https.dioProxy.postUri(newestAlbumListDioMetaData()).then((Response value) {
      return AlbumListWrap.fromJson(value.data);
    });
  }

  DioMetaData albumDetailDioMetaData(String albumId) {
    return DioMetaData(joinUri('/weapi/v1/album/$albumId'), data: {}, options: joinOptions());
  }

  /// 专辑详情
  Future<AlbumDetailWrap> albumDetail(String albumId) {
    return Https.dioProxy.postUri(albumDetailDioMetaData(albumId)).then((Response value) {
      return AlbumDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData albumDetailDynamicDioMetaData(String albumId) {
    var params = {'id': albumId};
    return DioMetaData(joinUri('/api/album/detail/dynamic'), data: params, options: joinOptions());
  }

  /// 专辑动态信息
  Future<AlbumDetailDynamicWrap> albumDetailDynamic(String albumId) {
    return Https.dioProxy.postUri(albumDetailDynamicDioMetaData(albumId)).then((Response value) {
      return AlbumDetailDynamicWrap.fromJson(value.data);
    });
  }
}
