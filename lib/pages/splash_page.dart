import 'dart:async';
import 'package:bujuan/pages/home/first/first_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
  final OnAudioQuery onAudioQuery = GetIt.instance<OnAudioQuery>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeOpacity();
    });

    Future.delayed(durationFinish, () {
      requestPermission().then((value) => {if (value) Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const FirstView()))});
    });
  }

  Future<bool> requestPermission() async {
    bool permissionStatus = await onAudioQuery.permissionsStatus();
    if (!permissionStatus) {
      permissionStatus = await onAudioQuery.permissionsRequest();
    }
    return permissionStatus;
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
                  SvgPicture.asset('assets/images/splash.svg',width: Get.width/1.8,fit: BoxFit.fitWidth,),
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
