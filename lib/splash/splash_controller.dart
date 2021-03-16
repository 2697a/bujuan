import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashController extends GetxController {
  List<PageViewModel> modes;

  @override
  void onInit() {
    modes = [
      PageViewModel(
        titleWidget: SizedBox(height: 100.0),
        body:
            "桃李春风一杯酒，江湖夜雨十年灯。",
        image: Image.asset(
          "assets/images/p_one.png",
          height: 267.0,
          width: 400.0,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(color: Theme.of(Get.context).accentColor),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ),
      PageViewModel(
          titleWidget: SizedBox(height: 100.0),
          body:
              "绿蚁新醅酒，红泥小火炉。晚来天欲雪，能饮一杯无？",
          image: Image.asset(
            "assets/images/p_two.png",
            height: 267.0,
            width: 400.0,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(color: Theme.of(Get.context).accentColor),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          )),
      PageViewModel(
          titleWidget: SizedBox(height: 100.0),
          body:
              "少年听雨歌楼上，红烛昏罗帐。壮年听雨客舟中，江阔云低、断雁叫西风。",
          image: Image.asset(
            "assets/images/p_three.png",
            height: 267.0,
            width: 400.0,
          ),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(color: Theme.of(Get.context).accentColor),
            bodyTextStyle:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ))
    ];
    super.onInit();
  }
}
