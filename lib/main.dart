import 'package:audio_service/audio_service.dart';

import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/bujuan_audio_handler.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/a_rebuild/home/home.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/pages/a_rebuild/user/user.dart';
import 'package:bujuan/pages/album/controller.dart';
import 'package:bujuan/pages/index/cound_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/pages/playlist_manager/playlist_manager_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:window_manager/window_manager.dart';

import 'common/constants/colors.dart';
import 'common/netease_api/src/netease_api.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool land = PlatformUtils.isMacOS || PlatformUtils.isWindows || OtherUtils.isPad();
  final getIt = GetIt.instance;
  // await _initAudioServer(getIt);
  if (PlatformUtils.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    );
     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,overlays: [SystemUiOverlay.bottom]);
  }
  //如果满足横屏条件，强制屏幕为横屏
  if (land) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }
  //外部
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(navigatorKey: shellNavigatorKey, builder: (BuildContext context, GoRouterState state, Widget child) => Outside(child: child), routes: [
        GoRoute(path: '/', builder: (c, s) => const HomePage()),
        GoRoute(path: '/user', builder: (c, s) => const User()),
      ])
    ],
  );
  runApp(ProviderScope(
      child: ScreenUtilInit(
    designSize: const Size(750, 1334),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => MaterialApp.router(
      theme: AppTheme.dark,
      routerConfig: router,
      showPerformanceOverlay: true,
    ),
  )));
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge).then((value) => runApp(ScreenUtilInit(
  //       designSize: !land ? const Size(750, 1334) : const Size(2339, 1080),
  //       minTextAdapt: true,
  //       splitScreenMode: true,
  //       builder: (BuildContext context, Widget? child) {
  //         HomeBinding().dependencies();
  //         return GetMaterialApp.router(
  //           title: "Bujuan",
  //           theme: AppTheme.light,
  //           darkTheme: AppTheme.dark,
  //           // showPerformanceOverlay: true,
  //           // checkerboardOffscreenLayers: true,
  //           // checkerboardRasterCacheImages: true,
  //           themeMode: ThemeMode.system,
  //           routerDelegate: rootRouter.delegate(navigatorObservers: () => [MyObserver()]),
  //           routeInformationParser: rootRouter.defaultRouteParser(),
  //           debugShowCheckedModeBanner: false,
  //           builder: (_, router) => MediaQuery(data: MediaQuery.of(_).copyWith(textScaleFactor: 1.0), child: router!),
  //         );
  //       },
  //     )));
}

class MyObserver extends AutoRouterObserver {
  _clearOrPutController(String name, {bool del = false}) {
    if (name.isEmpty) return;
    switch (name) {
      case 'AlbumView':
        del ? Get.delete<CloudController>() : Get.lazyPut<CloudController>(() => CloudController());
        break;
      case 'MainView':
        del ? Get.delete<IndexController>() : Get.lazyPut<IndexController>(() => IndexController());
        break;
      case 'UserView':
        del ? Get.delete<UserController>() : Get.lazyPut<UserController>(() => UserController());
        break;
      case 'PlayListView':
        del ? Get.delete<PlayListController>() : Get.lazyPut<PlayListController>(() => PlayListController());
        break;
      case 'AlbumDetails':
        del ? Get.delete<AlbumController>() : Get.lazyPut<AlbumController>(() => AlbumController());
        break;
      case 'PlaylistManagerView':
        del ? Get.delete<PlaylistManager>() : Get.lazyPut<PlaylistManager>(() => PlaylistManager());
        break;
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _clearOrPutController(route.settings.name ?? '');
    print('New route pushed: ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    // TODO: implement didRemove
    super.didRemove(route, previousRoute);
    _clearOrPutController(route.settings.name ?? '', del: true);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    super.didPop(route, previousRoute);
    _clearOrPutController(route.settings.name ?? '', del: true);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {}

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {}
}

Future<void> _initAudioServer(getIt) async {
  getIt.registerSingleton<RootRouter>(RootRouter());
  getIt.registerSingleton<AudioPlayer>(AudioPlayer());
  getIt.registerSingleton<ZoomDrawerController>(ZoomDrawerController());
  await Hive.initFlutter('BuJuan');
  getIt.registerSingleton<Box>(await Hive.openBox('cache'));
  await NeteaseMusicApi.init(debug: false);
  getIt.registerSingleton<BujuanAudioHandler>(await AudioService.init<BujuanAudioHandler>(
    builder: () => BujuanAudioHandler(),
    config: const AudioServiceConfig(
      androidStopForegroundOnPause: false,
      androidNotificationChannelId: 'com.sixbugs.bujuan.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationIcon: 'drawable/audio_service_icon',
    ),
  ));
}

Future<void> _initWindowManager() async {
  if (PlatformUtils.isWindows || PlatformUtils.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1080, 720),
      minimumSize: Size(1080, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
