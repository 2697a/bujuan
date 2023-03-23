
import 'package:bujuan/common/constants/platform_utils.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/body_view.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/pages/home/view/panel_view_l.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:bujuan/widget/slider_drawer/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:keframe/keframe.dart';

import '../../../widget/swipeable.dart';
import '../../../widget/weslide/panel.dart';
import '../../../widget/weslide/panel_play_view.dart';
import 'menu_view.dart';

class HomeView extends GetView<Home> {
  final Widget? body;

  const HomeView({
    Key? key,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    double bottomHeight = MediaQuery.of(controller.buildContext).padding.bottom * (PlatformUtils.isIOS ? 0.6 : .85);
    if (bottomHeight == 0) bottomHeight = 25.w;
    return Material(
      child: OrientationBuilder(
          builder: (c, o) => Visibility(
            visible: o == Orientation.portrait,
            replacement: Container(),
            child: ZoomDrawer(
              moveMenuScreen: false,
              menuScreen: const MenuView(),
              mainScreen: SlidingUpPlayViewPanel(
                color: Colors.transparent,
                controller: controller.panelControllerHome,
                onPanelSlide: (value) => controller.changeSlidePosition(value),
                boxShadow: const [BoxShadow(blurRadius: 8.0, color: Color.fromRGBO(0, 0, 0, 0.05))],
                panel: const PanelView(),
                body: const BodyView(),
                minHeight: controller.panelMobileMinSize + bottomHeight,
                maxHeight: Get.height,
              ),
              dragOffset: 360.w,
              angle: 0,
              menuBackgroundColor: controller.leftImageNoObs?Theme.of(context).colorScheme.onSecondary:Theme.of(context).cardColor,
              slideWidth: Get.width * .24,
              mainScreenScale: 0,
              duration: const Duration(milliseconds: 200),
              reverseDuration: const Duration(milliseconds: 200),
              showShadow: true,
              mainScreenTapClose: true,
              menuScreenTapClose: true,
              drawerShadowsBackgroundColor: Colors.grey,
              controller: controller.myDrawerController,
            ),
          )),
    );
  }

}

class LeftMenu {
  String title;
  IconData icon;
  String path;
  String pathUrl;

  LeftMenu(this.title, this.icon, this.path, this.pathUrl);
}
