import 'package:bujuan/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }

}