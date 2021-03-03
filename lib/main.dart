import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import 'global/global_binding.dart';
import 'global/global_theme.dart';
import 'home/home_binding.dart';
import 'home/home_view.dart';

main(List<String> args) {
  if (GetPlatform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  GlobalBinding().dependencies();
  runApp(GetMaterialApp(
    theme: lightTheme,
    enableLog: true,
    initialRoute: "/home",
    getPages: [GetPage(name: "/home", page: () => HomeView(), binding: HomeBinding())],
  ));
}
