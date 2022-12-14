import 'package:flutter/cupertino.dart';

import 'measure_size.dart';

class ClickableListWheelScrollView extends StatefulWidget {
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 600);

  ///  Required. The [child] which the wrapper will target to
  final ListWheelScrollView child;

  /// Required. Must be the same for list and wrapper
  final ScrollController scrollController;

  /// Optional. ListWheelScrollView height
  final double? listHeight;

  /// Required. Height of one child in ListWheelScrollView
  final double itemHeight;

  /// Required. Number of items in ListWheelScrollView
  final int itemCount;

  /// If true the list will scroll on click
  final bool scrollOnTap;

  /// Set a handler for listening to a `tap` event
  final OnItemTapCallback? onItemTapCallback;

  /// sets the duration of the scroll  animation
  final Duration animationDuration;

  /// use for ListWheelChildLoopingList
  final bool loop;

  const ClickableListWheelScrollView({
    Key? key,
    required this.scrollController,
    this.listHeight,
    required this.child,
    required this.itemHeight,
    this.scrollOnTap = true,
    this.onItemTapCallback,
    required this.itemCount,
    this.loop = false,
    this.animationDuration = _defaultAnimationDuration,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClickableListWheelScrollViewState();
}

class _ClickableListWheelScrollViewState
    extends State<ClickableListWheelScrollView> {
  double? _listHeight;
  Offset? _tapUpDetails;

  @override
  void initState() {
    _listHeight = widget.listHeight ?? 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_listHeight == .0) {
      return MeasureSize(
        child: Container(
          child: widget.child,
        ),
        onChange: (value) {
          setState(() {
            _listHeight = value.height;
          });
        },
      );
    }

    return GestureDetector(
      onTap: _onTap,
      onTapUp: (tapUpDetails) {
        _tapUpDetails = tapUpDetails.localPosition;
      },
      child: widget.child,
    );
  }

  double _getClickedOffset() {
    if (_tapUpDetails == null || _listHeight == null) {
      return 0;
    }
    return _tapUpDetails!.dy - (_listHeight! / 2.0);
  }

  int _getClickedIndex() {
    final currentIndex = (widget.scrollController is FixedExtentScrollController) ?
                          (widget.scrollController as FixedExtentScrollController).selectedItem :
                           widget.scrollController.offset ~/ widget.itemHeight;
    final clickOffset = _getClickedOffset();
    final indexOffset = (clickOffset / widget.itemHeight).round();
    final newIndex = currentIndex + indexOffset;

    if (newIndex < 0 || newIndex >= widget.itemCount) {
      return -1;
    }

    if (widget.loop) {
      return newIndex % widget.itemCount;
    } else {
      return newIndex;
    }
  }

  Future<void> _onTap() async {
    if (widget.scrollController is FixedExtentScrollController) {
      await _onFixedExtentScrollControllerTaped();
    } else {
      await _onScrollControllerTaped();
    }
  }

  Future<void> _onScrollControllerTaped() async {
    final offset = _getClickedOffset();
    final scrollOffset = widget.scrollController.offset + offset;

    final index = (scrollOffset / widget.itemHeight).round();
    widget.onItemTapCallback?.call(index);

    if (widget.scrollOnTap) {
      await widget.scrollController.animateTo(index * widget.itemHeight,
          duration: widget.animationDuration, curve: Curves.ease);
    }
  }

  Future<void> _onFixedExtentScrollControllerTaped() async {
    final index = _getClickedIndex();

    if (index < 0) {
      return;
    }

    widget.onItemTapCallback?.call(index);

    if (widget.scrollOnTap) {
      (widget.scrollController as FixedExtentScrollController).animateToItem(
        index,
        duration: widget.animationDuration,
        curve: Curves.ease,
      );
    }
  }
}

typedef OnItemTapCallback = Function(int index);
