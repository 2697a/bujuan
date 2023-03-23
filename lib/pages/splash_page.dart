import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import '../common/constants/key.dart';
import '../routes/router.dart';
import 'home/home_controller.dart';

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
  String splashBg = '';
  Box box = GetIt.instance<Box>();

  // final OnAudioQuery onAudioQuery = GetIt.instance<OnAudioQuery>();

  @override
  void initState() {
    super.initState();
    splashBg = box.get(splashBackgroundSp, defaultValue: '');
    // noFirst = Home.to.box.get(noFirstOpen);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Get.isPlatformDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: Get.isPlatformDarkMode ? Brightness.light : Brightness.dark,
      ));
      Future.delayed(const Duration(milliseconds: 1300), () => AutoRouter.of(context).replaceNamed(Routes.home));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: splashBg.isEmpty,
        replacement: SimpleExtendedImage(
          splashBg,
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover,
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/splash.svg',
            width: Get.width / 1.8,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
