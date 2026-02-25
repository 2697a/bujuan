import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:bujuan_music/common/local_proxy_service.dart';
import 'package:bujuan_music/common/values/app_theme.dart';
import 'package:bujuan_music/pages/main/provider.dart';
import 'package:bujuan_music/router/router.dart';
import 'package:bujuan_music/utils/adaptive_screen_utils.dart';
import 'package:bujuan_music/widgets/we_slider/weslide_controller.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
// import 'package:media_kit/media_kit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 添加导入
import 'package:window_manager/window_manager.dart';

import 'common/bujuan_music_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalProxyService().start();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  GetIt getIt = GetIt.instance;

  await initMedia();
  await initialize();
  
  // 启动时加载手动 cookie
  await _loadManualCookie();

  getIt.registerSingleton<WeSlideController>(
    WeSlideController(initial: true),
    instanceName: 'footer',
  );
  getIt.registerSingleton<WeSlideController>(WeSlideController(), instanceName: 'panel');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(ProviderScope(child: MyApp()));
}

Future<void> _loadManualCookie() async {
  final prefs = await SharedPreferences.getInstance();
  final cookie = prefs.getString('manual_cookie');
  if (cookie != null && cookie.isNotEmpty) {
    BujuanMusicManager().setCookie(cookie);
    debugPrint('Loaded manual cookie from storage');
  }
}

Future<void> initWindow() async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(1024, 650),
      maximumSize: Size(1024, 800),
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

Future<void> initMedia() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  await BujuanMusicManager().init(cookiePath: '${appDocDir.path}/cookies', debug: false);
  await AudioService.init(
    builder: () => BujuanMusicHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.sixbugs.bujuan.channel.audio',
      androidNotificationChannelName: 'Music playback',
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    Size size = Size(375, 812);
    if (medium(context) || expanded(context)) {
      size = Size(1024, 700);
    }

    return ScreenUtilInit(
      designSize: size,
      builder: (_, __) => Consumer(
        builder: (_, ref, __) {
          final themeMode = ref.watch(themeModeProvider);
          return AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: false,
              systemNavigationBarContrastEnforced: false,
            ),
            child: MaterialApp.router(
              title: 'Bujuan',
              themeMode: themeMode,
              darkTheme: AppTheme.dark,
              theme: AppTheme.light,
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}