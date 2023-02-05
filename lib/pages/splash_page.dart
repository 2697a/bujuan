import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../routes/router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  double opacity = 0;
  double scale = 1;
  Duration duration = const Duration(milliseconds: 1000);
  Duration durationFinish = const Duration(milliseconds: 1000);
  bool isFinish = false;
  Map<String, dynamic>? mapData;
  bool noFirst = false;

  // final OnAudioQuery onAudioQuery = GetIt.instance<OnAudioQuery>();

  @override
  void initState() {
    super.initState();
    noFirst = StorageUtil().getBool(noFirstOpen);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Get.isPlatformDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: Get.isPlatformDarkMode ? Brightness.light : Brightness.dark,
      ));
      Future.delayed(const Duration(milliseconds: 1300),() => AutoRouter.of(context).replaceNamed(noFirst ? Routes.home : Routes.guide));
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/splash.svg',
          width: Get.width / 1.8,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
