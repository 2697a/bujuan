import 'package:bujuan/pages/details/details_bindings.dart';
import 'package:bujuan/pages/details/details_view.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/pages/index/index_binding.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/splash_page.dart';
import 'package:bujuan/pages/user/user_binding.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../common/bean/personalized_entity.dart';
import '../pages/home/home_binding.dart';

part 'app_routes.dart';




class AppPages {
  AppPages._();

  static const inital = Routes.home;

  static final routes = [
    // GetPage(
    //     preventDuplicates: true,
    //     name: _Paths.home,
    //     page: () => const HomeMobileView(),
    //     binding: HomeBinding(),
    // ),
    GetPage(
      fullscreenDialog: true,
      popGesture: false,
      name: _Paths.details,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      fullscreenDialog: true,
      popGesture: false,
      name: _Paths.user,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
  ];
}

class DetailsArguments {
  AlbumModel albumModel;

  DetailsArguments(this.albumModel);
}
