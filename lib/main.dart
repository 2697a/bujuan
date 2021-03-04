import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import 'api/answer.dart';
import 'api/netease_cloud_music.dart';
import 'global/global_binding.dart';
import 'global/global_theme.dart';
import 'home/home_binding.dart';
import 'home/home_view.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  GlobalBinding().dependencies();
  await _startServer();
  runApp(GetMaterialApp(
    // showPerformanceOverlay: true,
    theme: lightTheme,
    enableLog: true,
    initialRoute: "/home",
    getPages: [GetPage(name: "/home", page: () => HomeView(), binding: HomeBinding())],
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
  final answer = await cloudMusicApi(request.uri.path, parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) async {
    print(e.toString());
    return Answer();
  });

  request.response.statusCode = answer.status;
  request.response.cookies.addAll(answer.cookie);
  request.response.write(json.encode(answer.body));
  request.response.close();

  print("request[${answer.status}] : ${request.uri}");
}
