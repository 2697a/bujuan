import 'package:bujuan/pages/setting/donate/donate_controller.dart';
import 'package:get/get.dart';

class DonateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DonateController>(() => DonateController());
  }

}