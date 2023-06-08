import 'package:flutter/material.dart';
import 'package:macos_window_utils/widgets/transparent_macos_sidebar.dart';

class TransparentSidebarAndContent extends StatelessWidget {
  const TransparentSidebarAndContent(
      {super.key,
      required this.isOpen,
      required this.width,
      required this.sidebarBuilder,
      required this.child});

  final bool isOpen;
  final double width;
  final Widget Function() sidebarBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(
              begin: isOpen ? width : 0.0, end: isOpen ? width : 0.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          builder: (BuildContext context, double value, Widget? child) {
            return SizedBox(
              width: value,
              child: SizedBox.expand(
                // The TransparentMacOSSidebar needs to be built inside the
                // TweenAnimationBuilder's `build` method because it needs to be
                // rebuilt whenever its size changes so that the visual effect
                // subview gets updated.
                // If you ever find yourself in a situation where a rebuild
                // cannot be guaranteed, check out the
                // VisualEffectSubviewContainerResizeEventRelay class, which
                // lets you control the sidebar's update behavior manually.
                child: TransparentMacOSSidebar(
                  child: child ?? const SizedBox(),
                ),
              ),
            );
          },
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: OverflowBox(
              minWidth: width,
              maxWidth: width,
              alignment: Alignment.centerLeft,
              child: sidebarBuilder(),
            ),
          ),
        ),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
