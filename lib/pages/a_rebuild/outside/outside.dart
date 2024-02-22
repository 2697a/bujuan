import 'package:bujuan/pages/a_rebuild/outside/panel.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'menu.dart';

final slideProvider = StateProvider<double>((ref) => 0.0);
final panelController = Provider((ref) => PanelController());
final zoomController = Provider((ref) => ZoomDrawerController());

class Outside extends ConsumerWidget {
  final Widget child;

  const Outside({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ZoomDrawer(
        dragOffset: 260.w,
        menuBackgroundColor: Colors.green,
        slideWidth: 750.w * .7,
        menuScreenWidth: 750.w * .7,
        mainScreenScale: 0.2,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        showShadow: true,
        mainScreenTapClose: true,
        menuScreenTapClose: true,
        androidCloseOnBackTap: true,
        drawerShadowsBackgroundColor: const Color(0xFFBEBBBB),
        controller: ref.read(zoomController),
        menuScreen: const MenuPage(),
        mainScreen: SlidingUpPanel(
          body: child,
          color: Colors.transparent,
          parallaxEnabled: true,
          parallaxOffset: .03,
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: 150.w,
          onPanelSlide: (double position) => ref.refresh(slideProvider.notifier).state = position,
          panel: const Panel(),
          controller: ref.read(panelController),
        ),
      ),
    );
  }
}
