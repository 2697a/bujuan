import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PlayBottomBar extends StatefulWidget {
  @override
  _PlayBottomBarState createState() => _PlayBottomBarState();
}

class _PlayBottomBarState extends State<PlayBottomBar> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 800));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.0,
      child: AnimatedBuilder(animation: _animationController, builder: (context,child){
        return SlideTransition(position: _getAnimationOffSet(minSize: 375.h, maxSize: 395.h),child: child,);
      },child: GestureDetector(
        child: Container(
          height: 62.0,
          color: Colors.blue,
        ),
        onForcePressStart: (v){
          print('onForcePressStart$v');
        },
        onHorizontalDragDown: (v){
          print('onHorizontalDragDown$v');
        },
        onHorizontalDragStart: (v){
          print('onHorizontalDragStart$v');
        },
        onHorizontalDragEnd: (v){
          print('onHorizontalDragEnd$v');
        },
        onHorizontalDragUpdate: (DragUpdateDetails updateDetails){
          var delta = updateDetails.primaryDelta;
          var fractionDragged = delta / 375.h;
          print('onHorizontalDragUpdate$delta');
          _animationController.value -= 1.5 * fractionDragged;
        },
        onHorizontalDragCancel: (){
          print('onHorizontalDragCancel');
        },
      ),),
    );
  }



  Animation<Offset> _getAnimationOffSet(
      {@required double minSize, @required double maxSize}) {
    final _closedPercentage =
        (375.h - minSize) / 375.h;

    final _openPercentage =
        (375.h - maxSize) / 375.h;

    return Tween<Offset>(
        begin: Offset(0.6, 0),
        end: Offset(_closedPercentage, 0))
        .animate(_animationController);
  }
}
