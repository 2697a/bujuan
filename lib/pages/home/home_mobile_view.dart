import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../index/album_view.dart';
import '../index/index_view.dart';
import '../user/user_view.dart';

class HomeMobileView extends GetView<HomeController> {
  const HomeMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              height: 76.w,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.circular(38.w),
                boxShadow:  const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                  ),
                ]
              ),
            )),
            Padding(padding: EdgeInsets.only(left: 15.w)),
            SimpleExtendedImage(
              'https://img0.baidu.com/it/u=3849465600,224519353&fm=253&fmt=auto&app=138&f=PNG?w=500&h=499',
              width: 70.w,
              height: 70.w,
              borderRadius: BorderRadius.circular(35.w),
            )
          ],
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          AlbumView(),
          IndexView(),
          IndexView(),
          UserView(),
        ],
      ),
    );
  }
}
