import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: Obx(() => Scaffold(
            appBar: AppBar(
              title: Text("设置"),
            ),
            body: Column(
              children: [
                Expanded(
                    child: ScrollConfiguration(
                        behavior: OverScrollBehavior(),
                        child: ListView(
                          children: [
                            SwitchListTile(
                              title: Text("夜间模式"),
                              value: controller.isDark.value,
                              onChanged: (value) => controller.changeTheme(value),
                            ),
                            SwitchListTile(
                              title: Text("忽略音频焦点"),
                              subtitle: Text("其他音频应用开始播放时不会自动暂停"),
                              value: controller.isIgnoreAudioFocus.value,
                              onChanged: (value) => controller.toggleAudioFocus(value),
                            ),
                          ],
                        ))),
                Offstage(
                    offstage: !Get.find<HomeController>().login.value,
                    child: ListTile(
                      title: Text(
                        "退出登录",
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () => controller.exit(),
                    ))
              ],
            ),
          )),
      value: !Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: lightTheme.primaryColor,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: darkTheme.primaryColor,
            ),
    );
  }
}
