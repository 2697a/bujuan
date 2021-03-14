import 'package:bujuan/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: [SwitchListTile(title: Text("夜间模式"), value: controller.isDark.value, onChanged: (value) => controller.changeTheme()),SleekCircularSlider(
          appearance: CircularSliderAppearance(
              size: MediaQuery.of(Get.context).size.width / 1.4,
              startAngle: 45,
              angleRange: 300,
              customColors: CustomSliderColors(
                  trackColor: Colors.grey.withOpacity(.6),
                  progressBarColor: Color.fromRGBO(220, 190, 251, 1)),
              customWidths:
              CustomSliderWidths(trackWidth: 1, progressBarWidth: 4)),
          min: 0,
          max: 100,
          initialValue: 20,
          innerWidget: (value) =>Container(
            margin: EdgeInsets.all(6.0),
          ),
        ),],
      ),
    ));
  }
}
