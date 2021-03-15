import 'package:bujuan/find/find_view.dart';
import 'package:bujuan/keep.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/play_view/default_view.dart';
import 'package:bujuan/search/search_view.dart';
import 'package:bujuan/setting/setting_binding.dart';
import 'package:bujuan/setting/setting_view.dart';
import 'package:bujuan/user/user_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildHomeView());
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text("Bujuan"),
          leading: IconButton(
            icon: Hero(
                tag: "${controller.avatar.value}",
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30.0)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: controller.avatar.value,
                    height: 30.0,
                    width: 30.0,
                  ),
                )),
            onPressed: () => Get.toNamed("/profile",arguments: {"avatar":"${controller.avatar.value}"}),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Get.toNamed("/setting"))
          ]),
      body: Padding(
          padding: EdgeInsets.only(top: 0.0,left: 5.0,right: 5.0),
          child: PageView(
              controller: controller.pageController,
              physics: NeverScrollableScrollPhysics(),
              // onPageChanged: (index) => controller.changeIndex(index),
              children: [
                KeepAliveWrapper( child: FindView()),
                KeepAliveWrapper( child: SearchView()),
                KeepAliveWrapper( child: SearchView()),
                KeepAliveWrapper( child: UserView()),
              ])),
    );
  }

  Widget _buildHomeView() {
    return Scaffold(
      body: AnnotatedRegion(
        child: WeSlide(
          controller: controller.weSlideController,
          panelMaxSize: MediaQuery.of(Get.context).size.height,
          panelMinSize: 120.0,
          body: _buildContent(),
          parallax: true,
          panel: DefaultView(weSlideController: controller.weSlideController),
          panelHeader: MusicBottomBarView(
              weSlideController: controller.weSlideController),
          footer: _buildBottomNavigationBar(),
        ),
        value: !Get.isDarkMode
            ? SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: lightTheme.primaryColor,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: darkTheme.primaryColor,
              ),
      ),
    );
  }

  //底部导航栏
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(Get.context).accentColor,
      unselectedItemColor: Theme.of(Get.context).bottomAppBarColor,
      backgroundColor: Theme.of(Get.context).primaryColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      iconSize: 24.0,
      selectedIconTheme: IconThemeData(size: 26.0),
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "top"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "user"),
      ],
      onTap: (index) => controller.changeIndex(index),
      currentIndex: controller.currentIndex.value,
    );
  }
}
