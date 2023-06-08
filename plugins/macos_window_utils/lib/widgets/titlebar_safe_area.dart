import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:macos_window_utils/macos_window_utils.dart';

class _MacOSTitlebarSafeArea extends StatefulWidget {
  final Widget child;

  const _MacOSTitlebarSafeArea({Key? key, required this.child})
      : super(key: key);

  @override
  State<_MacOSTitlebarSafeArea> createState() => _MacOSTitlebarSafeAreaState();
}

class _MacOSTitlebarSafeAreaState extends State<_MacOSTitlebarSafeArea> {
  double _titlebarHeight = 0.0;

  /// Updates the height of the titlebar, if necessary.
  Future<void> _updateTitlebarHeight() async {
    final newTitlebarHeight = await WindowManipulator.getTitlebarHeight();
    if (_titlebarHeight != newTitlebarHeight) {
      setState(() {
        _titlebarHeight = newTitlebarHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateTitlebarHeight();

    return Padding(
      padding: EdgeInsets.only(top: _titlebarHeight),
      child: widget.child,
    );
  }
}

class TitlebarSafeArea extends StatelessWidget {
  final Widget child;

  /// A widget that provides a safe area for its child.
  ///
  /// The safe area is the area of the window that is not covered by the
  /// window's title bar. This widget has no effect when the full-size content
  /// view is disabled or when the app is running on a platform other than
  /// macOS.
  ///
  /// Example:
  /// ```dart
  /// TitlebarSafeArea(
  ///  child: Text('Hello World'),
  /// )
  /// ```
  const TitlebarSafeArea({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Platform.isMacOS) return child;

    return _MacOSTitlebarSafeArea(child: child);
  }
}
