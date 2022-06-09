import 'package:bujuan/common/constants/colors.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:bujuan/widget/left_menu/menu_item.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LeftMenu extends StatefulWidget {
  const LeftMenu({Key? key}) : super(key: key);

  @override
  LeftMenuState createState() => LeftMenuState();
}

class LeftMenuState extends State<LeftMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double height;
  late double width;
  double backgroundOpacity = 0;
  final List<MenuItemData> _menuItemData = [
    MenuItemData('首页', Icons.home_filled, select: true, onTap: () => Get.toNamed(Routes.index)),
    MenuItemData('我的', Icons.supervised_user_circle_rounded, onTap: () => Get.toNamed(Routes.user)),
    MenuItemData(
      '云盘',
      Icons.cloud,
    ),
    MenuItemData(
      '本地',
      Icons.local_attraction,
    ),
  ];

  //出事花动画
  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 500,
      ),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );
    _startAnimation();
  }

  //开始动画
  void _startAnimation() {
    _controller.forward();
    _animation.addListener(() {
      setState(() {
        backgroundOpacity = 0.7 * _animation.value;
      });
    });
  }

  void _onCollapseTap() {
    if (HomeController.to.isCollapsed.value) {
      Future.delayed(
          const Duration(milliseconds: 100),
          () => setState(() {
                HomeController.to.isCollapsedAfterSec.value = !HomeController.to.isCollapsedAfterSec.value;
              }));
    } else {
      HomeController.to.isCollapsedAfterSec.value = !HomeController.to.isCollapsedAfterSec.value;
    }
    setState(() {
      HomeController.to.isCollapsed.value = !HomeController.to.isCollapsed.value;
    });
  }

  //停止动画
  void _stopAnimation() {
    _controller.stop();
  }

  //反转动画
  void _reverseAnimation() {
    _controller.reverse();
  }

  @override
  void initState() {
    _initializeAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: Get.height,
      width: HomeController.to.isCollapsed.value ? 120.w : 300.w,
      // constraints: BoxConstraints(minWidth: 12),
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: SimpleExtendedImage.avatar(
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-vo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3D0efa92278544ebf86d246c3becc9fb1c%2F8b82b9014a90f603161737633b12b31bb051ed6b.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1657277594&t=3e65a7e9a2ce4d736964bc7450c854f5',
                    width: 90.w,
                    height: 90.w,
                  ),
                  onTap: () => _onCollapseTap(),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => InkWell(
              child:
                  MenuItemView(menuItem: _menuItemData[index], isCollapsed: HomeController.to.isCollapsed.value, isCollapsedAfterSec: HomeController.to.isCollapsedAfterSec.value),
              onTap: () {
                setState(() {
                  for (var element in _menuItemData) {
                    element.select = false;
                  }
                  _menuItemData[index].select = true;
                  _menuItemData[index].onTap?.call();
                });
              },
            ),
            itemCount: _menuItemData.length,
          )),
          IconButton(onPressed: () => Get.changeTheme(AppTheme.dark), icon:  Icon(Icons.settings,color: Colors.black.withOpacity(.5),)),
        ],
      ),
    );
  }
}
