import 'package:bujuan/pages/index/index_controller.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
  }

}