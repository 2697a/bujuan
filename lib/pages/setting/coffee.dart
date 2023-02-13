import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/app_bar.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/coffee.jpg',width: Get.width,fit: BoxFit.fitWidth,),

          ],
        ),
      ),
    );
  }
}
