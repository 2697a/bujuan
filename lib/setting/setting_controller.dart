import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var isDark = Get.isDarkMode.obs;

  @override
  void onInit() {
    super.onInit();
  }

  changeTheme() {
    Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
    isDark.value = !Get.isDarkMode;
    SpUtil.putBool(IS_DARK_SP, !Get.isDarkMode);
  }
}
