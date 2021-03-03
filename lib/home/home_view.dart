import 'package:bujuan/bottom_bar/bottom_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomBarView(Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.wb_sunny_outlined),
              onPressed: () => controller.changeTheme(),
            )
          ],
        ),
        body: Center(
          child: Text("This is the sliding Widget"),
        ),
      )),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }

  Widget _buildNavigationBar(context) {
    return Obx(() => BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          elevation: 8.0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "history"),
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_outlined), label: "user")
          ],
          onTap: (index) => controller.changeIndex(index),
          currentIndex: controller.currentIndex.value,
        ));
  }
}
