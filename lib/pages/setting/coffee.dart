import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/app_bar.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const Text('赞助开发者'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.w),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
            ClipRRect(
              borderRadius: BorderRadius.circular(30.w),
              child: Image.asset(
                'assets/images/coffee.jpg',
                width: Get.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6.w)),
                    width: 12.w,
                    height: 12.w,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.w)),
                  Text(
                    '桃花潭水深千尺\n不及汪伦送我情',
                    style: TextStyle(fontSize: 36.sp,height: 1.5),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.w)),
                  Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6.w)),
                    width: 12.w,
                    height: 12.w,
                  ),
                ],
              ),
            ),
            Text('︶',style: TextStyle(fontSize: 36.sp,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
