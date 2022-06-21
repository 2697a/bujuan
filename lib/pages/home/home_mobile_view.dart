import 'package:bujuan/pages/home/first/first_view.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index/album_view.dart';
import '../index/index_view.dart';
import '../user/user_view.dart';

class HomeMobileView extends GetView<HomeController> {
  const HomeMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
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
