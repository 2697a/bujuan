import 'package:bujuan/today/today_controller.dart';
import 'package:get/get.dart';

class TodayBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TodayController>(() => TodayController());
  }

}