import 'package:dio/dio.dart';
import '../../../src/api/uncategorized/bean.dart';
import '../../../src/dio_ext.dart';
import '../../../src/netease_handler.dart';

import 'bean.dart';

mixin ApiDj {
  DioMetaData djRadioBannerDioMetaData() {
    return DioMetaData(joinUri('/weapi/djradio/banner/get'),
        data: {}, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 电台banner
  Future<BannerListWrap2> djRadioBanner() {
    return Https.dioProxy
        .postUri(djRadioBannerDioMetaData())
        .then((Response value) {
      return BannerListWrap2.fromJson(value.data);
    });
  }

  DioMetaData djRadioCategoryDioMetaData() {
    return DioMetaData(joinUri('/weapi/djradio/category/get'),
        data: {}, options: joinOptions());
  }

  /// 电台 - 分类
  Future<DjRadioCategoryWrap> djRadioCategory() {
    return Https.dioProxy
        .postUri(djRadioCategoryDioMetaData())
        .then((Response value) {
      return DjRadioCategoryWrap.fromJson(value.data);
    });
  }

  DioMetaData recommendDjRadioCategoryDioMetaData() {
    return DioMetaData(joinUri('/weapi/djradio/home/category/recommend'),
        data: {}, options: joinOptions());
  }

  /// 电台 - 推荐分类
  Future<DjRadioCategoryWrap2> recommendDjRadioCategory() {
    return Https.dioProxy
        .postUri(recommendDjRadioCategoryDioMetaData())
        .then((Response value) {
      return DjRadioCategoryWrap2.fromJson(value.data);
    });
  }

  DioMetaData excludeHotDjRadioCategoryDioMetaData() {
    return DioMetaData(joinUri('/weapi/djradio/category/excludehot'),
        data: {}, options: joinOptions());
  }

  /// 电台 - 非热门分类
  Future<DjRadioCategoryWrap3> excludeHotDjRadioCategory() {
    return Https.dioProxy
        .postUri(excludeHotDjRadioCategoryDioMetaData())
        .then((Response value) {
      return DjRadioCategoryWrap3.fromJson(value.data);
    });
  }

  DioMetaData userDjRadioListDioMetaData(String userId) {
    var params = {'userId': userId};
    return DioMetaData(joinUri('/weapi/djradio/get/byuser'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 用户创建的电台
  Future<DjRadioListWrap> userDjRadioList(String userId) {
    return Https.dioProxy
        .postUri(userDjRadioListDioMetaData(userId))
        .then((Response value) {
      return DjRadioListWrap.fromJson(value.data);
    });
  }

  DioMetaData todayPreferredDjRadioListDioMetaData({int page = 0}) {
    var params = {'page': page};
    return DioMetaData(joinUri('/weapi/djradio/home/today/perfered'),
        data: params, options: joinOptions());
  }

  /// 今日优选电台
  /// Preferred perfered = =
  Future<DjRadioListWrap2> todayPreferredDjRadioList({int page = 0}) {
    return Https.dioProxy
        .postUri(todayPreferredDjRadioListDioMetaData(page: page))
        .then((Response value) {
      return DjRadioListWrap2.fromJson(value.data);
    });
  }

  DioMetaData recommendDjRadioListDioMetaData() {
    return DioMetaData(joinUri('/weapi/djradio/recommend/v1'),
        data: {}, options: joinOptions());
  }

  /// 精选电台
  Future<DjRadioListWrap> recommendDjRadioList() {
    return Https.dioProxy
        .postUri(recommendDjRadioListDioMetaData())
        .then((Response value) {
      return DjRadioListWrap.fromJson(value.data);
    });
  }

  DioMetaData recommendDjRadioListByCategoryDioMetaData(String cateId) {
    var params = {'cateId': cateId};
    return DioMetaData(joinUri('/weapi/djradio/recommend'),
        data: params, options: joinOptions());
  }

  /// 精选电台(分类)
  Future<DjRadioListWrap> recommendDjRadioListByCategory(String cateId) {
    return Https.dioProxy
        .postUri(recommendDjRadioListByCategoryDioMetaData(cateId))
        .then((Response value) {
      return DjRadioListWrap.fromJson(value.data);
    });
  }

  DioMetaData hotDjRadioListDioMetaData({int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/djradio/hot/v1'),
        data: params, options: joinOptions(cookies: {'os': 'pc'}));
  }

  /// 热门电台
  Future<DjRadioListWrap> hotDjRadioList({int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(hotDjRadioListDioMetaData(offset: offset, limit: limit))
        .then((Response value) {
      return DjRadioListWrap.fromJson(value.data);
    });
  }

  DioMetaData hotDjRadioListByCategoryDioMetaData(String cateId,
      {int offset = 0, int limit = 30}) {
    var params = {'cateId': cateId, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/djradio/hot'),
        data: params, options: joinOptions());
  }

  /// 热门电台（类别）
  Future<DjRadioListWrap> hotDjRadioListByCategory(String cateId,
      {int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(hotDjRadioListByCategoryDioMetaData(cateId,
            offset: offset, limit: limit))
        .then((Response value) {
      return DjRadioListWrap.fromJson(value.data);
    });
  }

  DioMetaData djRadioTopListDioMetaData(
      {String type = 'new', int offset = 0, int limit = 100}) {
    var params = {
      'type': type == 'new' ? 0 : 1,
      'limit': limit,
      'offset': offset
    };
    return DioMetaData(joinUri('/api/djradio/toplist'),
        data: params, options: joinOptions());
  }

  /// 新晋电台榜/热门电台榜
  /// [type] 新晋:'new'  热门:'hot'
  Future<DjRadioTopListListWrapX2> djRadioTopList(
      {String type = 'new', int offset = 0, int limit = 100}) {
    return Https.dioProxy
        .postUri(
            djRadioTopListDioMetaData(type: type, offset: offset, limit: limit))
        .then((Response value) {
      return DjRadioTopListListWrapX2.fromJson(value.data);
    });
  }

  DioMetaData djRadioPersonalizeDioMetaData({int limit = 6}) {
    var params = {
      'limit': limit,
    };
    return DioMetaData(joinUri('/api/djradio/personalize/rcmd'),
        data: params, options: joinOptions());
  }

  /// 新晋电台榜/热门电台榜
  /// [type] 新晋:'new'  热门:'hot'
  Future<DjRadioListWrap2> djRadioPersonalize({int limit = 6}) {
    return Https.dioProxy
        .postUri(djRadioPersonalizeDioMetaData(limit: limit))
        .then((Response value) {
      return DjRadioListWrap2.fromJson(value.data);
    });
  }

  DioMetaData djRadioPayTopListDioMetaData({int limit = 100}) {
    var params = {'limit': limit};
    return DioMetaData(joinUri('/api/djradio/toplist/pay'),
        data: params, options: joinOptions());
  }

  /// 电台 - 付费精品电台
  Future<DjRadioTopListListWrapX> djRadioPayTopList({int limit = 100}) {
    return Https.dioProxy
        .postUri(djRadioPayTopListDioMetaData(limit: limit))
        .then((Response value) {
      return DjRadioTopListListWrapX.fromJson(value.data);
    });
  }

  DioMetaData djRadioPayGiftTopListDioMetaData(
      {int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/djradio/home/paygift/list?_nmclfl=1'),
        data: params, options: joinOptions());
  }

  /// 电台 - 付费精选
  Future<DjRadioTopListListWrapX> djRadioPayGiftTopList(
      {int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(djRadioPayGiftTopListDioMetaData(offset: offset, limit: limit))
        .then((Response value) {
      return DjRadioTopListListWrapX.fromJson(value.data);
    });
  }

  DioMetaData djRadioDetailDioMetaData(String radioId) {
    var params = {'id': radioId};
    return DioMetaData(joinUri('/api/djradio/v2/get'),
        data: params, options: joinOptions());
  }

  /// 电台 - 详情
  Future<DjRadioDetail> djRadioDetail(String radioId) {
    return Https.dioProxy
        .postUri(djRadioDetailDioMetaData(radioId))
        .then((Response value) {
      return DjRadioDetail.fromJson(value.data);
    });
  }

  DioMetaData djProgramListDioMetaData(String radioId,
      {int offset = 0, int limit = 30, bool asc = true}) {
    var params = {
      'radioId': radioId,
      'limit': limit,
      'offset': offset,
      'asc': asc
    };
    return DioMetaData(joinUri('/weapi/dj/program/byradio'),
        data: params, options: joinOptions());
  }

  /// 电台 - 节目列表
  Future<DjProgramListWrap> djProgramList(String radioId,
      {int offset = 0, int limit = 30, bool asc = true}) {
    return Https.dioProxy
        .postUri(djProgramListDioMetaData(radioId,
            offset: offset, limit: limit, asc: asc))
        .then((Response value) {
      return DjProgramListWrap.fromJson(value.data);
    });
  }

  DioMetaData djProgramHoursTopListDioMetaData({int limit = 100}) {
    var params = {'limit': limit};
    return DioMetaData(joinUri('/api/djprogram/toplist/hours'),
        data: params, options: joinOptions());
  }

  /// 电台 - 24小时节目榜
  Future<DjProgramTopListListWrapX> djProgramHoursTopList({int limit = 100}) {
    return Https.dioProxy
        .postUri(djProgramHoursTopListDioMetaData(limit: limit))
        .then((Response value) {
      return DjProgramTopListListWrapX.fromJson(value.data);
    });
  }

  DioMetaData userDjProgramsListDioMetaData(String userId,
      {int offset = 0, int limit = 30}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/dj/program/$userId'),
        data: params, options: joinOptions());
  }

  /// 用户电台节目列表
  Future<DjProgramListWrap> userDjProgramsList(String userId,
      {int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(
            userDjProgramsListDioMetaData(userId, offset: offset, limit: limit))
        .then((Response value) {
      return DjProgramListWrap.fromJson(value.data);
    });
  }

  DioMetaData djProgramsTopListDioMetaData({int offset = 0, int limit = 100}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/program/toplist/v1'),
        data: params, options: joinOptions());
  }

  /// 电台节目排行榜
  Future<DjProgramTopListListWrap2> djProgramsTopList(
      {int offset = 0, int limit = 100}) {
    return Https.dioProxy
        .postUri(djProgramsTopListDioMetaData(offset: offset, limit: limit))
        .then((Response value) {
      return DjProgramTopListListWrap2.fromJson(value.data);
    });
  }

  DioMetaData personalizedProgramDjListDioMetaData() {
    return DioMetaData(joinUri('/weapi/personalized/djprogram'),
        data: {}, options: joinOptions());
  }

  /// 推荐电台节目
  Future<PersonalizedDjProgramListWrap> personalizedProgramDjList() {
    return Https.dioProxy
        .postUri(personalizedProgramDjListDioMetaData())
        .then((Response value) {
      return PersonalizedDjProgramListWrap.fromJson(value.data);
    });
  }

  DioMetaData recommendDjProgramListDioMetaData(
      {String cateId = '', int offset = 0, int limit = 30}) {
    var params = {'cateId': cateId, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/program/recommend/v1'),
        data: params, options: joinOptions());
  }

  /// 推荐节目
  Future<DjProgramListWrap> recommendDjProgramList(
      {String cateId = '', int offset = 0, int limit = 30}) {
    return Https.dioProxy
        .postUri(recommendDjProgramListDioMetaData(
            cateId: cateId, offset: offset, limit: limit))
        .then((Response value) {
      return DjProgramListWrap.fromJson(value.data);
    });
  }

  DioMetaData djProgramDetailDioMetaData(String programId) {
    var params = {'id': programId};
    return DioMetaData(joinUri('/weapi/dj/program/detail'),
        data: params, options: joinOptions());
  }

  /// 节目详情
  Future<DjProgramDetail> djProgramDetail(String programId) {
    return Https.dioProxy
        .postUri(djProgramDetailDioMetaData(programId))
        .then((Response value) {
      return DjProgramDetail.fromJson(value.data);
    });
  }

  DioMetaData djHoursTopListDioMetaData({int limit = 100}) {
    var params = {'limit': limit};
    return DioMetaData(joinUri('/api/dj/toplist/hours'),
        data: params, options: joinOptions());
  }

  /// 电台 - 24小时主播榜
  Future<DjTopListListWrapX> djHoursTopList({int limit = 100}) {
    return Https.dioProxy
        .postUri(djHoursTopListDioMetaData(limit: limit))
        .then((Response value) {
      return DjTopListListWrapX.fromJson(value.data);
    });
  }

  DioMetaData djNewcomerTopListDioMetaData({int offset = 0, int limit = 100}) {
    var params = {'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/dj/toplist/newcomer'),
        data: params, options: joinOptions());
  }

  /// 电台 - 新人榜
  Future<DjTopListListWrapX> djNewcomerTopList(
      {int offset = 0, int limit = 100}) {
    return Https.dioProxy
        .postUri(djNewcomerTopListDioMetaData(offset: offset, limit: limit))
        .then((Response value) {
      return DjTopListListWrapX.fromJson(value.data);
    });
  }

  DioMetaData djPopularTopListDioMetaData({int limit = 100}) {
    var params = {'limit': limit};
    return DioMetaData(joinUri('/api/dj/toplist/popular'),
        data: params, options: joinOptions());
  }

  /// 电台 - 最热主播榜
  Future<DjTopListListWrapX> djPopularTopList({int limit = 100}) {
    return Https.dioProxy
        .postUri(djPopularTopListDioMetaData(limit: limit))
        .then((Response value) {
      return DjTopListListWrapX.fromJson(value.data);
    });
  }
}
