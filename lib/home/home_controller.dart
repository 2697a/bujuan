import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  PageController pageController;
  var isDarkTheme = false.obs;
  var bottomHeight = 58.0.obs;
  PanelController panelController;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);
    panelController = PanelController();
    super.onInit();
  }

  void changeTheme(){
    Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
    SpUtil.putBool(IS_DARK_SP, !Get.isDarkMode);
  }

  @override
  void onClose() {
    pageController?.dispose();
    super.onClose();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void changeHide(double bottomHeight) {
    this.bottomHeight.value = bottomHeight;
  }
}
