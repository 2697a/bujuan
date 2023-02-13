import 'package:flutter/material.dart';

/// Drawer State enum
/// Note: Upon Drawer dragging the state is always opening
/// Use [DrawerLastAction] to figure if last state was either opened or closed
enum DrawerState { opening, closing, open, closed }

/// Drawer last action enum
/// To detect last action from drawer if it was opened or closed.
enum DrawerLastAction { open, closed }

class ZoomDrawerController {
  /// Open drawer
  void Function()? open;

  /// Close drawer
  void Function()? close;

  /// Toggle drawer
  void Function({bool forceToggle})? toggle;

  /// Determine if status of drawer equals to Open
  bool Function()? isOpen;

  /// Drawer state notifier
  /// opening, closing, open, closed
  ValueNotifier<DrawerState>? stateNotifier;
}

enum DrawerStyle {
  defaultStyle,
  style1,
  style2,
  style3,
  style4,
}

/// Build custom style with (context, animationValue, slideWidth, menuScreen, mainScreen) {}
typedef DrawerStyleBuilder = Widget Function(
  BuildContext context,
  double animationValue,
  double slideWidth,
  Widget menuScreen,
  Widget mainScreen,
);
