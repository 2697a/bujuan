import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_view.dart';
import 'package:bujuan/pages/user/user_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../widget/mobile/flashy_navbar.dart';
import '../../widget/weslide/weslide.dart';

class HomeMobileView extends GetView<HomeController> {
  const HomeMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeSlide(
        controller: controller.weSlideController,
        panelWidth: Get.width,
        bodyWidth: Get.width,
        panelMaxSize: Get.height,
        parallax: true,
        backgroundColor: Colors.transparent,
        body: _buildBody(),
        panel: _buildPanel(),
        panelHeader: _buildPanelHeader(),
        footer: _buildFooter(),
        footerHeight: controller.bottomBarHeight.value,
        panelMinSize: controller.panelMobileMinSize.value,
      ),
    );
  }

  Widget _buildBody() {
    return GetMaterialApp(
      color: Colors.lightBlue,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.circularReveal,
      routingCallback: (r) => controller.changeRoute(r?.current),
      home: Padding(padding: EdgeInsets.only(bottom: controller.bottomBarHeight.value),child: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          IndexView(),
          UserView(),
          IndexView(),
          UserView(),
        ],
      ),),
    );
  }

  Widget _buildPanel() {
    return Container(
      width: Get.width,
      color: Colors.white,
      child: Center(
        child: SimpleExtendedImage(
          'https://img0.baidu.com/it/u=3513007513,4003270858&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
          width: 380.w,
          height: 380.w,
          borderRadius: BorderRadius.circular(6.w),
        ),
      ),
    );
  }

  Widget _buildPanelHeader() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(color: Get.theme.bottomAppBarColor, boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          )
        ]),
        height: controller.panelMinSize.value,
        child: Row(
          children: [
            SimpleExtendedImage(
              'https://img0.baidu.com/it/u=3513007513,4003270858&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
              width: 80.w,
              height: 80.w,
              borderRadius: BorderRadius.circular(6.w),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '笑忘书',
                    style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
            IconButton(onPressed: () => Get.toNamed(Routes.index), icon: const Icon(Icons.play_arrow))
          ],
        ),
      ),
      onTap: () => controller.weSlideController.show(),
    );
  }

  Widget _buildFooter() {
    return Obx(() => controller.bottomBarHeight.value == 0
        ? const SizedBox.shrink()
        : FlashyNavbar(
            selectedIndex: controller.selectIndex.value,
            showElevation: false,
            onItemSelected: (index) => controller.changeSelectIndex(index),
            items: [
              FlashyNavbarItem(
                icon: const Icon(Icons.event),
                title: const Text('Events'),
              ),
              FlashyNavbarItem(
                icon: const Icon(Icons.search),
                title: const Text('Search'),
              ),
              FlashyNavbarItem(
                icon: const Icon(Icons.highlight),
                title: const Text('Highlights'),
              ),
              FlashyNavbarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
            ],
          ));
  }
}
