import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../common/netease_api/src/dio_ext.dart';
import '../routes/router.dart';
// import 'package:on_audio_query/on_audio_query.dart';

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
  Duration duration = const Duration(milliseconds: 2000);
  Duration durationFinish = const Duration(milliseconds: 2200);
  bool isFinish = false;
  Map<String, dynamic>? mapData;
  bool noFirst = false;

  // final OnAudioQuery onAudioQuery = GetIt.instance<OnAudioQuery>();

  @override
  void initState() {
    super.initState();
    noFirst = StorageUtil().getBool(noFirstOpen);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeOpacity();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Get.isPlatformDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness: Get.isPlatformDarkMode ? Brightness.light : Brightness.dark,
      ));
      Future.delayed(durationFinish, () {
        AutoRouter.of(context).replaceNamed(noFirst ? Routes.home : Routes.guide);
      });
    });
  }

  changeOpacity() {
    setState(() {
      opacity = 1;
      scale = 1.15;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: isFinish,
      child: Scaffold(
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: duration,
            child: AnimatedScale(
              scale: scale,
              duration: duration,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/splash.svg',
                    width: Get.width / 1.8,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
