import 'package:flutter/widgets.dart';

import 'helper/slider_shadow.dart';
import 'helper/utils.dart';
import 'slider_direction.dart';

class SliderShadow extends StatelessWidget {
  const SliderShadow({
    Key? key,
    required AnimationController? animationDrawerController,
    required this.animation,
    required this.sliderBoxShadow,
    required this.slideDirection,
    required this.sliderOpenSize,
  })  : _animationDrawerController = animationDrawerController,
        super(key: key);

  final AnimationController? _animationDrawerController;
  final Animation animation;
  final SliderBoxShadow sliderBoxShadow;
  final SlideDirection slideDirection;
  final double sliderOpenSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationDrawerController!,
      builder: (_, child) {
        return Transform.translate(
          offset: Utils.getOffsetValueForShadow(
              slideDirection, animation.value, sliderOpenSize),
          child: child,
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
          BoxShadow(
            color: sliderBoxShadow.color,
            blurRadius: sliderBoxShadow.blurRadius,
            spreadRadius: sliderBoxShadow.spreadRadius,
            offset: const Offset(15.0, 15.0),
          )
        ]),
      ),
    );
  }
}
