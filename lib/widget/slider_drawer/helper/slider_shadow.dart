import 'package:flutter/widgets.dart';

class SliderBoxShadow {
  final Color color;

  ///[double] you can change blurRadius of shadow by this parameter [blurRadius]
  ///
  final double blurRadius;

  ///[double] you can change spreadRadius of shadow by this parameter [spreadRadius]
  ///
  final double spreadRadius;

  SliderBoxShadow(
      {this.color = const Color(0xFF9E9E9E),
      this.blurRadius = 25.0,
      this.spreadRadius = 5.0});
}
