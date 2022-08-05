import 'dart:convert';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/pages/home/home_binding.dart';
import 'package:bujuan/pages/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lastfm/lastfm.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'common/api/netease_cloud_music.dart';
import 'common/constants/colors.dart';
import 'common/storage.dart';

main() async {
  bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  await _initAudioServer();
  HomeBinding().dependencies();
  runApp(ScreenUtilInit(
    designSize: isMobile ? const Size(750, 1334) : const Size(2160, 1406),
    builder: (BuildContext context, Widget? child) => MaterialApp(
      title: "Application",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      showPerformanceOverlay: false,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    ),
  ));
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge).then((value) => );
}

Future<void> _initAudioServer() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final getIt = GetIt.instance;
  getIt.registerSingleton<OnAudioQuery>(OnAudioQuery());
  // 工具初始
  await StorageUtil.init();
  print('=============onReady');

  getIt.registerSingleton<AudioServeHandler>(await AudioService.init<AudioServeHandler>(
    builder: () => AudioServeHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.sixbugs.bujuan.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationIcon: 'drawable/audio_service_icon',
    ),
  ));
  // LastFMUnauthorized lastfm = LastFMUnauthorized('1231b5c3f86fa221536abc43cba6a5ab', 'ab7bb13271fda8de8e53992974d168cc');
  // launchUrlString(await lastfm.authorizeDesktop());
  // android 状态栏为透明的沉浸
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}

Future<HttpServer> _startServer({int port = 0}) {
  return HttpServer.bind(InternetAddress.loopbackIPv4, port, shared: true).then((server) {
    if (kDebugMode) {
      print('start listen at: http://${server.address.address}:${server.port}');
    }
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
