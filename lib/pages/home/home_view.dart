import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/widget/bottom_bar/custom_navigation_bar_item.dart';
import 'package:bujuan/widget/bottom_bar/custome_navigation_bar.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _buildHomeView();
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: Obx(()=>PreloadPageView.builder(
            onPageChanged: (index) => controller.onPageChange(index),
            controller: controller.pageController,
            physics: controller.scroller.value
                ? ClampingScrollPhysics()
                : NeverScrollableScrollPhysics(),
            preloadPagesCount: 2,
            itemBuilder: (context, index) => controller.pages[index],
            itemCount: controller.pages.length,
          ))),
    );
  }

  Widget _buildHomeView() {
    return PlayWidgetView(_buildContent(),isHome: true);
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
