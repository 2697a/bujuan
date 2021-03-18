import 'package:bujuan/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashView extends GetView<SplashController>{
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: controller.modes,
      onDone: () async{
       await Get.offAndToNamed('/home');
      },
      onSkip: () async{
        await Get.offAndToNamed('/home');
      },
      showSkipButton: true,
      skip:  Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).accentColor)),
      next:  Text('Next', style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).accentColor)),
      done:  Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).accentColor)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(8.0),
          activeSize: const Size(16.0, 8.0),
          activeColor: Theme.of(context).accentColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 8.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          )
      ),
    );
  }

}