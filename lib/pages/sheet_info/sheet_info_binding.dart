import 'package:bujuan/pages/sheet_info/sheet_info_controller.dart';
import 'package:get/get.dart';

class SheetInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<SheetInfoController>(SheetInfoController());
  }

}