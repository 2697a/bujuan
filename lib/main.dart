import 'dart:convert';
import 'dart:io';

import 'package:bujuan/login/login_binding.dart';
import 'package:bujuan/login/login_view.dart';
import 'package:bujuan/play_view/music_talk/music_talk_binding.dart';
import 'package:bujuan/play_view/music_talk/music_talk_view.dart';
import 'package:bujuan/profile/profile_binding.dart';
import 'package:bujuan/profile/profile_view.dart';
import 'package:bujuan/setting/setting_binding.dart';
import 'package:bujuan/setting/setting_view.dart';
import 'package:bujuan/sheet_classify/sheet_classify_binding.dart';
import 'package:bujuan/sheet_classify/sheet_classify_view.dart';
import 'package:bujuan/sheet_info/sheet_info_binding.dart';
import 'package:bujuan/sheet_info/sheet_info_view.dart';
import 'package:bujuan/splash/splash_binding.dart';
import 'package:bujuan/splash/splash_view.dart';
import 'package:bujuan/today/today_binding.dart';
import 'package:bujuan/today/today_view.dart';
import 'package:bujuan/user/cloud/cloud_binding.dart';
import 'package:bujuan/user/cloud/cloud_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  GlobalBinding().dependencies();
  await _startServer();
  await SpUtil.getInstance();
  var isDark = SpUtil.getBool(IS_DARK_SP, defValue: false);
  var isFirstOpen = SpUtil.getBool(IS_FIRST_OPEN, defValue: true);
  SystemChrome.setSystemUIOverlayStyle(BuJuanUtil.setNavigationBarTextColor(isDark));

  runApp(RefreshConfiguration(
    child: GetMaterialApp(
      // showPerformanceOverlay: true,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      theme: isDark ? darkTheme : lightTheme,
      enableLog: true,
      initialRoute: isFirstOpen ? '/splash' : '/home',
      getPages: [
        GetPage(name: '/splash', page: () => SplashView(), binding: SplashBinding()),
        GetPage(name: '/home', page: () => HomeView(), binding: HomeBinding()),
        GetPage(name: '/today', page: () => TodayView(), binding: TodayBinding()),
        GetPage(name: '/sheet', page: () => SheetInfoView(), binding: SheetInfoBinding()),
        GetPage(name: '/profile', page: () => ProfileView(), binding: ProfileBinding()),
        GetPage(name: '/setting', page: () => SettingView(), binding: SettingBinding()),
        GetPage(name: '/login', page: () => LoginView(), binding: LoginBinding()),
        GetPage(name: '/cloud', page: () => CloudView(), binding: CloudBinding()),
        GetPage(name: '/sheet_classify', page: () => SheetClassifyView(), binding: SheetClassifyBinding()),
        GetPage(name: '/music_talk', page: () => MusicTalkView(), binding: MusicTalkBinding()),
      ],
    ),
    headerBuilder: () => WaterDropMaterialHeader(
      color: Theme.of(Get.context).accentColor,
      backgroundColor: Theme.of(Get.context).primaryColor,
    ),
    // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
    footerBuilder: () => ClassicFooter(),
    // 配置默认底部指示器
    enableScrollWhenRefreshCompleted: true,
    //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
    enableLoadingWhenFailed: true,
    //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
    hideFooterWhenNotFull: false,
    // Viewport不满一屏时,禁用上拉加载更多功能
    enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
  ));
}

Future<HttpServer> _startServer({address = 'localhost', int port = 3000}) {
  return HttpServer.bind(address, port, shared: true).then((server) {
    print('start listen at: http://$address:$port');
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

  print('request[${answer.status}] : ${request.uri}');
}
