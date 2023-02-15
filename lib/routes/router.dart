import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/guide/guide_view.dart';
import 'package:bujuan/pages/home/view/home_view.dart';
import 'package:bujuan/pages/index/album_view.dart';
import 'package:bujuan/pages/index/main_view.dart';
import 'package:bujuan/pages/local/local_song.dart';
import 'package:bujuan/pages/local/netease_cache.dart';
import 'package:bujuan/pages/mv/mv_view.dart';
import 'package:bujuan/pages/radio/my_radio_view.dart';
import 'package:bujuan/pages/radio/radio_details_view.dart';
import 'package:bujuan/pages/setting/coffee.dart';
import 'package:bujuan/pages/setting/settring_view.dart';
import 'package:bujuan/pages/setting/user_setting_view.dart';
import 'package:bujuan/pages/talk/talk_view.dart';
import 'package:bujuan/pages/today/today_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
// import 'package:go_router/go_router.dart';

import '../pages/artists/artists_view.dart';
import '../pages/local/edit_song_view.dart';
import '../pages/local/local_album.dart';
import '../pages/local/local_ar.dart';
import '../pages/local/local_view.dart';
import '../pages/login/login.dart';
import '../pages/play_list/playlist_view.dart';
import '../pages/search/search_view.dart';
import '../pages/setting/image_blur.dart';
import '../pages/splash_page.dart';
import '../pages/update/update_view.dart';

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
  static const today = _Paths.today;
  static const cloud = _Paths.cloud;
  static const artists = _Paths.artists;
  static const myRadio = _Paths.myRadio;
  static const guide = _Paths.guide;
  static const userSetting = _Paths.userSetting;
  static const mv = _Paths.mv;
  static const update = _Paths.update;
  static const local = _Paths.local;
  static const editSong = _Paths.editSong;
  static const localSong = _Paths.localSong;
  static const radioDetails = _Paths.radioDetails;
  static const imageBlur = _Paths.imageBlur;
  static const coffee = _Paths.coffee;
  static const neteaseCache = _Paths.neteaseCache;
  static const localAlbum = _Paths.localAlbum;
  static const localAr = _Paths.localAr;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const index = 'index';
  static const user = 'user';
  static const local = 'local';
  static const search = 'search';
  static const playlist = 'playlist';
  static const details = '/details';
  static const setting = '/setting';
  static const splash = '/splash';
  static const login = '/login';
  static const talk = '/talk';
  static const today = 'today';
  static const cloud = 'cloud';
  static const artists = 'artists';
  static const myRadio = 'myRadio';
  static const radioDetails = 'radioDetails';
  static const guide = '/guide';
  static const userSetting = '/userSetting';
  static const mv = '/mv';
  static const update = '/update';
  static const editSong = '/editSong';
  static const localSong = 'localSong';
  static const imageBlur = '/imageBlur';
  static const coffee = '/coffee';
  static const neteaseCache = 'neteaseCache';
  static const localAlbum = 'localAlbum';
  static const localAr = 'localAr';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: Routes.home, page: HomeView, deferredLoading: true, fullscreenDialog: true, children: [
      AutoRoute(path: Routes.user, page: UserView, initial: true, deferredLoading: true, fullscreenDialog: true),
      AutoRoute(path: Routes.cloud, page: AlbumView, fullscreenDialog: true),
      AutoRoute(path: Routes.playlist, page: PlayListView, fullscreenDialog: true),
      AutoRoute(path: Routes.index, page: MainView, fullscreenDialog: true),
      AutoRoute(path: Routes.today, page: TodayView, fullscreenDialog: true),
      AutoRoute(path: Routes.search, page: SearchView, fullscreenDialog: true),
      AutoRoute(path: Routes.artists, page: ArtistsView, fullscreenDialog: true),
      AutoRoute(path: Routes.myRadio, page: MyRadioView, fullscreenDialog: true),
      AutoRoute(path: Routes.radioDetails, page: RadioDetailsView, fullscreenDialog: true),
      AutoRoute(path: Routes.local, page: LocalView, fullscreenDialog: true),
      AutoRoute(path: Routes.localSong, page: LocalSongView, fullscreenDialog: true),
      AutoRoute(path: Routes.neteaseCache, page: NeteaseCacheView, fullscreenDialog: true),
      AutoRoute(path: Routes.localAlbum, page: LocalAlbum, fullscreenDialog: true),
      AutoRoute(path: Routes.localAr, page: LocalAr, fullscreenDialog: true),
    ]),
    AutoRoute(path: Routes.splash, page: SplashPage, initial: true, deferredLoading: true, fullscreenDialog: true),
    AutoRoute(path: Routes.login, page: LoginView, fullscreenDialog: true),
    AutoRoute(path: Routes.talk, page: TalkView, fullscreenDialog: true),
    AutoRoute(path: Routes.setting, page: SettingView, fullscreenDialog: true),
    AutoRoute(path: Routes.guide, page: GuideView, fullscreenDialog: true),
    AutoRoute(path: Routes.userSetting, page: UserSettingView, fullscreenDialog: true),
    AutoRoute(path: Routes.mv, page: MvView, fullscreenDialog: true),
    AutoRoute(path: Routes.update, page: UpdateView, fullscreenDialog: true),
    AutoRoute(path: Routes.editSong, page: EditSongView, fullscreenDialog: true),
    AutoRoute(path: Routes.imageBlur, page: ImageBlur, fullscreenDialog: true),
    AutoRoute(path: Routes.coffee, page: CoffeePage, fullscreenDialog: true),
  ],
)
class $RootRouter {}

// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
// GoRouter goRouter = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: '/a',
//   routes: [
//     ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       builder: (BuildContext context, GoRouterState state, Widget child) {
//         return HomeView(body: child);
//       },
//       routes: [
//         GoRoute(
//           path: '/a',
//           builder: (BuildContext context, GoRouterState state) {
//             return const UserView();
//           },
//         ),
//       ]
//     )
//   ],
// );
