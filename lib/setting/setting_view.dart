import 'package:bujuan/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("设置"),
          ),
          body: ListView(
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
          ),
        ));
  }
}
