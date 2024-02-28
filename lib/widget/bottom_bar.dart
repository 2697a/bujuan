import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Thebrioflashynavbar extends StatelessWidget {
  final int selectedIndex;
  final double height;

  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final Curve animationCurve;
  final List<BoxShadow> shadows;

  final List<ThebrioflashynavbarItem> items;
  final ValueChanged<int> onItemSelected;

  Thebrioflashynavbar({super.key,
    this.selectedIndex = 0,
    this.height = 60,
    this.showElevation = true,
    this.iconSize = 20,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 170),
    this.animationCurve = Curves.linear,
    this.shadows = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3,
      ),
    ],
    required this.items,
    required this.onItemSelected,
  }) {
    assert(height >= 55 && height <= 100);
    assert(items.length >= 2 && items.length <= 5);
  }

  @override
  Widget build(BuildContext context) {
    final bg = (backgroundColor == null)
        ? Theme.of(context).scaffoldBackgroundColor
        : backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        boxShadow: showElevation ? shadows : [],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              var index = items.indexOf(item);
              return Expanded(
                child: GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _ThebrioflashynavbarItem(
                    item: item,
                    tabBarHeight: height,
                    iconSize: iconSize,
                    isSelected: index == selectedIndex,
                    backgroundColor: bg!,
                    animationDuration: animationDuration,
                    animationCurve: animationCurve,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ThebrioflashynavbarItem {
  final Icon icon;
  final Text title;

  Color activeColor;
  Color inactiveColor;

  ThebrioflashynavbarItem({
    required this.icon,
    required this.title,
    this.activeColor = const Color(0xffffffff),
    this.inactiveColor = const Color(0xffb8b5b5),
  });
}

class _ThebrioflashynavbarItem extends StatelessWidget {
  final double tabBarHeight;
  final double iconSize;

  final ThebrioflashynavbarItem item;

  final bool isSelected;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const _ThebrioflashynavbarItem(
      {Key? key,
        required this.item,
        required this.isSelected,
        required this.tabBarHeight,
        required this.backgroundColor,
        required this.animationDuration,
        required this.animationCurve,
        required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        height: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedAlign(
              duration: animationDuration,
              alignment: isSelected ? Alignment.topCenter : Alignment.center,
              child: AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 1.0,
                  duration: animationDuration,
                  child: IconTheme(
                    data: IconThemeData(
                        size: iconSize,
                        color: isSelected
                            ? item.activeColor.withOpacity(1)
                            : item.inactiveColor),
                    child: item.icon,
                  )),
            ),
            AnimatedPositioned(
              curve: animationCurve,
              duration: animationDuration,
              top: isSelected ? -2.0 * iconSize : tabBarHeight / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                  ),
                  CustomPaint(
                    painter: _CustomPath(backgroundColor),
                    child: SizedBox(
                      width: 80,
                      height: iconSize,
                    ),
                  )
                ],
              ),
            ),
            AnimatedAlign(
                alignment:
                isSelected ? Alignment.center : Alignment.bottomCenter,
                duration: animationDuration,
                curve: animationCurve,
                child: AnimatedOpacity(
                    opacity: isSelected ? 1.0 : 0.0,
                    duration: animationDuration,
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                        color: item.activeColor,
                        fontWeight: FontWeight.bold,
                      ),
                      child: item.title,
                    ))),
            Positioned(
                bottom: 0,
                child: CustomPaint(
                  painter: _CustomPath(backgroundColor),
                  child: SizedBox(
                    width: 80,
                    height: iconSize,
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedOpacity(
                  duration: animationDuration,
                  opacity: isSelected ? 1.0 : 0.0,
                  child: Container(
                    width: 5,
                    height: 5,
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: item.activeColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  )),
            )
          ],
        ));
  }
}

class _CustomPath extends CustomPainter {
  final Color backgroundColor;

  _CustomPath(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, 0);
    path.lineTo(0, 2.0 * size.height);
    path.lineTo(1.0 * size.width, 2.0 * size.height);
    path.lineTo(1.0 * size.width, 1.0 * size.height);
    path.lineTo(0, 0);
    path.close();

    paint.color = this.backgroundColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}