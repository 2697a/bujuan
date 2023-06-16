import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../../../src/api/bean.dart';
import '../../../src/api/uncategorized/bean.dart';
import '../../../src/dio_ext.dart';
import '../../../src/netease_handler.dart';

mixin ApiUncategorized {
  DioMetaData homeBannerListDioMetaData({String clientType = 'android'}) {
    var params = {'clientType': clientType};
    return DioMetaData(joinUri('/api/v2/banner/get'), data: params, options: joinOptions(encryptType: EncryptType.WeApi));
  }

  /// 首页轮播图
  /// [clientType] pc android iphone ipad
  Future<BannerListWrap> homeBannerList({String clientType = 'android'}) {
    return Https.dioProxy.postUri(homeBannerListDioMetaData(clientType: clientType)).then((Response value) {
      return BannerListWrap.fromJson(value.data);
    });
  }

  DioMetaData homeBlockPageDioMetaData({bool refresh = true, String cursor = ''}) {
    var params = {"refresh": refresh, "cursor": cursor};
    return DioMetaData(joinUri('/api/homepage/block/page'), data: params, options: joinOptions());
  }

  /// 首页-发现 block page
  Future<HomeBlockPageWrap> homeBlockPage({bool refresh = true, String cursor = ''}) {
    return Https.dioProxy.postUri(homeBlockPageDioMetaData(refresh: refresh)).then((Response value) {
      return HomeBlockPageWrap.fromJson(value.data);
    });
  }

  DioMetaData homeDragonBallStaticDioMetaData() {
    return DioMetaData(joinUri('/api/homepage/dragon/ball/static'), data: {}, options: joinOptions(eApiUrl: '/api/homepage/dragon/ball/static', encryptType: EncryptType.EApi));
  }

  /// 首页-发现 dragon ball
  /// !需要登录或者匿名登录
  Future<HomeDragonBallWrap> homeDragonBallStatic() {
    return Https.dioProxy.postUri(homeDragonBallStaticDioMetaData()).then((Response value) {
      return HomeDragonBallWrap.fromJson(value.data);
    });
  }

  DioMetaData countriesCodeListDioMetaData() {
    return DioMetaData(Uri.parse('http://interface3.music.163.com/eapi/lbs/countries/v1'),
        data: {}, options: joinOptions(encryptType: EncryptType.EApi, eApiUrl: '/api/lbs/countries/v1'));
  }

  /// 国家编码列表
  Future<CountriesCodeListWrap> countriesCodeList() {
    return Https.dioProxy.postUri(countriesCodeListDioMetaData()).then((Response value) {
      return CountriesCodeListWrap.fromJson(value.data);
    });
  }

  DioMetaData personalizedPrivateContentDioMetaData() {
    return DioMetaData(joinUri('/weapi/personalized/privatecontent'), data: {}, options: joinOptions());
  }

  /// 独家放送推荐
  Future<PersonalizedPrivateContentListWrap> personalizedPrivateContent() {
    return Https.dioProxy.postUri(personalizedPrivateContentDioMetaData()).then((Response value) {
      return PersonalizedPrivateContentListWrap.fromJson(value.data);
    });
  }

  DioMetaData personalizedPrivateContentListDioMetaData({int offset = 0, int limit = 60, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/api/v2/privatecontent/list'), data: params, options: joinOptions());
  }

  /// 独家放送列表
  Future<PersonalizedPrivateContentListWrap> personalizedPrivateContentList({int offset = 0, int limit = 60, bool total = true}) {
    return Https.dioProxy.postUri(personalizedPrivateContentListDioMetaData(offset: offset, limit: limit, total: total)).then((Response value) {
      return PersonalizedPrivateContentListWrap.fromJson(value.data);
    });
  }

  DioMetaData topListDioMetaData() {
    return DioMetaData(joinUri('/api/toplist'), data: {}, options: joinOptions(encryptType: EncryptType.WeApi));
  }

  /// 所有榜单内容摘要
  Future<TopListWrap> topList() {
    return Https.dioProxy.postUri(topListDioMetaData()).then((Response value) {
      return TopListWrap.fromJson(value.data);
    });
  }

  DioMetaData topListDetailDioMetaData() {
    return DioMetaData(joinUri('/weapi/toplist/detail'), data: {}, options: joinOptions());
  }

  /// 所有榜单详情
  Future<TopListDetailWrap> topListDetail() {
    return Https.dioProxy.postUri(topListDetailDioMetaData()).then((Response value) {
      return TopListDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData mcalendarDetailDioMetaData({int startTime = 0, int endTime = 0}) {
    if (startTime == 0) {
      startTime = DateTime.now().millisecondsSinceEpoch;
    }
    if (endTime == 0) {
      endTime = DateTime.now().millisecondsSinceEpoch;
    }
    var params = {
      'startTime': startTime,
      'endTime': endTime,
    };
    return DioMetaData(joinUri('/api/mcalendar/detail'), data: params, options: joinOptions());
  }

  /// mcalendar
  Future<McalendarDetailWrap> mcalendarDetail({int startTime = 0, int endTime = 0}) {
    return Https.dioProxy.postUri(mcalendarDetailDioMetaData()).then((Response value) {
      return McalendarDetailWrap.fromJson(value.data);
    });
  }

  DioMetaData audioMatchDioMetaData({String? algorithmCode, int? times, String? sessionId, double? duration, String? from, String? rawdata}) {
    var params = {
      'algorithmCode': algorithmCode,
      'times': times,
      'sessionId': sessionId,
      'duration': duration,
      'from': from,
      'rawdata': rawdata,
    };
    return DioMetaData(joinUri('/api/music/audio/match'), data: params, options: joinOptions());
  }

  /// audio match
  Future<AudioMatchResultWrap> audioMatch(
      {String algorithmCode = 'shazam_v2',
      int times = 1,
      String sessionId = 'C999431ACDC84EDBB984763654E6F8D7',
      double duration = 3.3066249999999995,
      String from = 'recognize-song',
      String rawdata =
          'eJx10mtIU2EcBvDtnCwNMfO2klUSmSQ5ZugKW/v/0TIjJVdhDStbXpqXrhY5Kwhtrcwiut9VSqMUMxX6IFqsD92sD1YgWGHRBcowKrpnPa/v+drg4flt572ds2PQ6XQut7MwJ940w2TOyS0pzF+/BV/MJrNO+3TVLOHUzKx5iw3/H5uZ7yxegct3tTl7Cr6QEa0gZ/dZOFsvfe5YHe1D+yFZxpncqEj/cCdwoirdVxHNnZrX3xygU5g7Eh6I9uOx8Ch4y9FQjlKkDz1pYrFXIJLUOovFGcYivqJgXqaXDqu7Rzc0XzmZxG81B/fF8wRVusn2jN5rDnwca8tFhyAJP4L4qiI9vX8cWzEmVKzT/46qxNpIdZOZz2HNcHhSkZ3D4AjYFpfGFkX6+dB+FvcSBe/SWbkLPVnEOJ1DFelXxVVci/Wj4TsBLhrQ/LGoaU4HxsTA28L76Cc8Dfau/U6F6FgkyBDDJar0g8tesmOvOHioWeXXmme6l3MLbIIre6wciU5E2t/k8WVxHfHvuUWXsH4SPCv1NW1Cz0aivgYO34vw1AEvi3MlIw0xHl6JNVPEGW41UJsqPaXYYTuEnotMdHwYfv7CFR/i+aXmrY5wrlSkEwr+0EJ0GvLmdw4/RS9Amj93UAbGZMIF40ezE3PtcG/yBWrT3L6oh66hFyMXK4xsUKT7aufzapxnFTwiNc3Wis5Bdm+OYCvmOuHj/ZeoQPOI00PUrUjXpG+kMFU61tFFDvQaZOn5DH4mzoLw4Hsaj14rzu/K4jF66fSWTnJinW3wBvcveqjZN3iFjKp0qKuF1mi21keST3NtTcbwu1eG3Dussr9eemljLIco0tVH7HwA493wOr+FlIjfy+GvkR4uwfjt4v/6G8K3NX8K38lt6B1ISa+Bv2O8Fy69foZOovci2S4Lr1aku4P9OEWVTt9wgMQ7exgJ8JXyI0W694WFyuBjcH75XyrEXsfhg+ZSvqZIf/Lct8Wp0md2tJN4PifEfjcm8gu02Ptbj459eum8eg8bFWlLXTb/A+uo9bM='}) {
    return Https.dioProxy
        .postUri(audioMatchDioMetaData(algorithmCode: algorithmCode, times: times, sessionId: sessionId, duration: duration, from: from, rawdata: rawdata))
        .then((Response value) {
      return AudioMatchResultWrap.fromJson(value.data);
    });
  }

  DioMetaData listenTogetherStatusDioMetaData() {
    return DioMetaData(joinUri('/api/listen/together/status/get'), data: {}, options: joinOptions());
  }

  /// 一起听状态
  /// !需要登录
  Future<ListenTogetherStatusWrap> listenTogetherStatus() {
    return Https.dioProxy.postUri(listenTogetherStatusDioMetaData()).then((Response value) {
      return ListenTogetherStatusWrap.fromJson(value.data);
    });
  }

  /// 申请图片空间
  DioMetaData uploadAllocDioMetaData(String fileName, {String bucket = '', String ext = '', int nosProduct = 0, String type = ''}) {
    var params = {
      'bucket': bucket,
      'ext': ext,
      'filename': fileName,
      'local': false,
      'nos_product': nosProduct,
      'return_body': '{"code": 200, "size": "\$(ObjectSize)"}',
      'type': type
    };
    return DioMetaData(joinUri('/weapi/nos/token/alloc'), data: params, options: joinOptions());
  }

  /// 生成最终图片地址
  DioMetaData uploadImageResultDioMetaData(docId, {int imgSize = 300, int imgX = 0, int imgY = 0}) {
    return DioMetaData(joinUri('/upload/img/op?id=$docId&op=${imgX}y${imgY}y${imgSize}y$imgSize'), data: {}, options: joinOptions());
  }

  /// 图片上传
  /// !需要登录
  Future<UploadImageResult> uploadImage(String path, {int imgSize = 300, int imgX = 0, int imgY = 0}) async {
    String fileName = path.split('/').last;

    var res = await Https.dioProxy.postUri(uploadAllocDioMetaData(fileName, bucket: 'yyimgs', ext: 'jpg', nosProduct: 0, type: 'other')).then((Response value) {
      return UploadImageAllocWrap.fromJson(value.data);
    });

    var formData = File(path).openRead();

    await Https.dio.post("https://nosup-hz1.127.net/yyimgs/${res.result.objectKey}?offset=0&complete=true&version=1.0",
        data: formData, options: Options(contentType: 'image/jpeg', headers: {'x-nos-token': res.result.token}));

    return Https.dioProxy.postUri(uploadImageResultDioMetaData(res.result.docId, imgSize: imgSize, imgX: imgX, imgY: imgY)).then((Response value) {
      return UploadImageResult.fromJson(value.data);
    });
  }

  /// 歌曲上传
  /// !需要登录
  Future<dynamic> uploadSong(String path) async {
    String fileName = path.split('/').last;

    var res = await Https.dioProxy.postUri(uploadAllocDioMetaData(fileName, bucket: '', ext: 'mp3', nosProduct: 3, type: 'audio')).then((Response value) {
      return UploadImageAllocWrap.fromJson(value.data);
    });

    var file = File(path);
    var formData = file.openRead();

    return await Https.dio
        .post("http://45.127.129.8/ymusic/${Uri.encodeComponent(res.result.objectKey)}?offset=0&complete=true&version=1.0",
            data: formData,
            options: Options(contentType: 'audio/mpeg', headers: {
              'x-nos-token': res.result.token,
              'Content-Length': file.lengthSync().toString(),
            }))
        .then((Response value) {
      return value.data;
    });
  }

  DioMetaData batchApiDioMetaData(List<DioMetaData> dioMetaDatas) {
    Map<String, dynamic> params = {};
    dioMetaDatas.forEach((element) {
      params[element.uri.path] = jsonEncode(element.data);
    });
    return DioMetaData(joinUri('/eapi/batch'), data: params, options: joinOptions(encryptType: EncryptType.EApi, eApiUrl: '/api/batch'));
  }

  /// batch批量请求接口
  /// 登陆后调用此接口 ,传入接口和对应原始参数(原始参数非文档里写的参数,需参考源码),可批量请求接口
  Future<BatchApiWrap> batchApi(List<DioMetaData> dioMetaDatas) {
    return Https.dioProxy.postUri(batchApiDioMetaData(dioMetaDatas)).then((Response value) {
      return BatchApiWrap.fromJson(value.data);
    });
  }

  DioMetaData weblogDioMetaData(String id, String sourceId, String action, String type, String end, {int download = 0, int wifi = 0, int time = 0}) {
    var params = {
      'logs': jsonEncode([
        {
          'action': action,
          'json': {
            'download': download,
            'end': end,
            'id': id,
            'sourceId': sourceId,
            'time': time,
            'type': type,
            'wifi': wifi,
          }
        }
      ])
    };
    return DioMetaData(joinUri('/weapi/feedback/weblog'), data: params, options: joinOptions());
  }

  /// 操作记录
  /// [action] 'play'
  Future<ServerStatusBean> weblog(String id, String sourceId, String action, String type, String end, {int download = 0, int wifi = 0, int time = 0}) {
    return Https.dioProxy.postUri(weblogDioMetaData(id, sourceId, action, type, end, download: download, wifi: wifi, time: time)).then((Response value) {
      return ServerStatusBean.fromJson(value.data);
    });
  }
}
