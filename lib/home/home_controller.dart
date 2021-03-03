import 'package:bujuan/global/global_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  PageController pageController;
  var isDarkTheme = false.obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    super.onInit();
  }

  void changeTheme() => Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);

  @override
  void onClose() {
    pageController?.dispose();
    super.onClose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    // pageController.jumpToPage(index);
  }
}
