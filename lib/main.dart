import 'dart:convert';
import 'dart:io';

import 'package:bujuan/sheet_info/sheet_info_binding.dart';
import 'package:bujuan/sheet_info/sheet_info_view.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:starry/starry.dart';

import 'api/answer.dart';
import 'api/netease_cloud_music.dart';
import 'global/global_binding.dart';
import 'global/global_config.dart';
import 'global/global_theme.dart';
import 'home/home_binding.dart';
import 'home/home_view.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  GlobalBinding().dependencies();
  await _startServer();
  await SpUtil.getInstance();
  var isDark = SpUtil.getBool(IS_DARK_SP, defValue: false);
  if (!isDark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[900],
        systemNavigationBarIconBrightness: Brightness.light));
  }
  runApp(GetMaterialApp(
    // showPerformanceOverlay: true,
    darkTheme: darkTheme,
    debugShowCheckedModeBanner: false,
    theme: isDark ? darkTheme : lightTheme,
    enableLog: true,
    initialRoute: "/home",
    getPages: [
      GetPage(name: "/home", page: () => HomeView(), binding: HomeBinding()),
      GetPage(name: '/sheet', page: () => SheetInfoView(),binding: SheetInfoBinding()),
    ],
  ));
}

Future<HttpServer> _startServer({address = "localhost", int port = 3000}) {
  return HttpServer.bind(address, port, shared: true).then((server) {
    print("start listen at: http://$address:$port");
    server.listen((request) {
      _handleRequest(request);
    });
    return server;
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

  print("request[${answer.status}] : ${request.uri}");
}
