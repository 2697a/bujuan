import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'base.dart';

/// A simple day / night switch widget.
class DayNightSwitcher extends DayNightSwitcherBaseWidget {
  /// Creates a new day night switch icon state.
  const DayNightSwitcher({
    @required bool isDarkModeEnabled,
    @required SwitcherStateChangedCallback onStateChanged,
    VoidCallback onLongPress,
    Color dayBackgroundColor,
    Color nightBackgroundColor,
    Color sunColor,
    Color moonColor,
    Color starsColor,
    Color cloudsColor,
    Color cratersColor,
  }) : super(
          isDarkModeEnabled: isDarkModeEnabled,
          onStateChanged: onStateChanged,
          onLongPress: onLongPress,
          dayBackgroundColor: dayBackgroundColor,
          nightBackgroundColor: nightBackgroundColor,
          sunColor: sunColor,
          moonColor: moonColor,
          starsColor: starsColor,
          cloudsColor: cloudsColor,
          cratersColor: cratersColor,
        );

  @override
  State<StatefulWidget> createState() => _DayNightSwitcherState();

  @override
  double get width => 100;

  @override
  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 10);

  @override
  DayNightSwitcher copyWith({
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
  }) =>
      DayNightSwitcher(
        isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
        onStateChanged: onStateChanged ?? this.onStateChanged,
        onLongPress: onLongPress ?? this.onLongPress,
        dayBackgroundColor: dayBackgroundColor ?? this.dayBackgroundColor,
        nightBackgroundColor: nightBackgroundColor ?? this.nightBackgroundColor,
        sunColor: sunColor ?? this.sunColor,
        moonColor: moonColor ?? this.moonColor,
        starsColor: starsColor ?? this.starsColor,
        cloudsColor: cloudsColor ?? this.cloudsColor,
        cratersColor: cratersColor ?? this.cratersColor,
      );
}

/// The day night switch state.
class _DayNightSwitcherState
    extends DayNightSwitcherBaseState<DayNightSwitcher> {
  @override
  CustomPainter createCustomPainter(BuildContext context, double progress) =>
      _DayNightPainter(
        widget: widget,
        progress: progress,
      );
}

/// A simple day / night switch widget (but smaller than the other one).
class DayNightSwitcherIcon extends DayNightSwitcherBaseWidget {
  /// Creates a new day night switch icon state.
  const DayNightSwitcherIcon({
    @required bool isDarkModeEnabled,
    @required SwitcherStateChangedCallback onStateChanged,
    VoidCallback onLongPress,
    Color dayBackgroundColor,
    Color nightBackgroundColor,
    Color sunColor,
    Color moonColor,
    Color starsColor,
    Color cloudsColor,
    Color cratersColor,
  }) : super(
          isDarkModeEnabled: isDarkModeEnabled,
          onStateChanged: onStateChanged,
          onLongPress: onLongPress,
          dayBackgroundColor: dayBackgroundColor,
          nightBackgroundColor: nightBackgroundColor,
          sunColor: sunColor,
          moonColor: moonColor,
          starsColor: starsColor,
          cloudsColor: cloudsColor,
          cratersColor: cratersColor,
        );

  @override
  State<StatefulWidget> createState() => _DayNightSwitcherIconState();

  @override
  double get width => 36;

  @override
  EdgeInsets get padding => const EdgeInsets.symmetric(vertical: 12);

  @override
  DayNightSwitcherIcon copyWith({
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
  }) =>
      DayNightSwitcherIcon(
        isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
        onStateChanged: onStateChanged ?? this.onStateChanged,
        onLongPress: onLongPress ?? this.onLongPress,
        dayBackgroundColor: dayBackgroundColor ?? this.dayBackgroundColor,
        nightBackgroundColor: nightBackgroundColor ?? this.nightBackgroundColor,
        sunColor: sunColor ?? this.sunColor,
        moonColor: moonColor ?? this.moonColor,
        starsColor: starsColor ?? this.starsColor,
        cloudsColor: cloudsColor ?? this.cloudsColor,
        cratersColor: cratersColor ?? this.cratersColor,
      );
}

/// The day night switch state.
class _DayNightSwitcherIconState
    extends DayNightSwitcherBaseState<DayNightSwitcherIcon> {
  @override
  CustomPainter createCustomPainter(BuildContext context, double progress) =>
      _DayNightIconPainter(
        widget: widget,
        progress: progress,
      );
}

/// The day / night widget painter.
class _DayNightPainter extends CustomPainter {
  /// The base widget.
  final DayNightSwitcherBaseWidget widget;

  /// The widget inner padding.
  final double padding;

  /// The progress.
  final double progress;

  /// Creates a new day / night painter instance.
  const _DayNightPainter({
    @required this.widget,
    this.padding = 5,
    @required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.height / 2;

    double sunLeft = (size.width - 2 * (radius));
    double left = progress * sunLeft + radius;

    double top = radius;
    Color backgroundColor = Color.lerp(
        widget.dayBackgroundColor, widget.nightBackgroundColor, progress);

    Rect background = Rect.fromLTWH(0, 0, size.width, size.height);
    RRect shape = RRect.fromRectAndRadius(background, Radius.circular(radius));

    canvas.clipRRect(shape, doAntiAlias: true);
    canvas.drawRect(
      background,
      Paint()..color = backgroundColor,
    );

    drawCloud(canvas, size, sunLeft);
    drawCloud(canvas, size, sunLeft, 2.5, 2);

    canvas.drawCircle(
      Offset(left, top),
      radius - padding,
      Paint()..color = Color.lerp(widget.sunColor, widget.moonColor, progress),
    );

    drawCloud(canvas, size, sunLeft, 4, 4, 2);

    drawCrater(canvas, radius, left);
    drawCrater(canvas, radius, left, 12, 1);

    canvas.drawCircle(
      Offset(left - radius * 2 + padding * 2 + progress * radius,
          top - (progress / 2) * radius + padding),
      radius - padding,
      Paint()..color = backgroundColor,
    );

    drawStar(canvas, size);
    drawStar(canvas, size, 4, 2);
    drawStar(canvas, size, 1.5, 2.3, size.height / 15);
  }

  @override
  bool shouldRepaint(_DayNightPainter oldDelegate) =>
      progress != oldDelegate.progress || padding != oldDelegate.padding;

  /// Draws a cloud.
  void drawCloud(Canvas canvas, Size size, double sunLeft,
      [double topDivisor = 10,
      double moonLeftDivisor = 8,
      double sunLeftDivisor = 1.8]) {
    double height = size.height / 10;
    double width = size.width / 2.5;

    canvas.drawOval(
      Rect.fromLTWH(
        lerpDouble(sunLeft + padding - (size.width / sunLeftDivisor),
            padding + (size.width / moonLeftDivisor), progress),
        padding + size.height / topDivisor,
        lerpDouble(width, height, progress),
        height,
      ),
      Paint()..color = widget.cloudsColor,
    );
  }

  /// Draws a star.
  void drawStar(Canvas canvas, Size size,
      [double topDivisor = 1.4, double leftDivisor = 5, double radius]) {
    canvas.drawCircle(
      Offset(size.width / leftDivisor, size.height / topDivisor),
      lerpDouble(0.0, radius ?? size.height / 10, progress),
      Paint()..color = widget.starsColor,
    );
  }

  /// Draws a moon crater.
  void drawCrater(Canvas canvas, double radius, double left,
      [double leftDivisor = 2, double topDivisor = 2]) {
    canvas.drawCircle(
      Offset(left + radius / leftDivisor, padding + radius / topDivisor),
      radius / 5,
      Paint()
        ..color =
            Color.lerp(Colors.transparent, widget.cratersColor, progress),
    );
  }
}

class _DayNightIconPainter extends CustomPainter {
  /// The base widget.
  final DayNightSwitcherBaseWidget widget;

  /// The widget inner padding.
  final double padding;

  /// The progress.
  final double progress;

  /// Creates a new day / night icon painter instance.
  const _DayNightIconPainter({
    @required this.widget,
    this.padding = 5,
    @required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.height / 2;
    Offset center = Offset(size.width / 2, radius);
    Color backgroundColor = Color.lerp(
        widget.dayBackgroundColor, widget.nightBackgroundColor, progress);

    canvas.clipRRect(RRect.fromRectAndRadius(
        Rect.fromCircle(center: center, radius: radius),
        Radius.circular(radius)));

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = backgroundColor,
    );

    canvas.drawCircle(
      Offset((size.width / 2), radius),
      radius - padding,
      Paint()..color = Color.lerp(widget.sunColor, widget.moonColor, progress),
    );

    drawCrater(canvas, size);
    drawCrater(canvas, size, 11, 1.6, 1.6);

    drawCloud(canvas, size, 12, 2.6);
    drawCloud(canvas, size);

    canvas.drawCircle(
      Offset(progress * (size.width / 3), progress * (size.height / 3)),
      radius - (padding * 1.1),
      Paint()..color = backgroundColor,
    );
  }

  /// Draws a cloud.
  void drawCloud(Canvas canvas, Size size,
      [double leftDivisor = 7,
      double topDivisor = 2,
      double heightDivisor = 10,
      double widthDivisor = 2]) {
    canvas.drawOval(
      Rect.fromLTWH(
        size.width / leftDivisor,
        size.height / topDivisor,
        size.width / widthDivisor,
        size.height / heightDivisor,
      ),
      Paint()
        ..color = Color.lerp(widget.cloudsColor, Colors.transparent, progress),
    );
  }

  /// Draws a moon crater.
  void drawCrater(Canvas canvas, Size size,
      [double radiusDivisor = 8,
      double heightDivisor = 2.5,
      double widthDivisor = 3]) {
    canvas.drawCircle(
      Offset(size.width / widthDivisor, size.height / heightDivisor),
      size.height / radiusDivisor,
      Paint()
        ..color =
            Color.lerp(Colors.transparent, widget.cratersColor, progress),
    );
  }

  @override
  bool shouldRepaint(_DayNightIconPainter oldDelegate) =>
      progress != oldDelegate.progress || padding != oldDelegate.padding;
}
