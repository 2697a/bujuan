import 'dart:math';

import 'package:bujuan/pages/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/pages/play_view/default_view.dart';
import 'package:bujuan/widget/bottom_bar/custom_navigation_bar_item.dart';
import 'package:bujuan/widget/bottom_bar/custome_navigation_bar.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _buildHomeView();
  }

  Widget _buildContent() {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: Hero(
                tag: 'avatar',
                child: Obx(() => Card(
                      margin: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(30.0)),
                      clipBehavior: Clip.antiAlias,
                      child: controller.userProfileEntity.value != null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller
                                  .userProfileEntity.value.profile.avatarUrl,
                              height: 34.0,
                              width: 34.0,
                            )
                          : Image.asset('assets/images/logo.png',
                              width: 34.0, height: 34.0),
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
        ), //The name 'PageMetrics' is defined in the libraries 'package
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: PreloadPageView.builder(
                onPageChanged: (index) => controller.onPageChange(index),
                controller: controller.pageController,
                physics: controller.scroller.value
                    ? ClampingScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                preloadPagesCount: 2,
                itemBuilder: (context, index) => controller.pages[index],
                itemCount: controller.pages.length,
              )),
        ))
      ],
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
            panelHeader: MusicBottomBarView(
                weSlideController: controller.weSlideController),
            footer: controller.scroller.value ? null : _buildBottomNavigationBar(),
          )),
    );
  }

  //底部导航栏

  Widget _buildBottomNavigationBar() {
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
