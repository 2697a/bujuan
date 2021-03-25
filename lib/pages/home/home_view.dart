
import 'package:bujuan/pages/find/find_view.dart';
import 'package:bujuan/widget/keep.dart';
import 'package:bujuan/pages/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/pages/play_view/default_view.dart';
import 'package:bujuan/pages/search/search_view.dart';
import 'package:bujuan/pages/top/top_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/widget/bottom_bar/custom_navigation_bar_item.dart';
import 'package:bujuan/widget/bottom_bar/custome_navigation_bar.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:we_slide/we_slide.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _buildHomeView();
  }

  // Widget _buildContent() {
  //   return Scaffold(
  //     appBar: AppBar(
  //         elevation: 0,
  //         title: Text('Bujuan'),
  //         leading: Obx(()=>IconButton(
  //           icon: Hero(
  //               tag: 'avatar',
  //               child: Card(
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(30.0)),
  //                 clipBehavior: Clip.antiAlias,
  //                 child: CachedNetworkImage(
  //                   fit: BoxFit.cover,
  //                   imageUrl: controller.userProfileEntity.value != null ? controller.userProfileEntity.value.profile.avatarUrl : 'https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg',
  //                   height: 30.0,
  //                   width: 30.0,
  //                 ),
  //               )),
  //           onPressed: () => controller.goToProfile(),
  //         )),
  //         actions: [
  //           IconButton(icon: Icon(Icons.settings), onPressed: () => Get.toNamed('/setting')),
  //         ]),
  //     body: Container(
  //         padding: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
  //         child: PreloadPageView(controller: controller.pageController,
  //             // physics: BouncingScrollPhysics(),
  //             preloadPagesCount: 1,
  //             onPageChanged: (index)async => controller.changeIndex2(index),
  //             children: [
  //               KeepAliveWrapper(child: UserView()),
  //               KeepAliveWrapper(child: FindView()),
  //               KeepAliveWrapper(child: SearchView()),
  //               KeepAliveWrapper(child: SearchView()),
  //             ])),
  //   );
  // }
  Widget _buildContent() {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: Hero(
                tag: 'avatar',
                child: Obx(() => Card(
                      margin: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(30.0)),
                      clipBehavior: Clip.antiAlias,
                      child: controller.userProfileEntity.value != null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.userProfileEntity.value.profile.avatarUrl,
                              height: 34.0,
                              width: 34.0,
                            )
                          : Image.asset('assets/images/logo.png', width: 34.0, height: 34.0),
                    ))),
            onPressed: () => controller.goToProfile(),
          ),
          title: Text("Bujuan"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Get.toNamed('/setting'),
            )
          ],
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ScrollConfiguration(behavior: OverScrollBehavior(),child: PreloadPageView(controller: controller.pageController, physics: controller.scroller.value ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(), preloadPagesCount: 1, children: [
            KeepAliveWrapper(child: UserView()),
            KeepAliveWrapper(child: FindView()),
            KeepAliveWrapper(child: TopView()),
            KeepAliveWrapper(child: SearchView()),
          ]),),
        ))
      ],
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(Get.context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      padding: EdgeInsets.symmetric(horizontal: 1.0),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      shadowColor: Theme.of(Get.context).accentColor.withOpacity(.1),
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      elevation: 1,
      iconColor: Theme.of(Get.context).bottomAppBarColor,
      // width: isPortrait ? 600 : 500,
      borderRadius: BorderRadius.circular(12.0),
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Hero(
                tag: 'avatar',
                child: Obx(() => Card(
                      margin: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(30.0)),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.userProfileEntity.value != null ? controller.userProfileEntity.value.profile.avatarUrl : 'https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg',
                        height: 30.0,
                        width: 30.0,
                      ),
                    ))),
            onPressed: () => controller.goToProfile(),
          ),
        ),
        FloatingSearchBarAction.back(
          showIfClosed: false,
        ),
      ],
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed('/setting'),
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Container(
              height: 300,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHomeView() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => WeSlide(
            controller: controller.weSlideController,
            panelMaxSize: MediaQuery.of(Get.context).size.height,
            panelMinSize: controller.scroller.value ? 62.0 : 118.0,
            footerOffset: controller.scroller.value ? 0 : 56.0,
            overlayColor: Colors.transparent,
            panelBackground: Colors.transparent,
            body: _buildContent(),
            parallax: true,
            panel: DefaultView(weSlideController: controller.weSlideController),
            panelHeader: MusicBottomBarView(weSlideController: controller.weSlideController),
            footer: controller.scroller.value ? Container() : _buildNavigationBarq(),
          )),
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
      iconSize: 26.0,
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

  Widget _buildNavigationBarq() {
    return CustomNavigationBar(
      iconSize: 28.0,
      selectedColor: Theme.of(Get.context).accentColor,
      strokeColor: Theme.of(Get.context).accentColor.withOpacity(.1),
      unSelectedColor: Theme.of(Get.context).bottomAppBarColor,
      elevation: 0.0,
      backgroundColor: Theme.of(Get.context).canvasColor,
      items: [
        CustomNavigationBarItem(
          icon: Icon(Icons.person_pin),
          selectedIcon: Icon(Icons.person_pin_rounded),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.lightbulb_outline),
          selectedIcon: Icon(Icons.lightbulb),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.whatshot_outlined),
          selectedIcon: Icon(Icons.whatshot),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.music_note_outlined),
          selectedIcon: Icon(Icons.music_note),
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.changeIndex(index);
      },
    );
  }
}
