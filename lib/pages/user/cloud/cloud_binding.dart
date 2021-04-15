import 'package:get/get.dart';

import 'cloud_controller.dart';

class CloudBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<CloudController>(CloudController());
  }

}