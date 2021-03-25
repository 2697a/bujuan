import 'package:bujuan/pages/sheet_classify/sheet_classify_controller.dart';
import 'package:get/get.dart';

class SheetClassifyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SheetClassifyController>(() => SheetClassifyController());
  }

}