import 'package:bujuan/find/find_controller.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/login/login_controller.dart';
import 'package:bujuan/play_list/play_list_controller.dart';
import 'package:bujuan/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GlobalController>(() => GlobalController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<PlayListController>(() => PlayListController());
    Get.lazyPut<FindController>(() => FindController());
    Get.lazyPut<UserController>(() => UserController());
  }

}