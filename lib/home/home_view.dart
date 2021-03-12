import 'package:bujuan/bottom_bar/bottom_bar_view.dart';
import 'package:bujuan/find/find_view.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/setting/setting_binding.dart';
import 'package:bujuan/setting/setting_view.dart';
import 'package:bujuan/user/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildContent());
  }

  Widget _buildContent() {
    return BottomBarView(
      panelController: controller.panelController,
      isShowBottom: true,
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Bujuan"),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Get.to(SettingView(),binding: SettingBinding()),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            // onPageChanged: (index) => controller.changeIndex(index),
            children: [
              FindView(),
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
