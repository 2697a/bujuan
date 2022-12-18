import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api/bean.dart';
import 'api/dj/api.dart';
import 'api/event/api.dart';
import 'api/login/api.dart';
import 'api/login/bean.dart';
import 'api/play/api.dart';
import 'api/search/api.dart';
import 'api/uncategorized/api.dart';
import 'api/user/api.dart';
import 'dio_ext.dart';
import 'netease_bean.dart';
import 'netease_handler.dart';

class NeteaseMusicApi
    with
        ApiPlay,
        ApiDj,
        ApiLogin,
        ApiUser,
        ApiEvent,
        ApiSearch,
        ApiUncategorized {
  static NeteaseMusicApi? _neteaseMusicApi;

  static late CookieManager cookieManager;
  static late PathProvider pathProvider;

  static Future<bool> init({PathProvider? provider, bool debug = false}) async {
    provider ??= PathProvider();
    pathProvider = provider;

    await provider.init();

    cookieManager = CookieManager(
        PersistCookieJar(storage: FileStorage(provider.getCookieSavedPath())));

    _initDio(Https.dio, debug, true);

    return true;
  }

  static Dio _initDio(Dio dio, bool debug, bool refreshToken) {
    dio.interceptors.add(cookieManager);

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: neteaseInterceptor,
        onResponse:
            (Response response, ResponseInterceptorHandler handler) async {
          var requestOptions = response.requestOptions;

          if (response.data is String) {
            try {
              response.data = jsonDecode(response.data);
            } catch (e) {}
          }
          if (refreshToken &&
              NeteaseMusicApi().usc.isLogined &&
              response.data is Map) {
            var result = ServerStatusBean.fromJson(response.data);
            // 1. token已经更新，请求重试
            // 2. token未更新
            //    刷新token
            //    1. 刷新成功，请求重试
            //    2. 刷新失败，登录态切换
            if (result.code == RET_CODE_NEED_LOGIN) {
              try {
                if (requestOptions.extra['cookiesHash'] !=
                    await loadCookiesHash()) {
                  var newResponse = await dio.fetch(requestOptions);
                  handler.next(newResponse);
                  return;
                }
                dio.lock();
                var refreshResult = await NeteaseMusicApi()
                    .loginRefresh(dio: _initDio(Dio(), debug, false));
                dio.unlock();
                if (refreshResult.code == RET_CODE_OK) {
                  var newResponse = await dio.fetch(requestOptions);
                  handler.next(newResponse);
                  return;
                }
              } catch (e) {} finally {
                dio.unlock();
              }
              await NeteaseMusicApi().usc.onLogout();
            }
          }

          handler.next(response);
        }));

    if (debug) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
          logPrint: (object) {
            if (object is String) {
              print(object.replaceAll('║', ''));
            }
          }));
    }
    return dio;
  }

  UserLoginStateController usc = UserLoginStateController();

  NeteaseMusicApi._internal() {
    usc.init();
  }

  factory NeteaseMusicApi() {
    return _neteaseMusicApi ??= NeteaseMusicApi._internal();
  }
}

class UserLoginStateController {
  LoginState? _curLoginState;

  StreamController? _controller;

  UserLoginStateController();

  Future<void> init() async {
    _checkCreateSavePath();
    await _readAccountInfo();
    _refreshLoginState((await loadCookies()).isNotEmpty && _accountInfo != null
        ? LoginState.Logined
        : LoginState.Logout);
  }

  NeteaseAccountInfoWrap? _accountInfo;

  NeteaseAccountInfoWrap? get accountInfo {
    return _accountInfo;
  }

  AnonimousLoginRet? _anonimousLoginRet;

  AnonimousLoginRet? get anonimousLoginInfo {
    if (accountInfo != null) {
      _anonimousLoginRet = null;
    }
    return _anonimousLoginRet;
  }

  bool get isLogined {
    return _curLoginState == LoginState.Logined;
  }

  StreamSubscription listenLoginState(
      void onChange(
          LoginState event, NeteaseAccountInfoWrap? accountInfoWrap)) {
    var controller = _controller;
    if (controller == null) {
      _controller = controller = StreamController.broadcast(sync: true);
    }
    return controller.stream.listen((t) {
      onChange(t, accountInfo);
    });
  }

  void onLogined(NeteaseAccountInfoWrap infoWrap) {
    _accountInfo = infoWrap;
    _refreshLoginState(LoginState.Logined);
    _saveAccountInfo(infoWrap);
  }

  void onAnonimousLogined(AnonimousLoginRet anonimousLoginRet) {
    _anonimousLoginRet = anonimousLoginRet;
  }

  Future<void> onLogout() async {
    await deleteAllCookie();
    _accountInfo = null;
    _saveAccountInfo(null);
    _refreshLoginState(LoginState.Logout);
  }

  void _saveAccountInfo(NeteaseAccountInfoWrap? infoWrap) {
    _saveFile().writeAsString(jsonEncode(infoWrap), flush: true);
  }

  Future<void> _readAccountInfo() async {
    try {
      var accountInfo = _saveFile().readAsStringSync();

      _accountInfo = NeteaseAccountInfoWrap.fromJson(jsonDecode(accountInfo));
    } catch (e) {
      print('login info error');
      await onLogout();
    }
  }

  File _saveFile() => File(
      NeteaseMusicApi.pathProvider.getDataSavedPath() + "_accountInfo.json");

  _checkCreateSavePath() {
    var file = _saveFile();
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
  }

  void _refreshLoginState(LoginState state) {
    var controller = _controller;
    if (controller != null && _curLoginState != state) {
      controller.add(state);
    }
    _curLoginState = state;
  }

  void destroy() {
    _controller?.close();
  }
}

enum LoginState {
  Logined,
  Logout,
}

class PathProvider {
  var _cookiePath;
  var _dataPath;

  init() async {
    _cookiePath = "${(await getApplicationSupportDirectory()).absolute.path}/zmusic/.cookies/";
    _dataPath = "${(await getApplicationSupportDirectory()).absolute.path}/zmusic/.data/";
  }

  String getCookieSavedPath() {
    return _cookiePath;
  }

  String getDataSavedPath() {
    return _dataPath;
  }
}
