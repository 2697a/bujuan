import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/weslide/panel.dart';

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late PanelController panelController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w),color: Colors.white),
      child: Column(
        children: [
          PlayBar(
            animationController: animationController,
          ),
        ],
      ),
    );
  }
}

class PlayBar extends ConsumerWidget {
  final AnimationController animationController;

  const PlayBar({super.key, required this.animationController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        margin: EdgeInsets.only(top: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                animationController.value = ref.watch(slideProvider.notifier).state;
                return AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) => ClipRRect(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top * animationController.value,
                          left: 30.w*animationController.value
                      ),
                      width: 80.w + (550.w * animationController.value),
                      height: 80.w + (550.w * animationController.value),
                      child: child,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.w),
                    child: SimpleExtendedImage(
                      'https://i.pinimg.com/originals/b0/c7/4c/b0c74c7ee7805c38b5c00950638c7ea4.jpg',
                      width: 630.w,
                      height: 630.w,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      onTap: () {
        if (ref.read(panelController).isPanelClosed) {
          ref.read(panelController).open();
        }
      },
    );
  }
}
