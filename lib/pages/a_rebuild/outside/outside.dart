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
    print('object===============outslider');
    return Scaffold(
      body: ZoomDrawer(
        dragOffset: 260.w,
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
          boxShadow: const [],
          color: Colors.transparent,
          parallaxEnabled: true,
          parallaxOffset: .03,
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: 120.w+MediaQuery.of(context).padding.bottom,
          onPanelSlide: (double position) => ref.refresh(slideProvider.notifier).state = position,
          onPanelOpened: () => ref.refresh(isOpen.notifier).state = true,
          onPanelClosed: () => ref.refresh(isOpen.notifier).state = false,
          panelBuilder:()=>const Panel(),
          controller: ref.read(panelController),
          disableDraggableOnScrolling: false,
          footer: IgnoreDraggableWidget(child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.bottom,
          )),
        ),
      ),
    );
  }
}
