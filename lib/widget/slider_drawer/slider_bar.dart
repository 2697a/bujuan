import 'package:bujuan/widget/slider_drawer/slider_direction.dart';
import 'package:flutter/material.dart';

///
/// Build and Align the Menu widget based on the slide open type
///
class SliderBar extends StatelessWidget {
  final SlideDirection slideDirection;
  final double sliderMenuOpenSize;
  final Widget sliderMenu;

  const SliderBar(
      {Key? key,
      required this.slideDirection,
      required this.sliderMenuOpenSize,
      required this.sliderMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = SizedBox(width: sliderMenuOpenSize, child: sliderMenu);
    switch (slideDirection) {
      case SlideDirection.LEFT_TO_RIGHT:
        return container;
      case SlideDirection.RIGHT_TO_LEFT:
        return Positioned(right: 0, top: 0, bottom: 0, child: container);
      case SlideDirection.TOP_TO_BOTTOM:
        return Positioned(right: 0, left: 0, top: 0, child: container);
    }
  }
}
