import 'package:bujuan/bottom_bar/bottom_bar_view.dart';
import 'package:bujuan/find/find_view.dart';
import 'package:bujuan/user/user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _buildContent(),
          // bottomNavigationBar: _buildNavigationBar(context),
        ));
  }

  Widget _buildNavigationBar(context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 500),
      child: SingleChildScrollView(
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).bottomAppBarColor,
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          iconSize: 26.0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "top"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "user"),
          ],
          onTap: (index) => controller.changeIndex(index),
          currentIndex: controller.currentIndex.value,
        ),
      ),
      height: controller.bottomHeight.value,
    );
  }

  Widget _buildContent() {
    return BottomBarView(
      panelController: controller.panelController,
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Bujuan"),
          actions: [
            IconButton(
              icon: Icon(Icons.wb_sunny_outlined),
              onPressed: () => controller.changeTheme(),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            // onPageChanged: (index) => controller.changeIndex(index),
            children: [
              FindView(),
              UserView(),
              UserView(),
              UserView(),
            ],
          ),
        ),
      ),
      callBack: (s) {
        // controller.changeHide(58.0*(1-s));
       // if(s==0.0){
       //   controller.changeHide(58.0*(1-s));
       // } else if(s==1.0){
       //   controller.changeHide(58.0*(1-s));
       // }
      },
    );
  }
}
