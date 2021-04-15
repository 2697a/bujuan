import 'dart:async';
import 'package:bujuan/widget/timer/timer_controller.dart';
import 'package:flutter/widgets.dart';

///
/// Simple countdown timer.
///
class Countdown extends StatefulWidget {
  /// Length of the timer
  final int seconds;

  /// Build method for the timer
  final Widget Function(BuildContext, double) build;

  /// Called when finished
  final Function onFinished;

  /// Build interval
  final Duration interval;

  /// Controller
  final CountdownController controller;

  ///
  /// Simple countdown timer
  ///
  Countdown({
    Key key,
    @required this.seconds,
    @required this.build,
    this.interval = const Duration(seconds: 1),
    this.onFinished,
    this.controller,
  }) : super(key: key);

  @override
  _CountdownState createState() => _CountdownState();
}

///
/// State of timer
///
class _CountdownState extends State<Countdown> {
  // Multiplier of secconds
  final int _secondsFactor = 1000000;

  // Timer
  Timer _timer;

  // Current seconds
  int _currentMicroSeconds;

  @override
  void initState() {
    _currentMicroSeconds = widget.seconds * _secondsFactor;
    widget.controller?.setOnPause(_onTimerPaused);
    widget.controller?.setOnResume(_onTimerResumed);
    widget.controller?.setOnRestart(_onTimerRestart);
    widget.controller?.setOnSetTimer(_onSetTimer);
    widget.controller?.isCompleted = false;

    _startTimer();

    super.initState();
  }

  void _onSetTimer(int seconds) {
    print('Timer set to $seconds');
    if (mounted)
      setState(() {
        _currentMicroSeconds = seconds * _secondsFactor;
      });
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(
      context,
      _currentMicroSeconds / _secondsFactor,
    );
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    super.dispose();
  }

  ///
  /// Then timer paused
  ///
  void _onTimerPaused() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  ///
  /// Then timer resumed
  ///
  void _onTimerResumed() {
    _startTimer();
  }

  ///
  /// Then timer restarted
  ///
  void _onTimerRestart() {
    widget.controller?.isCompleted = false;

    setState(() {
      _currentMicroSeconds = widget.seconds * _secondsFactor;
    });

    _startTimer();
  }

  ///
  /// Start timer
  ///
  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer.cancel();
      widget.controller?.isCompleted = true;
    }

    if (_currentMicroSeconds != 0) {
      _timer = Timer.periodic(
        widget.interval,
        (Timer timer) {
          if (_currentMicroSeconds == 0) {
            timer.cancel();

            if (widget.onFinished != null) {
              widget.onFinished();
            }

            widget.controller?.isCompleted = true;
          } else {
            setState(() {
              _currentMicroSeconds =
                  _currentMicroSeconds - widget.interval.inMicroseconds;
            });
          }
        },
      );
    }
  }
}
