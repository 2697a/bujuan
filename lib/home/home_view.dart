import 'package:bujuan/find/find_view.dart';
import 'package:bujuan/keep.dart';
import 'package:bujuan/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/play_view/default_view.dart';
import 'package:bujuan/search/search_view.dart';
import 'package:bujuan/user/user_view.dart';
import 'package:bujuan/widget/mini_nav_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:we_slide/we_slide.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _buildHomeView();
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text('Bujuan'),
          leading: Obx(()=>IconButton(
            icon: Hero(
                tag: 'avatar',
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(30.0)),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: controller.userProfileEntity.value != null ? controller.userProfileEntity.value.profile.avatarUrl : 'https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg',
                    height: 30.0,
                    width: 30.0,
                  ),
                )),
            onPressed: () => controller.goToProfile(),
          )),
          actions: [
            IconButton(icon: Icon(Icons.settings), onPressed: () => Get.toNamed('/setting')),
          ]),
      body: Container(
          padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
          child: Column(
            children: [
              Obx(()=>_buildNavigationBarq(!controller.bottomBar.value)),
              Expanded(child: PreloadPageView(controller: controller.pageController,
                  // physics: BouncingScrollPhysics(),
                  preloadPagesCount: 4,
                  onPageChanged: (index)async => controller.changeIndex2(index),
                  children: [
                    KeepAliveWrapper(child: UserView()),
                    KeepAliveWrapper(child: FindView()),
                    KeepAliveWrapper(child: SearchView()),
                    KeepAliveWrapper(child: SearchView()),
                  ]))
            ],
          )),
    );
  }

  Widget _buildHomeView() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WeSlide(
        controller: controller.weSlideController,
        panelMaxSize: MediaQuery.of(Get.context).size.height,
        panelMinSize: 65.0,
        footerOffset: 0,
        overlayColor: Colors.transparent,
        panelBackground: Colors.transparent,
        body: _buildContent(),
        parallax: true,
        panel: DefaultView(weSlideController: controller.weSlideController),
        panelHeader: MusicBottomBarView(weSlideController: controller.weSlideController),
        // footer: Obx(()=>_buildNavigationBarq(controller.bottomBar.value)),
      ),
    );
  }

  //底部导航栏
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(Get.context).accentColor,
      unselectedItemColor: Theme.of(Get.context).bottomAppBarColor,
      backgroundColor: Theme.of(Get.context).primaryColor,
      type: BottomNavigationBarType.shifting,
      elevation: 0.0,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'top'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'user'),
      ],
      onTap: (index) => controller.changeIndex(index),
      currentIndex: controller.currentIndex.value,
    );
  }

  Widget _buildNavigationBarq(isBottom){
    return isBottom?MinNiNavBar(
        items: [
          BottomMiniNavyBarItem(
            activeColor: const Color.fromRGBO(213, 15, 37, 1),
          ),
          BottomMiniNavyBarItem(activeColor: const Color.fromRGBO(238, 178, 17, 1)),
          BottomMiniNavyBarItem(
            activeColor: const Color.fromRGBO(0, 153, 37, 1),
          ),
          BottomMiniNavyBarItem(
            activeColor: const Color.fromRGBO(66, 153, 244, 1),
          ),
        ],
        showElevation: false,
        selectedIndex: controller.currentIndex1.value,
        onItemSelected: (index) {
        }):Container(height: 0,color:Theme.of(Get.context).primaryColor);
  }

}
