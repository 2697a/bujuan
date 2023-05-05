import 'package:audio_service/audio_service.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/bujuan_audio_handler.dart';
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/album/controller.dart';
import 'package:bujuan/pages/home/home_binding.dart';
import 'package:bujuan/pages/index/cound_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/pages/local/local_controller.dart';
import 'package:bujuan/pages/local/netease_controller.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_cache_manager/core/download_cache_manager.dart';
import 'package:on_audio_edit/on_audio_edit.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'common/constants/colors.dart';
import 'common/netease_api/src/netease_api.dart';
import 'common/storage.dart';

main() async {
  bool isMobile = PlatformUtils.isAndroid || PlatformUtils.isIOS || PlatformUtils.isFuchsia || PlatformUtils.isWeb;
  WidgetsFlutterBinding.ensureInitialized();
  await DownloadCacheManager.init();
  await DownloadCacheManager.setExpireDate(daysToExpire: 100);
  final getIt = GetIt.instance;
  await _initAudioServer(getIt);
  final rootRouter = getIt<RootRouter>();
  HomeBinding().dependencies();
  // debugProfileBuildsEnabled = true;
  if (PlatformUtils.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarColor: Colors.transparent, systemNavigationBarContrastEnforced: false);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge).then((value) => runApp(OrientationBuilder(builder: (BuildContext context, Orientation orientation) => ScreenUtilInit(
    designSize: orientation == Orientation.portrait?const Size(750, 1334):const Size(2339, 1080),
    builder: (BuildContext context, Widget? child) {
      return GetMaterialApp.router(
        title: "Bujuan",
        theme: AppTheme.light.copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
            })),
        darkTheme: AppTheme.dark.copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
            })),
        // showPerformanceOverlay: true,
        // checkerboardOffscreenLayers: true,
        // checkerboardRasterCacheImages: true,
        themeMode: ThemeMode.system,
        routerDelegate: rootRouter.delegate(
          navigatorObservers: () => [MyObserver()],
        ),
        routeInformationParser: rootRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        builder: (_, router) => MediaQuery(data: MediaQuery.of(_).copyWith(textScaleFactor: 1.0), child: router!),
        // home: const SplashPage(),
      );
    },
  ),)));
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
      case 'NeteaseCacheView':
        del ? Get.delete<Netease>() : Get.lazyPut<Netease>(() => Netease());
        break;
      case 'LocalView':
        del ? Get.delete<Local>() : Get.lazyPut<Local>(() => Local());
        break;
      case 'AlbumDetails':
        del ? Get.delete<AlbumController>() : Get.lazyPut<AlbumController>(() => AlbumController());
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
    print(' route Remove: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    super.didPop(route, previousRoute);
    _clearOrPutController(route.settings.name ?? '', del: true);
    print(' route Pop: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    print(' route Replace: ${newRoute?.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('Tab route re-visited: ${route.name}');
  }
}

Future<void> _initAudioServer(getIt) async {
  getIt.registerSingleton<RootRouter>(RootRouter());
  getIt.registerSingleton<AudioPlayer>(AudioPlayer());
  getIt.registerSingleton<ZoomDrawerController>(ZoomDrawerController());
  getIt.registerSingleton<OnAudioQuery>(OnAudioQuery());
  getIt.registerSingleton<OnAudioEdit>(OnAudioEdit());
  // 工具初始
  // await StorageUtil.init();
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
