import 'package:bujuan/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }

}