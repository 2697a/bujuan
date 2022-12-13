import 'package:bujuan/pages/home/first/first_controller.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/pages/login/login_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:get/get.dart';

import '../play_list/playlist_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FirstController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => PlayListController());
    Get.lazyPut(() => LoginController());
  }
}