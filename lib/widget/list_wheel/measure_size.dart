import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: _widgetKey,
      child: widget.child,
    );
  }

  void postFrameCallback(_) {
    final context = _widgetKey.currentContext;
    if (context == null) {
      return;
    }

    final newSize = context.size;
    if (_oldSize == newSize) {
      return;
    }
    _oldSize = newSize;
    widget.onChange(newSize!);
  }
}
