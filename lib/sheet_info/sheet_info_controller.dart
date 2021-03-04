import 'package:bujuan/entity/sheet_details_entity.dart';
import 'package:bujuan/global/global_controller.dart';
import 'package:bujuan/utils/net_utils.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SheetInfoController extends GlobalController {
  PanelController panelController;
  var loadState = 0.obs;
  var result = SheetDetailsPlaylist().obs;

  @override
  void onInit() {
    panelController = PanelController();
    super.onInit();
  }

  getSheetInfo(id) async {
    var sheetDetailsEntity = await NetUtils().getPlayListDetails(id);
    if (sheetDetailsEntity != null && sheetDetailsEntity.code == 200) {
      result.value = sheetDetailsEntity.playlist;
      loadState.value = 2;
    } else {
      loadState.value = 1;
    }
  }
}
