import 'package:flutter/material.dart';

/// Should be called when a widget state has changed.
typedef SwitcherStateChangedCallback = Function(bool isDarkModeEnabled);

/// The base widget for every day / night switch widget.
abstract class DayNightSwitcherBaseWidget extends StatefulWidget {
  /// Whether the dark mode is currently enabled.
  final bool isDarkModeEnabled;

  /// Called when the state has changed.
  final SwitcherStateChangedCallback onStateChanged;

  /// Triggered when the widget has been long pressed.
  final VoidCallback onLongPress;

  /// The day background color.
  final Color dayBackgroundColor;

  /// The night background color.
  final Color nightBackgroundColor;

  /// The sun color.
  final Color sunColor;

  /// The moon color.
  final Color moonColor;

  /// The stars color.
  final Color starsColor;

  /// The clouds color.
  final Color cloudsColor;

  /// The craters color.
  final Color cratersColor;

  /// Creates a new day / night switcher base widget instance.
  const DayNightSwitcherBaseWidget({
    @required bool isDarkModeEnabled,
    @required this.onStateChanged,
    this.onLongPress,
    Color dayBackgroundColor,
    Color nightBackgroundColor,
    Color sunColor,
    Color moonColor,
    Color starsColor,
    Color cloudsColor,
    Color cratersColor,
  })  : this.isDarkModeEnabled = isDarkModeEnabled ?? false,
        dayBackgroundColor = dayBackgroundColor ?? const Color(0xFF3498DB),
        nightBackgroundColor = nightBackgroundColor ?? const Color(0xFF192734),
        sunColor = sunColor ?? const Color(0xFFFFCF96),
        moonColor = moonColor ?? const Color(0xFFFFE5B5),
        starsColor = starsColor ?? Colors.white,
        cloudsColor = cloudsColor ?? Colors.white,
        cratersColor = cratersColor ?? const Color(0xFFE8CDA5);

  /// The widget height.
  double get height => 36;

  /// The widget width.
  double get width;

  /// The outer padding.
  EdgeInsets get padding;

  /// Allows to have a copy of this instance with the given parameters.
  DayNightSwitcherBaseWidget copyWith({
    bool isDarkModeEnabled,
    SwitcherStateChangedCallback onStateChanged,
    VoidCallback onLongPress,
    Color dayBackgroundColor,
    Color nightBackgroundColor,
    Color sunColor,
    Color moonColor,
    Color starsColor,
    Color cloudsColor,
    Color cratersColor,
  });
}

/// The base state for every day / night switch widget.
abstract class DayNightSwitcherBaseState<T extends DayNightSwitcherBaseWidget>
    extends State<T> with TickerProviderStateMixin {
  /// The animation controller.
   AnimationController _controller;

  /// The animation instance.
   Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _controller.value = widget.isDarkModeEnabled ? 1.0 : 0.0;
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        widget.onStateChanged(_isDarkModeEnabled);
      }
    });
  }

  @override
  void didUpdateWidget(T oldWidget) {
    if (widget.isDarkModeEnabled != _isDarkModeEnabled) {
      _onTap(sendFeedback: false);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.padding,
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: GestureDetector(
            onLongPress: _onLongPress,
            onTap: _onTap,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => CustomPaint(
                size: Size(widget.width, widget.height),
                painter: createCustomPainter(context, _animation.value),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Creates the corresponding custom painter.
  CustomPainter createCustomPainter(BuildContext context, double progress);

  /// Returns whether dark mode is enabled.
  bool get _isDarkModeEnabled => _animation.value == 1.0;

  /// Triggered when the widget has been long pressed.
  void _onLongPress() {
    if (widget.onLongPress != null) {
      Feedback.forLongPress(context);
      widget.onLongPress();
    }
  }

  /// Triggered when the widget has been tapped.
  void _onTap({bool sendFeedback = true}) {
    if (sendFeedback) {
      Feedback.forTap(context);
    }

    if (_isDarkModeEnabled) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }
}
