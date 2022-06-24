import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends GetView {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
    );
  }
}
