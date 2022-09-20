import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../generated/json/base/json_convert_content.dart';
import '../netease_cloud_music.dart';

typedef Error = Function();
typedef Success<T> = Function(T data);

class NetUtils {
  static final NetUtils _netUtils = NetUtils._internal(); //1

  factory NetUtils() {
    return _netUtils;
  }

  NetUtils._internal();

  ///统一请求'msg' -> 'data inconstant when unbooked playlist, pid:2427280345 userId:302618605'
  doHandler<T>(
      String url, {
        Map param = const {},
        Success<T>? onSuccess,
        Error? onError,
      }) async {
    var answer = await cloudMusicApi(url, parameter: param, cookie: await _getCookie());
    if (answer.status == 200) {
      if (answer.cookie.isNotEmpty) {
        // await _saveCookie(answer.cookie);
      }
      // if(url == '/lyric') {
        log('==================${jsonEncode(answer.body)}');
      // }
      var data = JsonConvert.fromJsonAsT<T>(answer.body);
      if (data != null) onSuccess?.call(data);
    } else {
      onError?.call();
    }
  }

  ///保存cookie
  Future<void> _saveCookie(List<Cookie> cookies) async {
    Directory tempDir = await getApplicationSupportDirectory();
    String tempPath = tempDir.path;
    CookieJar cookie = PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath));
    cookie.saveFromResponse(Uri.parse('https://music.163.com/weapi/'), cookies);
  }

  ///获取cookie
  Future<List<Cookie>> _getCookie() async {
    // Directory tempDir = await getApplicationSupportDirectory();
    // String tempPath = tempDir.path;
    // CookieJar cookie = PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath));
    // return cookie.loadForRequest(Uri.parse('https://music.163.com/weapi/'));
    return [];
  }
}
