import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';

class SettingController extends GetxController {
  var isDark = Get.isDarkMode.obs;
  var isIgnoreAudioFocus = false.obs;

  @override
  void onReady() {
    var bool = SpUtil.getBool(IS_IGNORE_AUDIO_FOCUS, defValue: false);
    isIgnoreAudioFocus.value = bool;
    super.onReady();
  }

  changeTheme(value) {
    Future.delayed(Duration(milliseconds: 300), () {
      Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
      SpUtil.putBool(IS_DARK_SP, value);
    });
    isDark.value = value;
  }

  toggleAudioFocus(value) async {
    isIgnoreAudioFocus.value = value;
    var i = await Starry.toggleAudioFocus(value);
    if (i == 1) {
      SpUtil.putBool(IS_IGNORE_AUDIO_FOCUS, value);
    }
  }
}
