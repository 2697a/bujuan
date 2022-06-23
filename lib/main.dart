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
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'common/api/netease_cloud_music.dart';
import 'common/constants/colors.dart';

main() async {
  bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  await _initAudioServer();
  final router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            return const SplashPage();
          },
          routes: []),
      GoRoute(
          path: '/home',
          builder: (context, state) {
            HomeBinding().dependencies();
            return const HomeMobileView();
          },
          routes: [
            GoRoute(
              path: 'details',
              builder: (context, state) {
                DetailsBinding().dependencies();
                return const DetailsView();
                },
            ),
          ]),
    ],
    navigatorBuilder: (context, state, child) {
      if (state.location == '/') return child;
      HomeController.to.changeRoute(state.location);
      return FirstView(child);
    },
  );
  runApp(ScreenUtilInit(
    designSize: isMobile ? const Size(750, 1334) : const Size(2160, 1406),
    builder: (BuildContext context, Widget? child) => GetMaterialApp.router(
      color: Colors.red,
      title: "Application",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      showPerformanceOverlay: false,
      // 开启FPS监控
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    ),
  ));
}

Future<void> _initAudioServer() async {
  final getIt = GetIt.instance;
  getIt.registerSingleton<AudioServeHandler>(await AudioService.init<AudioServeHandler>(
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
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}

Future<HttpServer> _startServer({int port = 0}) {
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
