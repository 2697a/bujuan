import 'package:bujuan/pages/top/top_controller.dart';
import 'package:get/get.dart';

class TopBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TopController>(() => TopController());
  }

}