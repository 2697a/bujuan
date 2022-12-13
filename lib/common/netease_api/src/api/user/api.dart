import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../netease_music_api.dart';
import '../../../src/api/bean.dart';
import '../../../src/dio_ext.dart';
import '../../../src/netease_handler.dart';

mixin ApiUser {
  DioMetaData userSettingDioMetaData() {
    return DioMetaData(joinUri('/api/user/setting'),
        data: {}, options: joinOptions());
  }

  /// 用户设置
  /// !需要登录
  Future<UserSettingWrap> userSetting() {
    return Https.dioProxy
        .postUri(userSettingDioMetaData())
        .then((Response value) {
      return UserSettingWrap.fromJson(value.data);
    });
  }

  DioMetaData userBindingsDioMetaData(String userId) {
    return DioMetaData(joinUri('/api/v1/user/bindings/$userId'),
        data: {}, options: joinOptions());
  }

  /// 用户账号信息
  /// !需要登录
  Future<NeteaseAccountBindingWrap> userBindings(String userId) {
    return Https.dioProxy
        .postUri(userBindingsDioMetaData(userId))
        .then((Response value) {
      return NeteaseAccountBindingWrap.fromJson(value.data);
    });
  }

  DioMetaData userDetailDioMetaData(String userId) {
    return DioMetaData(joinUri('/weapi/v1/user/detail/$userId'),
        data: {}, options: joinOptions());
  }

  /// 获取用户详情
  /// !需要登录
  Future<NeteaseUserDetail> userDetail(String userId) {
    return Https.dioProxy
        .postUri(userDetailDioMetaData(userId))
        .then((Response value) {
      return NeteaseUserDetail.fromJson(value.data);
    });
  }

  DioMetaData userSubcountDioMetaData() {
    return DioMetaData(joinUri('/weapi/subcount'),
        data: {}, options: joinOptions());
  }

  /// 获取用户信息 , 歌单，收藏，mv, dj 数量
  /// !需要登录
  Future<NeteaseUserSubcount> userSubcount() {
    return Https.dioProxy
        .postUri(userSubcountDioMetaData())
        .then((Response value) {
      return NeteaseUserSubcount.fromJson(value.data);
    });
  }

  DioMetaData userLevelDioMetaData() {
    return DioMetaData(joinUri('/weapi/user/level'),
        data: {}, options: joinOptions());
  }

  /// 用户等级信息
  /// 可以获取用户等级信息,包含当前登陆天数,听歌次数,下一等级需要的登录天数和听歌次数,当前等级进度,对应 https://music.163.com/#/user/level
  /// !需要登录
  Future<NeteaseUserLevelWrap> userLevel() {
    return Https.dioProxy
        .postUri(userLevelDioMetaData())
        .then((Response value) {
      return NeteaseUserLevelWrap.fromJson(value.data);
    });
  }

  DioMetaData userUpdateProfileDioMetaData(int gender, int birthday,
      String nickname, int province, int city, String signature,
      {String avatarImgId = '0'}) {
    var params = {
      'avatarImgId': avatarImgId,
      'gender': gender,
      'birthday': birthday,
      'nickname': nickname,
      'province': province,
      'city': city,
      'signature': signature
    };
    return DioMetaData(joinUri('/weapi/user/profile/update'),
        data: params, options: joinOptions());
  }

  /// 更新用户信息
  /// !需要登录
  /// [gender] 性别 0:保密 1:男性 2:女性 !必须
  /// [birthday] 出生日期,时间戳 unix timestamp !必须
  /// [nickname] 用户昵称 !必须
  /// [province] 省份id !必须
  /// [city] 城市id !必须
  /// [signature] 用户签名 !必须
  /// [avatarImgId] 头像id
  Future<ServerStatusBean> userUpdateProfile(int gender, int birthday,
      String nickname, int province, int city, String signature,
      {String avatarImgId = '0'}) {
    return Https.dioProxy
        .postUri(userUpdateProfileDioMetaData(
            gender, birthday, nickname, province, city, signature,
            avatarImgId: avatarImgId))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData userUpdateProfileAvatarDioMetaData(String imgid) {
    var params = {'imgid': imgid};
    return DioMetaData(joinUri('/weapi/user/avatar/upload/v1'),
        data: params, options: joinOptions());
  }

  /// 更新用户信息-头像
  /// !需要登录
  Future<ServerStatusBean> userUpdateProfileAvatar(String path,
      {int imgSize = 300, int imgX = 0, int imgY = 0}) async {
    var result = await NeteaseMusicApi()
        .uploadImage(path, imgSize: imgSize, imgX: imgX, imgY: imgY);

    return Https.dioProxy
        .postUri(userUpdateProfileAvatarDioMetaData(result.id))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData userPlayListDioMetaData(String userId,
      {int offset = 0, int limit = 30}) {
    var params = {'uid': userId, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/user/playlist'),
        data: params, options: joinOptions());
  }

  /// 获取用户歌单
  /// !需要登录
  Future<MultiPlayListWrap2> userPlayList(String userId,
      {int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(userPlayListDioMetaData(userId, offset: offset, limit: limit))
        .then((Response value) {
      return MultiPlayListWrap2.fromJson(value.data);
    });
  }

  DioMetaData updateUserPlayListInfoDioMetaData(
      String id, String name, String desc, List<String> tags) {
    var params = {
      '/api/playlist/update/name': '{"id": "$id", "name": "$name"}',
      '/api/playlist/desc/update': '{"id": "$id", "desc": "$desc"}',
      '/api/playlist/tags/update': '{"id": "$id", "tags": "${tags.join(',')}"}'
    };
    return DioMetaData(joinUri('/weapi/batch'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 更新用户歌单信息
  /// !需要登录
  /// [name] 歌单名字
  /// [desc] 歌单描述
  /// [tags] 歌单tag ,多个用 `;` 隔开,只能用官方规定标签
  Future<ServerStatusBean> updateUserPlayListInfo(
      String id, String name, String desc, List<String> tags) {
    return Https.dioProxy
        .postUri(updateUserPlayListInfoDioMetaData(id, name, desc, tags))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData updateUserPlayListDescDioMetaData(String id, String desc) {
    var params = {'id': id, 'desc': desc};
    return DioMetaData(joinUri('/eapi/playlist/desc/update'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/playlist/desc/update'));
  }

  /// 更新用户歌单描述
  /// !需要登录
  /// [desc] 歌单描述
  Future<ServerStatusBean> updateUserPlayListDesc(String id, String desc) {
    return Https.dioProxy
        .postUri(updateUserPlayListDescDioMetaData(id, desc))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData updateUserPlayListNameDioMetaData(String id, String name) {
    var params = {'id': id, 'name': name};
    return DioMetaData(joinUri('/eapi/playlist/update/name'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/playlist/update/name'));
  }

  /// 更新用户歌单描述
  /// !需要登录
  /// [name] 歌单名字
  Future<ServerStatusBean> updateUserPlayListName(String id, String name) {
    return Https.dioProxy
        .postUri(updateUserPlayListNameDioMetaData(id, name))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData updateUserPlayListTagsDioMetaData(String id, List<String> tags) {
    var params = {'id': id, 'tags': tags.join(',')};
    return DioMetaData(joinUri('/eapi/playlist/tags/update'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi,
            eApiUrl: '/api/playlist/tags/update'));
  }

  /// 更新用户歌单描述
  /// !需要登录
  /// [tags] 歌单标签
  Future<ServerStatusBean> updateUserPlayListTags(
      String id, List<String> tags) {
    return Https.dioProxy
        .postUri(updateUserPlayListTagsDioMetaData(id, tags))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData userFollowListDioMetaData(String userId,
      {int offset = 0, int limit = 30, bool order = true}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/user/getfollows/$userId'),
        data: params, options: joinOptions());
  }

  /// 获取用户关注列表
  /// !需要登录
  Future<UserFollowListWrap> userFollowList(String userId,
      {int offset = 0, int limit = 30, bool order = true}) {
    return Https.dioProxy
        .postUri(userFollowListDioMetaData(userId,
            offset: offset, limit: limit, order: order))
        .then((Response value) {
      return UserFollowListWrap.fromJson(value.data);
    });
  }

  DioMetaData userSignDioMetaData({String clientType = 'android'}) {
    var params = {'type': clientType == 'android' ? 0 : 1};
    return DioMetaData(joinUri('/weapi/point/dailyTask'),
        data: params, options: joinOptions());
  }

  /// 用户签到
  /// !需要登录
  /// [clientType] android web
  /// 0为安卓端签到 3点经验, 1为网页签到,2点经验
  Future<ServerStatusBean> userSign({String clientType = 'android'}) {
    return Https.dioProxy
        .postUri(userSignDioMetaData(clientType: clientType))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData userFollowedListDioMetaData(String userId,
      {int limit = 30, int lastTime = -1}) {
    var params = {'userId': userId, 'time': lastTime, 'limit': limit};
    return DioMetaData(joinUri('/eapi/user/getfolloweds/$userId'),
        data: params,
        options: joinOptions(
            encryptType: EncryptType.EApi, eApiUrl: '/api/user/getfolloweds'));
  }

  /// 获取用户粉丝列表
  /// !需要登录
  /// [lastTime] 传入上一次返回结果的 lasttime,将会返回下一页的数据,默认-1
  Future<UserFollowedListWrap> userFollowedList(String userId,
      {int limit = 30, int lastTime = -1}) {
    return Https.dioProxy
        .postUri(userFollowedListDioMetaData(userId,
            limit: limit, lastTime: lastTime))
        .then((Response value) {
      return UserFollowedListWrap.fromJson(value.data);
    });
  }

  DioMetaData userFollowDioMetaData(String userId, bool follow) {
    return DioMetaData(
        joinUri('/weapi/user/${follow ? 'follow' : 'delfollow'}/$userId'),
        data: {},
        options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 关注/取消关注用户
  /// !需要登录
  Future<ServerStatusBean> userFollow(String userId, bool follow) {
    return Https.dioProxy
        .postUri(userFollowDioMetaData(userId, follow))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData artistSubDioMetaData(String artistId, bool sub) {
    // 批量?
    var params = {'artistId': artistId, 'artistIds': '[$artistId]'};
    return DioMetaData(joinUri('/weapi/artist/${sub ? 'sub' : 'unsub'}'),
        data: params, options: joinOptions());
  }

  /// 收藏/取消收藏歌手
  /// !需要登录
  Future<ServerStatusBean> artistSub(String artistId, bool sub) {
    return Https.dioProxy
        .postUri(artistSubDioMetaData(artistId, sub))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData artistSubListDioMetaData(
      {bool total = true, int offset = 0, int limit = 30}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/artist/sublist'),
        data: params, options: joinOptions());
  }

  /// 收藏的歌手列表
  /// !需要登录
  Future<ArtistsSubListWrap> artistSubList(
      {bool total = true, int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(artistSubListDioMetaData(
            total: total, offset: offset, limit: limit))
        .then((Response value) {
      return ArtistsSubListWrap.fromJson(value.data);
    });
  }

  DioMetaData djRadioSubDioMetaData(String radioId, bool sub) {
    var params = {'id': radioId};
    return DioMetaData(joinUri('/weapi/djradio/${sub ? 'sub' : 'unsub'}'),
        data: params, options: joinOptions());
  }

  /// 订阅与取消电台
  /// !需要登录
  Future<ServerStatusBean> djRadioSub(String radioId, bool sub) {
    return Https.dioProxy
        .postUri(djRadioSubDioMetaData(radioId, sub))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData djRadioSubListDioMetaData(
      {bool total = true, int offset = 0, int limit = 30}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/djradio/get/subed'),
        data: params, options: joinOptions());
  }

  /// 收藏的电台列表
  /// !需要登录
  Future<DjRadioListWrap> djRadioSubList(
      {bool total = true, int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(djRadioSubListDioMetaData(
            offset: offset, limit: limit, total: total))
        .then((Response value) {
      return DjRadioListWrap.fromJson(value.data);
    });
  }

  DioMetaData videoSubDioMetaData(String videoId, bool sub) {
    var params = {'id': videoId};
    return DioMetaData(
        joinUri('/weapi/cloudvideo/video/${sub ? 'sub' : 'unsub'}'),
        data: params,
        options: joinOptions());
  }

  /// 收藏/取消视频
  /// !需要登录
  Future<ServerStatusBean> videoSub(String videoId, bool sub) {
    return Https.dioProxy
        .postUri(videoSubDioMetaData(videoId, sub))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData mvSubDioMetaData(String mvId, bool sub) {
    // 批量?
    var params = {'mvId': mvId, 'mvIds': '[$mvId]'};
    return DioMetaData(joinUri('/weapi/mv/${sub ? 'sub' : 'unsub'}'),
        data: params, options: joinOptions());
  }

  /// 收藏/取消收藏 MV
  /// !需要登录
  Future<ServerStatusBean> mvSub(String mvId, bool sub) {
    return Https.dioProxy
        .postUri(mvSubDioMetaData(mvId, sub))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData mvSubListDioMetaData(
      {bool total = true, int offset = 0, int limit = 30}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/cloudvideo/allvideo/sublist'),
        data: params, options: joinOptions());
  }

  /// 收藏的 MV 列表
  /// !需要登录
  Future<MvSubListWrap> mvSubList(
      {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(
            mvSubListDioMetaData(offset: offset, limit: limit, total: total))
        .then((Response value) {
      return MvSubListWrap.fromJson(value.data);
    });
  }

  DioMetaData userPlayRecordListDioMetaData(String userId, bool weekData) {
    var params = {
      'uid': userId,
      // 1: 最近一周, 0: 所有时间
      'type': weekData ? '1' : '0'
    };
    return DioMetaData(joinUri('/weapi/v1/play/record'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 获取用户播放记录
  /// !需要登录
  Future<PlayRecordListWrap> userPlayRecordList(String userId, bool weekData) {
    return Https.dioProxy
        .postUri(userPlayRecordListDioMetaData(userId, weekData))
        .then((Response value) {
      return PlayRecordListWrap.fromJson(value.data);
    });
  }

  DioMetaData albumSubDioMetaData(String albumId, bool sub) {
    var params = {'id': albumId};
    return DioMetaData(joinUri('/api/album/${sub ? 'sub' : 'unsub'}'),
        data: params, options: joinOptions());
  }

  /// 收藏/取消收藏 歌单
  /// !需要登录
  Future<ServerStatusBean> albumSub(String albumId, bool sub) {
    return Https.dioProxy
        .postUri(albumSubDioMetaData(albumId, sub))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData albumSubListDioMetaData(
      {bool total = true, int offset = 0, int limit = 30}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/album/sublist'),
        data: params, options: joinOptions());
  }

  /// 收藏的 专辑 列表
  /// !需要登录
  Future<AlbumSubListWrap> albumSubList(
      {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(
            albumSubListDioMetaData(offset: offset, limit: limit, total: total))
        .then((Response value) {
      return AlbumSubListWrap.fromJson(value.data);
    });
  }

  DioMetaData playlistSubDioMetaData(String pid, bool sub) {
    var params = {'id': pid};
    return DioMetaData(
        joinUri('/weapi/playlist/${sub ? 'subscribe' : 'unsubscribe'}'),
        data: params,
        options: joinOptions());
  }

  /// 收藏/取消收藏 歌单
  /// !需要登录
  Future<ServerStatusBean> playlistSub(String pid, bool sub) {
    return Https.dioProxy
        .postUri(playlistSubDioMetaData(pid, sub))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData playlistCreateDioMetaData(String name, bool privacy) {
    var params = {'name': name, 'privacy': privacy ? '10' : '0'};
    return DioMetaData(joinUri('/weapi/playlist/create'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 新建歌单
  /// !需要登录
  /// [name] 歌单名
  /// [privacy] 是否私密
  Future<PlaylistCreateWrap> playlistCreate(String name, bool privacy) {
    return Https.dioProxy
        .postUri(playlistCreateDioMetaData(name, privacy))
        .then((Response value) {
      return PlaylistCreateWrap.fromJson(value.data);
    });
  }

  DioMetaData playlistDeleteDioMetaData(List<String> pids) {
    var params = {'ids': jsonEncode(pids)};
    return DioMetaData(joinUri('/weapi/playlist/remove'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  DioMetaData playlistUpdateCoverDioMetaData(String pid, String coverImgId) {
    var params = {'id': pid, 'coverImgId': coverImgId};
    return DioMetaData(joinUri('/weapi/playlist/cover/update'),
        data: params, options: joinOptions());
  }

  /// 更新用户信息-头像
  /// !需要登录
  Future<ServerStatusBean> playlistUpdateCover(String pid, String path,
      {int imgSize = 300, int imgX = 0, int imgY = 0}) async {
    var result = await NeteaseMusicApi()
        .uploadImage(path, imgSize: imgSize, imgX: imgX, imgY: imgY);

    return Https.dioProxy
        .postUri(playlistUpdateCoverDioMetaData(pid, result.id))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  /// 删除歌单
  /// !需要登录
  Future<ServerStatusBean> playlistDelete(List<String> pids) {
    return Https.dioProxy
        .postUri(playlistDeleteDioMetaData(pids))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData playlistUpdateOrderDioMetaData(List<String> pids) {
    var params = {'ids': jsonEncode(pids)};
    return DioMetaData(joinUri('/api/playlist/order/update'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 编辑歌单顺序
  /// !需要登录
  Future<ServerStatusBean> playlistUpdateOrder(List<String> pids) {
    return Https.dioProxy
        .postUri(playlistUpdateOrderDioMetaData(pids))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData playlistManipulateTracksDioMetaData(
      String pid, String trackId, bool add) {
    // 批量?
    var params = {
      'op': add ? 'add' : 'del',
      'pid': pid,
      'trackIds': '[$trackId]'
    };
    return DioMetaData(joinUri('/weapi/playlist/manipulate/tracks'),
        data: params, options: joinOptions());
  }

  /// 收藏单曲到歌单 从歌单删除歌曲
  /// !需要登录
  Future<ServerStatusBean> playlistManipulateTracks(
      String pid, String trackId, bool add) {
    return Https.dioProxy
        .postUri(playlistManipulateTracksDioMetaData(pid, trackId, add))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData orderingDigitalAlbumDioMetaData(String albumId,
      {int payment = 3, int quantity = 1}) {
    var params = {
      'business': 'Album',
      'paymentMethod': payment,
      'digitalResources': jsonEncode([
        {
          'business': 'Album',
          'resourceID': albumId,
          'quantity': quantity,
        }
      ]),
      'from': 'web'
    };
    return DioMetaData(joinUri('/api/ordering/web/digital'),
        data: params, options: joinOptions());
  }

  /// 购买数字专辑
  /// [payment] 支付方式，0 为支付宝 3 为微信
  /// TODO 账号没有这类数据，补充数据结构
  Future<ServerStatusBean> orderingDigitalAlbum(String albumId,
      {int payment = 3, int quantity = 1}) {
    return Https.dioProxy
        .postUri(orderingDigitalAlbumDioMetaData(albumId,
            payment: payment, quantity: quantity))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }

  DioMetaData purchasedDigitalAlbumDioMetaData(
      {bool total = true, int offset = 0, int limit = 30}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/digitalAlbum/purchased'),
        data: params, options: joinOptions());
  }

  /// 我的数字专辑
  /// TODO 账号没有这类数据，补充数据结构  paidAlbums
  Future<ServerStatusBean> purchasedDigitalAlbum(
      {int offset = 0, int limit = 30, bool total = true}) {
    return Https.dioProxy
        .postUri(purchasedDigitalAlbumDioMetaData(
            offset: offset, limit: limit, total: total))
        .then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }
}
