import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomBarController extends GetxController {
  PanelController panelController;

  @override
  void onInit() {
    panelController = PanelController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
