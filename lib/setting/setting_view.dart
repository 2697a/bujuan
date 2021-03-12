import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        appBar: AppBar(
          title: Text("设置"),
        ),
        body: ListView(
          children: [SwitchListTile(title: Text("夜间模式"), value: controller.isDark.value, onChanged: (value) => controller.changeTheme())],
        ),
      ),
      value: !controller.isDark.value
          ? SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: lightTheme.primaryColor,
      )
          : SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: darkTheme.primaryColor,
      ),
    ));
  }
}
