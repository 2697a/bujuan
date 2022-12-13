import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/audio_handler.dart';
import 'package:bujuan/pages/home/home_binding.dart';
import 'package:bujuan/pages/splash_page.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/weslide/weslide_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'common/constants/colors.dart';
import 'common/netease_api/src/netease_api.dart';
import 'common/storage.dart';

main() async {
  bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  final rootRouter = RootRouter(
      // authGuard: AuthGuard(),
      );
  await _initAudioServer();
  HomeBinding().dependencies();
  runApp(ScreenUtilInit(
    designSize: isMobile ? const Size(750, 1334) : const Size(2160, 1406),
    builder: (BuildContext context, Widget? child) => GetMaterialApp.router(
      title: "Application",
      theme: AppTheme.light.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      })),
      darkTheme: AppTheme.dark,
      showPerformanceOverlay: false,
      themeMode: ThemeMode.system,
      routerDelegate: rootRouter.delegate(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      // routeInformationProvider: _rootRouter.routeInfoProvider(),
      routeInformationParser: rootRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      builder: (_, router) {
        return router!;
      },
      // home: const SplashPage(),
    ),
  ));
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge).then((value) => );
}

Future<void> _initAudioServer() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final getIt = GetIt.instance;
  getIt.registerSingleton<OnAudioQuery>(OnAudioQuery());
  getIt.registerSingleton<WeSlideController>(WeSlideController());
  getIt.registerSingleton<ZoomDrawerController>(ZoomDrawerController());
  // 工具初始
  await StorageUtil.init();
  print('=============onReady');
  // _startServer();
  await NeteaseMusicApi.init(debug: true);
  getIt.registerSingleton<AudioServeHandler>(await AudioService.init<AudioServeHandler>(
    builder: () => AudioServeHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.sixbugs.bujuan.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationIcon: 'drawable/audio_service_icon',
    ),
  ));
  getIt.registerSingleton<NeteaseMusicApi>(NeteaseMusicApi());
  // android 状态栏为透明的沉浸
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  });
}
