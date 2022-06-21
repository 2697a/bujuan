import 'package:bujuan/pages/details/details_bindings.dart';
import 'package:bujuan/pages/details/details_view.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/pages/index/index_binding.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/user/user_binding.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:get/get.dart';

import '../common/bean/personalized_entity.dart';
import '../pages/home/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const inital = Routes.home;

  static final routes = [
    // GetPage(
    //   name: _Paths.home,
    //   page: () => const HomeMobileView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.index,
      page: () => const IndexView(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: _Paths.user,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.details,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
  ];
}

class DetailsArguments {
  PersonalizedResult personalizedResult;

  DetailsArguments(this.personalizedResult);
}
