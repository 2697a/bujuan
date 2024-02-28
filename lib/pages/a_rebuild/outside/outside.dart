import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/a_rebuild/outside/panel.dart';
import 'package:bujuan/widget/weslide/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../common/bujuan_audio_handler.dart';
import '../../../widget/bottom_bar.dart';
import 'menu.dart';

final slideProvider = StateProvider<double>((ref) => 0.0);
final indexProvider = StateProvider<int>((ref) => 0);
final panelController = Provider((ref) => PanelController());
final zoomController = Provider((ref) => ZoomDrawerController());
final routers = Provider<List<String>>((ref) => ['/','/user','/','/login']);
final audioHandler = Provider((ref) => GetIt.instance<BujuanAudioHandler>());
 final provider = StreamProvider((ref) {
  return ref.watch(audioHandler).mediaItem.stream;
});
class Outside extends ConsumerWidget {
  final Widget child;

  const Outside({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('object===============outslider');
    return Scaffold(
      // body: ZoomDrawer(
      //   dragOffset: 260.w,
      //   slideWidth: 750.w * .7,
      //   menuScreenWidth: 750.w * .7,
      //   mainScreenScale: 0.2,
      //   duration: const Duration(milliseconds: 200),
      //   reverseDuration: const Duration(milliseconds: 200),
      //   showShadow: true,
      //   mainScreenTapClose: true,
      //   menuScreenTapClose: true,
      //   androidCloseOnBackTap: true,
      //   drawerShadowsBackgroundColor: const Color(0xFFBEBBBB),
      //   controller: ref.read(zoomController),
      //   menuScreen: const MenuPage(),
      //   mainScreen: SlidingUpPanel(
      //     body: child,
      //     boxShadow: const [],
      //     color: Colors.transparent,
      //     parallaxEnabled: true,
      //     parallaxOffset: .03,
      //     maxHeight: MediaQuery.of(context).size.height,
      //     minHeight: 120.w+65+MediaQuery.of(context).padding.bottom,
      //     onPanelSlide: (double position) => ref.refresh(slideProvider.notifier).state = position,
      //     onPanelOpened: () => ref.refresh(isOpen.notifier).state = true,
      //     onPanelClosed: () => ref.refresh(isOpen.notifier).state = false,
      //     panelBuilder:()=>const Panel(),
      //     controller: ref.read(panelController),
      //     disableDraggableOnScrolling: false,
      //     footer: IgnoreDraggableWidget(child: SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       child: Thebrioflashynavbar(
      //         height: 65,
      //         selectedIndex: selectIndex,
      //         iconSize: 24,
      //         showElevation: true,
      //         onItemSelected: (index) => ref.refresh(indexProvider.notifier).state = index,
      //
      //         items: [
      //           ThebrioflashynavbarItem(
      //             icon: Icon(Icons.event),
      //             title: Text('主页'),
      //           ),
      //           ThebrioflashynavbarItem(
      //             icon: Icon(Icons.search),
      //             title: Text('搜索'),
      //           ),
      //           ThebrioflashynavbarItem(
      //             icon: Icon(Icons.highlight),
      //             title: Text('排行'),
      //           ),
      //           ThebrioflashynavbarItem(
      //             icon: Icon(Icons.settings),
      //             title: Text('设置'),
      //           ),
      //         ],
      //       ),
      //     )),
      //   ),
      // ),
      body: SlidingUpPanel(
        body: child,
        boxShadow: const [],
        color: Colors.transparent,
        parallaxEnabled: true,
        parallaxOffset: .03,
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: 121.w+70+MediaQuery.of(context).padding.bottom,
        onPanelSlide: (double position) => ref.refresh(slideProvider.notifier).state = position,
        onPanelOpened: () => ref.refresh(isOpen.notifier).state = true,
        onPanelClosed: () => ref.refresh(isOpen.notifier).state = false,
        panelBuilder:()=>const Panel(),
        controller: ref.read(panelController),
        disableDraggableOnScrolling: false,
        footerHeight: 70,
        footer: Footer(),
      ),
    );
  }
}

class Footer extends ConsumerWidget{
  const Footer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectIndex = ref.watch(indexProvider.notifier).state;

    print('object===============outslider123123123');
   return IgnoreDraggableWidget(child: SizedBox(
     width: MediaQuery.of(context).size.width,
     child:  Thebrioflashynavbar(
       height: 70,
       selectedIndex: selectIndex,
       iconSize: 24,
       showElevation: true,
       onItemSelected: (index) {
         ref.refresh(indexProvider.notifier).state = index;
         context.go(ref.read(routers)[index]);
       },
       items: [
         ThebrioflashynavbarItem(
           icon: Icon(Icons.event),
           title: Text('主页'),
         ),
         ThebrioflashynavbarItem(
           icon: Icon(Icons.search),
           title: Text('搜索'),
         ),
         ThebrioflashynavbarItem(
           icon: Icon(Icons.highlight),
           title: Text('排行'),
         ),
         ThebrioflashynavbarItem(
           icon: Icon(Icons.settings),
           title: Text('设置'),
         ),
       ],
     ),
   ));
  }

}
