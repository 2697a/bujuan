import 'package:bujuan/pages/radio/radio_detail/radio_detail_controller.dart';
import 'package:get/get.dart';

class RadioDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RadioDetailController>(RadioDetailController());
  }

}