import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
  }

}