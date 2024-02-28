//
//
//
// import 'package:flutter/material.dart';
//
// class WDCustomTrackShape extends RoundedRectSliderTrackShape {
//
//   WDCustomTrackShape({this.addHeight = 0});
//   //增加选中滑块的高度,系统默认+2·
//   double addHeight;
//
//   ///去掉默认边距
//   Rect getPreferredRect({
//     required RenderBox parentBox,
//     Offset offset = Offset.zero,
//     required SliderThemeData sliderTheme,
//     bool isEnabled = false,
//     bool isDiscrete = false,
//   }) {
//     final double trackHeight = sliderTheme.trackHeight??1;
//     final double trackLeft = offset.dx;
//     final double trackTop =
//         offset.dy + (parentBox.size.height - trackHeight) / 2;
//     final double trackWidth = parentBox.size.width;
//     return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
//   }
//
//
//   @override
//   void paint(
//       PaintingContext context,
//       Offset offset, {
//         required RenderBox parentBox,
//         required SliderThemeData sliderTheme,
//         required Animation<double> enableAnimation,
//         required TextDirection textDirection,
//         required Offset thumbCenter,
//         bool isDiscrete = false,
//         bool isEnabled = false,
//         double additionalActiveTrackHeight = 0,
//       }) {
//     super.paint(context, offset, parentBox: parentBox,
//         sliderTheme: sliderTheme,
//         enableAnimation: enableAnimation,
//         textDirection: textDirection,
//         thumbCenter: thumbCenter,
//         additionalActiveTrackHeight: addHeight
//     );
//   }
// }