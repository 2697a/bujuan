import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => IndexController());
  }
}