import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
    Get.lazyPut<FindController>(() => FindController());
    Get.lazyPut<UserController>(() => UserController());
  }

}