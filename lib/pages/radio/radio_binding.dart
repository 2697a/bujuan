import 'package:bujuan/pages/radio/radio_controller.dart';
import 'package:get/get.dart';

class RadioBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RadioController>(RadioController());
  }
}
