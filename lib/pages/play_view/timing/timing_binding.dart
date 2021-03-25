import 'package:bujuan/pages/play_view/timing/timing_controller.dart';
import 'package:get/get.dart';

class TimingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TimingController>(() => TimingController());
  }
  
}