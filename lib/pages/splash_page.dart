import 'dart:async';
import 'dart:io';
import 'package:bujuan/pages/home/home_desktop_view.dart';
import 'package:bujuan/pages/home/home_mobile_view.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  double opacity = 0;
  double scale = 1.0;
  Duration duration = const Duration(milliseconds: 2500);
  Duration durationFinish = const Duration(milliseconds: 3000);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      changeOpacity();
    });

    Future.delayed(durationFinish, () {
      bool isMobile = Platform.isAndroid || Platform.isIOS || Platform.isFuchsia;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => isMobile?const HomeMobileView(): const HomeDesktopView()), (route) => false);
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                Image.asset(
                  'assets/images/splash_bottom.png',
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
                // Container(
                //   alignment: Alignment.bottomCenter,
                //   padding: EdgeInsets.only(bottom: 100.w),
                //   child:  Text('不倦',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 56.sp),),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
