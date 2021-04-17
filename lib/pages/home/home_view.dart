import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/bottom_bar/navigation_bar.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:bujuan/widget/timer/timer_count_down.dart';
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
      appBar: _buildAppBar(),
    );
  }

  ///appBar
  Widget _buildAppBar() {
    return SafeArea(child: Container(
      height: 56.0,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(child: GetBuilder(
            builder: (_) => ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:12.0),
                    child: Center(
                      child: Text(
                        controller.itmes[index],
                        style: TextStyle(
                            color: controller.currentIndex == index
                                ? Theme.of(context).bottomAppBarColor
                                : Colors.grey,
                            fontSize: 16,
                            fontWeight: controller.currentIndex == index
                                ? FontWeight.bold
                                : FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onTap: () => controller.changeIndex(index),
                );
              },
              itemCount: controller.itmes.length,
              scrollDirection: Axis.horizontal,
            ),
            init: controller,
            id: 'bottom_bar',
          )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: _buildSleepClock()),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed('/setting');
            },
          )
        ],
      ),
    ));
    return AppBar(
      leadingWidth: 0,
      title: SizedBox(
        height: 56.0,
        child: GetBuilder(
          builder: (_) => ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.only(right:22.0),
                  child: Center(
                    child: Text(
                      controller.itmes[index],
                      style: TextStyle(
                          color: controller.currentIndex == index
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: controller.currentIndex == index
                              ? FontWeight.bold
                              : FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onTap: () => controller.changeIndex(index),
              );
            },
            itemCount: controller.itmes.length,
            scrollDirection: Axis.horizontal,
          ),
          init: controller,
          id: 'bottom_bar',
        ),
      ),
      actions: [

      ],
    );
  }

  ///睡眠按钮
  Widget _buildSleepClock() {
    return GetBuilder(
      builder: (_) {
        return InkWell(
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      right: controller.sleepTime > 0 ? 8.0 : 0),
                  child: Icon(
                    const  IconData(0xe8ae, fontFamily: 'iconfont'),
                    size: 22.0,
                  )),
              Visibility(
                child: Countdown(
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
                ),
                visible: controller.sleepTime > 0,
              )
            ],
          ),
          onTap: () => controller.showSleepBottomSheet(),
        );
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
