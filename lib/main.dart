import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:bujuan/pages/home/home_binding.dart';
import 'package:bujuan/pages/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/api/netease_cloud_music.dart';
import 'common/constants/colors.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _startServer();
  bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  // android 状态栏为透明的沉浸
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,overlays: [SystemUiOverlay.bottom,SystemUiOverlay.top]);
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(ScreenUtilInit(
    designSize: isMobile ? const Size(750, 1334) : const Size(2160, 1406),
    builder: (BuildContext context, Widget? child) => MaterialApp(
      title: "Application",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    ),
  ));
}

Future<HttpServer> _startServer({int port = 0}) {
  HomeBinding().dependencies();
  return HttpServer.bind(InternetAddress.loopbackIPv4, port, shared: true).then((server) {
    if (kDebugMode) print('start listen at: http://${server.address.address}:${server.port}');
    server.listen((request) => _handleRequest(request));
    return server;
  });
}

void _handleRequest(HttpRequest request) async {
  final answer = await cloudMusicApi(request.uri.path, parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) => const Answer());
  request.response.statusCode = answer.status;
  request.response.cookies.addAll(answer.cookie);
  request.response.write(json.encode(answer.body));
  request.response.close();
  if (kDebugMode) print('request[${answer.status}] : ${request.uri}');
}
