import 'package:bujuan/widget/slider_drawer/slider_direction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper/slider_app_bar.dart';

class SAppBar extends StatelessWidget {
  final Color splashColor;

  final AnimationController animationController;
  final VoidCallback onTap;
  final SlideDirection slideDirection;

  final SliderAppBar sliderAppBar;
  final bool isCupertino;

  const SAppBar(
      {Key? key,
      this.splashColor = const Color(0xff000000),
      required this.animationController,
      required this.onTap,
      required this.slideDirection,
      required this.sliderAppBar,
      this.isCupertino = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = appBar();
    return Container(
      height: sliderAppBar.appBarHeight,
      padding: sliderAppBar.appBarPadding,
      color: sliderAppBar.appBarColor,
      child: Row(
        children: items,
      ),
    );
  }

  List<Widget> appBar() {
    List<Widget> list = [
      if (sliderAppBar.drawerIcon == null)
        isCupertino
            ? AnimatedCupertinoIcon(
                progress: animationController,
                onTap: () => onTap(),
              )
            : IconButton(
                splashColor: splashColor,
                icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    color: sliderAppBar.drawerIconColor,
                    size: sliderAppBar.drawerIconSize,
                    progress: animationController),
                onPressed: () => onTap())
      else
        sliderAppBar.drawerIcon!,
      Expanded(
          child: sliderAppBar.isTitleCenter
              ? Center(child: sliderAppBar.title)
              : sliderAppBar.title),
      sliderAppBar.trailing ?? SizedBox(width: 35)
    ];

    if (slideDirection == SlideDirection.RIGHT_TO_LEFT) {
      return List.from(list.reversed);
    }
    return list;
  }
}

class AnimatedCupertinoIcon extends StatefulWidget {
  final Animation<double> progress;
  final VoidCallback onTap;

  const AnimatedCupertinoIcon(
      {Key? key, required this.progress, required this.onTap})
      : super(key: key);

  @override
  State<AnimatedCupertinoIcon> createState() => _AnimatedCupertinoIconState();
}

class _AnimatedCupertinoIconState extends State<AnimatedCupertinoIcon> {
  bool isCompleted = false;

  @override
  void initState() {
    widget.progress.addListener(() {
      isCompleted = widget.progress.isCompleted;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
            isCompleted
                ? CupertinoIcons.clear_thick
                : CupertinoIcons.line_horizontal_3,
            color: Colors.grey,
            size: 25.0),
      ),
    );
  }
}
