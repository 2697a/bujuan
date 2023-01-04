import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/body/body_view.dart';
import 'package:bujuan/pages/home/view/home_view.dart';
import 'package:bujuan/pages/index/album_view.dart';
import 'package:bujuan/pages/index/main_view.dart';
import 'package:bujuan/pages/play_list/playlist.dart';
import 'package:bujuan/pages/talk/talk_view.dart';
import 'package:bujuan/pages/user/user_view.dart';

import '../pages/home/body/body/view.dart';
import '../pages/login/login.dart';
import '../pages/play_list/playlist_view.dart';
import '../pages/splash_page.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const index = _Paths.index;
  static const user = _Paths.user;
  static const details = _Paths.details;
  static const splash = _Paths.splash;
  static const setting = _Paths.setting;
  static const playlist = _Paths.playlist;
  static const login = _Paths.login;
  static const search = _Paths.search;
  static const talk = _Paths.talk;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const index = 'index';
  static const user = 'user';
  static const search = 'search';
  static const playlist = 'playlist';
  static const details = '/details';
  static const setting = '/setting';
  static const splash = '/splash';
  static const login = '/login';
  static const talk = '/talk';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: Routes.home, page: HomeView, deferredLoading: true, children: [
      AutoRoute(path: Routes.user, page: UserView, initial: true, deferredLoading: true),
      AutoRoute(path: Routes.search, page: AlbumView),
      AutoRoute(path: Routes.playlist, page: PlayListView),
      AutoRoute(path: Routes.index, page: MainView)
    ]),
    AutoRoute(path: Routes.splash, page: SplashPage, initial: true, deferredLoading: true),
    AutoRoute(path: Routes.login, page: LoginView),
    AutoRoute(path: Routes.talk, page: TalkView),
  ],
)
class $RootRouter {}
