// Controller
import 'package:flutter/material.dart';

/// This class used to control animations, using methods like hide or show
class WeSlideController extends ValueNotifier<bool> {
  /// WeSlideController Construction
  // ignore: avoid_positional_boolean_parameters
  WeSlideController({bool initial = false}) : super(initial);

  /// show WeSlide Panel
  void show() => value = true;

  /// hide WeSlide Panel
  void hide() => value = false;

  /// Returns if the WeSlide Panel is opened or not
  bool get isOpened => value;
}