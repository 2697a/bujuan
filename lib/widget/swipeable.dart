import 'dart:math' as math;

import 'package:flutter/material.dart';

class Swipeable extends StatefulWidget {
  final Widget child;
  final Widget background;
  final VoidCallback? onSwipeStart;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeCancel;
  final VoidCallback? onSwipeEnd;
  final double threshold;

  const Swipeable({
    super.key,
    required this.child,
    required this.background,
    this.onSwipeStart,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeCancel,
    this.onSwipeEnd,
    this.threshold = 64.0,
  });

  State<StatefulWidget> createState() {
    return _SwipeableState();
  }
}

class _SwipeableState extends State<Swipeable> with TickerProviderStateMixin {
  double _dragExtent = 0.0;
  AnimationController? _moveController;
  Animation<Offset>? _moveAnimation;
  bool _pastLeftThreshold = false;
  bool _pastRightThreshold = false;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _moveAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0)).animate(_moveController!);

    var controllerValue = 0.0;
    _moveController?.animateTo(controllerValue);
  }

  void dispose() {
    _moveController?.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    if (widget.onSwipeStart != null) {
      widget.onSwipeStart?.call();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    var delta = details.primaryDelta;
    var oldDragExtent = _dragExtent;
    _dragExtent += delta!;

    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
      });
    }

    var movePastThresholdPixels = widget.threshold;
    var newPos = _dragExtent.abs() / (context.size?.width ?? 0);

    if (_dragExtent.abs() > movePastThresholdPixels) {
      // how many "thresholds" past the threshold we are. 1 = the threshold 2
      // = two thresholds.
      var n = _dragExtent.abs() / movePastThresholdPixels;

      // Take the number of thresholds past the threshold, and reduce this
      // number
      var reducedThreshold = math.pow(n, 0.3);

      var adjustedPixelPos = movePastThresholdPixels * reducedThreshold;
      newPos = adjustedPixelPos / (context.size?.width ?? 0);

      if (_dragExtent > 0 && !_pastLeftThreshold) {
        _pastLeftThreshold = true;

        if (widget.onSwipeRight != null) {
          widget.onSwipeRight?.call();
        }
      }
      if (_dragExtent < 0 && !_pastRightThreshold) {
        _pastRightThreshold = true;

        if (widget.onSwipeLeft != null) {
          widget.onSwipeLeft?.call();
        }
      }
    } else {
      // Send a cancel event if the user has swiped back underneath the
      // threshold
      if (_pastLeftThreshold || _pastRightThreshold) {
        if (widget.onSwipeCancel != null) {
          widget.onSwipeCancel?.call();
        }
      }
      _pastLeftThreshold = false;
      _pastRightThreshold = false;
    }

    _moveController?.value = newPos;
  }

  void _handleDragEnd(DragEndDetails details) {
    _moveController?.animateTo(0.0, duration: const Duration(milliseconds: 200));
    _dragExtent = 0.0;

    if (widget.onSwipeEnd != null) {
      widget.onSwipeEnd?.call();
    }
  }

  void _updateMoveAnimation() {
    var end = _dragExtent.sign;
    _moveAnimation = Tween<Offset>(begin: const Offset(0.0, 0.0), end: Offset(end, 0.0)).animate(_moveController!);
  }

  Widget build(BuildContext context) {
    var children = <Widget>[
      widget.background,
      SlideTransition(
        position: _moveAnimation!,
        child: widget.child,
      ),
    ];

    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: children,
      ),
    );
  }
}
