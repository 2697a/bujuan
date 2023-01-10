import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FlashyNavbar extends StatelessWidget {
  final int selectedIndex;
  final double height;

  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final Curve animationCurve;
  final List<BoxShadow> shadows;

  final List<FlashyNavbarItem> items;
  final ValueChanged<int> onItemSelected;

  FlashyNavbar({
    Key? key,
    this.selectedIndex = 0,
    this.height = 55,
    this.showElevation = true,
    this.iconSize = 23,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.linear,
    this.shadows = const [
      BoxShadow(
        color: Colors.transparent,
        blurRadius: 0,
      ),
    ],
    required this.items,
    required this.onItemSelected,
  }) : super(key: key) {
    // assert(height >= 55 );
    assert(items.length >= 2 && items.length <= 5);
  }

  @override
  Widget build(BuildContext context) {
    final bg = (backgroundColor == null) ? Theme.of(context).bottomAppBarColor : backgroundColor;
    return Container(
      height: height,
      decoration: BoxDecoration(
        boxShadow: showElevation ? shadows : [],
        // border: Border(top: BorderSide(color: Colors.grey.withOpacity(.1),width: 1.w))
      ),
      child: SizedBox(
        width: Get.width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Expanded(
              child: GestureDetector(
                onTap: () => onItemSelected(index),
                child: _FlashyNavbarItem(
                  item: item,
                  tabBarHeight: height,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bg!,
                  color: backgroundColor!,
                  animationDuration: animationDuration,
                  animationCurve: animationCurve,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FlashyNavbarItem {
  final Icon icon;
  // final Text title;

  Color activeColor;
  Color inactiveColor;

  FlashyNavbarItem({
    required this.icon,
    // required this.title,
    this.activeColor =  Colors.black,
    this.inactiveColor =  Colors.grey,
  });
}

class _FlashyNavbarItem extends StatelessWidget {
  final double tabBarHeight;
  final double iconSize;

  final FlashyNavbarItem item;
  final Color color;

  final bool isSelected;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const _FlashyNavbarItem(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.tabBarHeight,
      required this.backgroundColor,
      required this.animationDuration,
      required this.animationCurve,
      required this.iconSize, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedAlign(
              duration: animationDuration,
              alignment: Alignment.center,
              child: AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 1.0,
                  duration: animationDuration,
                  child: IconTheme(
                    data: IconThemeData(size: iconSize, color: color),
                    child: item.icon,
                  )),
            ),
            // AnimatedPositioned(
            //   curve: animationCurve,
            //   duration: animationDuration,
            //   top: isSelected ? -2.0 * iconSize : tabBarHeight / 4,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       SizedBox(
            //         width: iconSize,
            //         height: iconSize,
            //       ),
            //       CustomPaint(
            //         painter: _CustomPath(backgroundColor),
            //         child: SizedBox(
            //           width: 80,
            //           height: iconSize,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // AnimatedAlign(
            //     alignment: isSelected ? Alignment.center : Alignment.bottomCenter,
            //     duration: animationDuration,
            //     curve: animationCurve,
            //     child: AnimatedOpacity(
            //         opacity: isSelected ? 1.0 : 0.0,
            //         duration: animationDuration,
            //         child: DefaultTextStyle.merge(
            //           style: TextStyle(
            //             color: item.inactiveColor,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 26.sp
            //           ),
            //           child: item.title,
            //         ))),
            // Positioned(
            //     bottom: 0,
            //     child: CustomPaint(
            //       painter: _CustomPath(backgroundColor),
            //       child: SizedBox(
            //         width: 80,
            //         height: iconSize,
            //       ),
            //     )),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedOpacity(
                  duration: animationDuration,
                  opacity: isSelected ? 1.0 : 0.0,
                  child: Container(
                    width: 5,
                    height: 5,
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
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

    paint.color = backgroundColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
