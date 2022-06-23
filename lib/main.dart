import 'dart:convert';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/pages/details/details_bindings.dart';
import 'package:bujuan/pages/details/details_view.dart';
import 'package:bujuan/pages/home/first/first_view.dart';
import 'package:bujuan/pages/home/home_binding.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/pages/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'common/api/netease_cloud_music.dart';
import 'common/constants/colors.dart';

main() async {
  bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  await _initAudioServer();
  runApp(ScreenUtilInit(
    designSize: isMobile ? const Size(750, 1334) : const Size(2160, 1406),
    builder: (BuildContext context, Widget? child) => MaterialApp(
      color: Colors.red,
      title: "Application",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      showPerformanceOverlay: false,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const FirstView(),
    ),
  ));
}

Future<void> _initAudioServer() async {
  final getIt = GetIt.instance;
  HomeBinding().dependencies();
  getIt.registerSingleton<AudioServeHandler>(
      await AudioService.init<AudioServeHandler>(
    builder: () => AudioServeHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.sixbugs.bujuan.channel.audio',
      androidNotificationChannelName: 'Music playback',
    ),
  ));
  // android 状态栏为透明的沉浸
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}

Future<HttpServer> _startServer({int port = 0}) {
  return HttpServer.bind(InternetAddress.loopbackIPv4, port, shared: true)
      .then((server) {
    if (kDebugMode)
      print('start listen at: http://${server.address.address}:${server.port}');
    server.listen((request) => _handleRequest(request));
    return server;
  });
}

void _handleRequest(HttpRequest request) async {
  final answer = await cloudMusicApi(request.uri.path,
          parameter: request.uri.queryParameters, cookie: request.cookies)
      .catchError((e, s) => const Answer());
  request.response.statusCode = answer.status;
  request.response.cookies.addAll(answer.cookie);
  request.response.write(json.encode(answer.body));
  request.response.close();
  if (kDebugMode) print('request[${answer.status}] : ${request.uri}');
}
