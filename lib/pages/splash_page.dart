import 'dart:async';
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
  double scale = 1;
  Duration duration = const Duration(milliseconds: 2000);
  Duration durationFinish = const Duration(milliseconds: 2200);
  bool isFinish = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeOpacity();
    });

    Future.delayed(durationFinish, () {
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
      ),
    );
  }
}
