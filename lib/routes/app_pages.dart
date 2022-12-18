import 'package:bujuan/pages/details/details_bindings.dart';
import 'package:bujuan/pages/details/details_view.dart';
import 'package:bujuan/pages/home/setting/setting_view.dart';
import 'package:bujuan/pages/home/setting/settingbindings.dart';
import 'package:bujuan/pages/login/bindings.dart';
import 'package:bujuan/pages/login/aaa.dart';
import 'package:bujuan/pages/play_list/bindings.dart';
import 'package:bujuan/pages/play_list/playlist.dart';
import 'package:bujuan/pages/user/user_binding.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:get/get.dart';

import '../pages/login/login.dart';
// import 'package:on_audio_query/on_audio_query.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const inital = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.setting,
      page: () => const SettingView(),
      binding: SettingBindings(),
    ),
    // GetPage(
    //   name: _Paths.details,
    //   page: () => const DetailsView(),
    //   binding: DetailsBinding(),
    // ),
    GetPage(
      name: _Paths.user,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    // GetPage(
    //   name: _Paths.playlist,
    //   page: () => const PlayList(),
    //   binding: PlayListBindings(),
    // ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBindings(),
    ),
  ];
}

// class DetailsArguments {
//   AlbumModel albumModel;
//
//   DetailsArguments(this.albumModel);
// }

