import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tabler_icons/tabler_icons.dart';

import '../../common/constants/colors.dart';

class HomeMobileView extends GetView<HomeController> {
  const HomeMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   leadingWidth: 0,
        //   title: Row(
        //     children: [
        //       Image.asset(
        //         'assets/images/logo.png',
        //         width: 68.w,
        //         height: 68.w,
        //       ),
        //       const Expanded(child: Text('  Juan')),
        //     ],
        //   ),
        //   actions: [
        //     IconButton(
        //       onPressed: () => Get.toNamed(Routes.setting),
        //       icon: const Icon(TablerIcons.settings),
        //     )
        //   ],
        // ),
        body:  SafeArea(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemBuilder: (context, index) => controller.pages[index],
            itemCount: controller.pages.length,
          ),
        ),
      ),
      title: "Application",
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // showPerformanceOverlay: true,
      // debugShowCheckedModeBanner: false,
      // 开启FPS监控
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
      routingCallback: (Routing? r) {
        HomeController.to.changeRoute(r?.current);
      },
    );
  }
}
