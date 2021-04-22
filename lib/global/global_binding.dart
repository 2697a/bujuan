import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/pages/find/find_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<GlobalController>(GlobalController(),permanent: true);
    Get.put<FindController>(FindController(),permanent: true);
    Get.put<UserController>(UserController(),permanent: true);
  }

}