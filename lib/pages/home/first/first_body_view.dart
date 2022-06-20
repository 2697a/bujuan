import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/album_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/colors.dart';
import '../../../routes/app_pages.dart';
import '../../index/index_view.dart';
import '../../user/user_view.dart';

class FirstBodyView extends GetView<HomeController>{
  const FirstBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      routingCallback: (r) => controller.changeRoute(r?.current),
      home: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          IndexView(),
          AlbumView(),
          IndexView(),
          UserView(),
        ],
      ),
    );
  }

}