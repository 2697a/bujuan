import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:bujuan/widget/stacked_page_view.dart';
import 'package:bujuan/widget/timer/timer_count_down.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          child: PreloadPageView.builder(
            onPageChanged: (index) => controller.onPageChange(index),
            controller: controller.pageController,
            preloadPagesCount: 2,
            // physics: controller.scroller.value
            //     ? ClampingScrollPhysics()
            //     : NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => controller.pages[index],
            itemCount: controller.pages.length,
          )),
    );
  }

  Widget _buildHomeView() {
    return PlayWidgetView(
      _buildContent(),
      isHome: true,
      bottomBar: _buildBottomNavigationBar(),
      appBar: _buildAppBar(),
    );
  }

  ///appBar
  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Hero(
            tag: 'avatar',
            child: Obx(() => Card(
                  margin: EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30.0)),
                  clipBehavior: Clip.antiAlias,
                  child: HomeController.to.userProfileEntity.value != null
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: HomeController
                              .to.userProfileEntity.value.profile.avatarUrl,
                          height: 34.0,
                          width: 34.0,
                        )
                      : Image.asset('assets/images/logo.png',
                          width: 34.0, height: 34.0),
                ))),
        onPressed: () => HomeController.to.goToProfile(),
      ),
      title: _buildSleepClock(),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Get.toNamed('/search'),
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Get.toNamed('/setting');
          },
        )
      ],
    );
  }

  ///睡眠按钮
  Widget _buildSleepClock() {
    return GetBuilder(
      builder: (_) {
        return controller.sleepTime > 0
            ? InkWell(
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.snooze,
                          size: 24.0,
                        )),
                    Countdown(
                      controller: HomeController.to.countdownController,
                      seconds: controller.sleepTime ~/ 1000,
                      build: (BuildContext context, double time) {
                        return Text(
                          '${BuJuanUtil.unix2Time(time.toInt())}',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        );
                      },
                      interval: Duration(milliseconds: 1000),
                      onFinished: () {
                        print('两分钟后停止');
                      },
                    )
                  ],
                ),
                onTap: () => controller.showSleepBottomSheet(),
              )
            : Text('Bujuan');
      },
      init: HomeController.to,
      id: 'sleep',
    );
  }

  ///底部导航栏
  Widget _buildBottomNavigationBar() {
    return GetBuilder(
        init: controller,
        id: 'bottom_bar',
        builder: (_) {
          return TitledBottomNavigationBar(
              reverse: true,
              enableShadow: false,
              currentIndex: HomeController.to.currentIndex,
              // Use this to update the Bar giving a position
              onTap: (index) {
                controller.changeIndex(index);
              },
              items: [
                TitledNavigationBarItem(
                    title: Text('我的'),
                    icon: Icons.nature_people_rounded,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('首页'),
                    icon: Icons.lightbulb,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('排行'),
                    icon: Icons.format_list_numbered_rounded,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                TitledNavigationBarItem(
                    title: Text('本地'),
                    icon: Icons.album,
                    backgroundColor: Theme.of(Get.context).primaryColor),
                // TitledNavigationBarItem(
                //     title: Text('搜索'), icon: Icons.search,backgroundColor: Theme.of(Get.context).primaryColor),
              ]);
        });
  }
}
