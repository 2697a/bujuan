import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bujuan/routes/app_outes.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import 'api/answer.dart';
import 'api/netease_cloud_music.dart';
import 'global/global_binding.dart';
import 'global/global_config.dart';
import 'global/global_theme.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  GlobalBinding().dependencies();
  await initServices();
  await SpUtil.getInstance();
  var isDark = SpUtil.getBool(IS_DARK_SP, defValue: false);
  var isSystemTheme = SpUtil.getBool(IS_SYSTEM_THEME_SP, defValue: true);
  var theme;
  if (isSystemTheme) {
    theme = Get.isPlatformDarkMode ? darkTheme : lightTheme;
    SystemChrome.setSystemUIOverlayStyle(
        BuJuanUtil.setNavigationBarTextColor(Get.isPlatformDarkMode));
  } else {
    theme = isDark ? darkTheme : lightTheme;
    SystemChrome.setSystemUIOverlayStyle(
        BuJuanUtil.setNavigationBarTextColor(isDark));
  }

  runApp(GetMaterialApp(
    // showPerformanceOverlay: true,
    // darkTheme: darkTheme,
    debugShowCheckedModeBanner: false,
    theme: theme,
    enableLog: true,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ));
}

Future<HttpServer> _startServer({address = 'localhost', int port = 0}) {
  return HttpServer.bind(address, port, shared: true).then((server) {
    // debugPrint('start listen at: http://$address:$port');
    server.timeout(Duration(seconds: 8));
    server.listen((request) {
      _handleRequest(request);
    });
    return server;
  }).catchError((e, s) async {
    var rng = new Random();
    var nextInt = rng.nextInt(49151 - 1024) + 1024;
    await _startServer(port: nextInt);
  });
}

void _handleRequest(HttpRequest request) async {
  final answer = await cloudMusicApi(request.uri.path,
          parameter: request.uri.queryParameters, cookie: request.cookies)
      .catchError((e, s) async {
    print(e.toString());
    return Answer();
  });

  request.response.statusCode = answer.status;
  request.response.cookies.addAll(answer.cookie);
  request.response.write(json.encode(answer.body));
  request.response.close();

  // print('request[${answer.status}] : ${request.uri}');
}

/// 在你运行Flutter应用之前，让你的服务初始化是一个明智之举。
////因为你可以控制执行流程（也许你需要加载一些主题配置，apiKey，由用户自定义的语言等，所以在运行ApiService之前加载SettingService。
///所以GetMaterialApp()不需要重建，可以直接取值。
initServices() async {
  ///这里是你放get_storage、hive、shared_pref初始化的地方。
  ///或者moor连接，或者其他什么异步的东西。
  await Get.putAsync(() => FileService().init());
  print('All services started...');
}

class FileService extends GetxService {
  final directory = Directory("").obs;
  final version = 0.obs;

  Future<FileService> init() async {
    await _startServer();
    directory.value = await getTemporaryDirectory();
    version.value = await OnAudioQuery().getDeviceSDK();
    return this;
  }
}
