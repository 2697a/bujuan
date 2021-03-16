import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashController extends GetxController{
  List<PageViewModel> modes;
  @override
  void onInit() {
    modes = [
      PageViewModel(
        title: "聆听好音乐",
        body: "Here you can write the description of the page, to explain someting...",
        image: const Center(child: Icon(Icons.android)),
        decoration:  PageDecoration(
          titleTextStyle: TextStyle(color: Theme.of(Get.context).accentColor),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        ),
      ),
      PageViewModel(
        title: "Title of 2 page",
        body: "Here you can write the description of the page, to explain someting...",
        image: const Center(child: Icon(Icons.android)),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(color: Theme.of(Get.context).accentColor),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        )
      ),
      PageViewModel(
        title: "Title of 3 page",
        body: "Here you can write the description of the page, to explain someting...",
        image: const Center(child: Icon(Icons.android)),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(color: Theme.of(Get.context).accentColor),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        )
      )
    ];
    super.onInit();
  }
}