import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constants/colors.dart';
import '../index/album_view.dart';
import '../index/index_view.dart';
import '../user/user_view.dart';

class HomeMobileView extends GetView<HomeController> {
  const HomeMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Container(
            width: double.infinity,
            height: 86.w,
            decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.circular(43.w),
                boxShadow:  const [
                  BoxShadow(
                    color: Color(0x13000000),
                    blurRadius: 5,
                  ),
                ]
            ),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),child: SimpleExtendedImage(
                  'https://img0.baidu.com/it/u=3849465600,224519353&fm=253&fmt=auto&app=138&f=PNG?w=500&h=499',
                  width: 68.w,
                  height: 68.w,
                  borderRadius: BorderRadius.circular(41.w),
                ),),
                Expanded(child: Text(' 点击搜索...',style: TextStyle(fontSize: 30.sp,color: Colors.grey,fontWeight: FontWeight.w500),))
              ],
            ),
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
      ),
      title: "Application",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      // 开启FPS监控
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      routingCallback: (Routing? r){
        HomeController.to.changeRoute(r?.current);
      },
    );
  }
}
