import 'package:flutter/widgets.dart';

class SliderAppBar extends StatelessWidget {
  /// [double] you can change appBar height by this parameter [appBarHeight]
  ///
  final double appBarHeight;

  /// [Widget] you can set appbar title by this parameter [title]
  ///
  final Widget title;

  ///[bool] you can set title in center by this parameter
  /// By default it's [true]
  ///
  final bool isTitleCenter;

  ///[Color] you can change appbar color by this parameter [appBarColor]
  ///
  final Color appBarColor;

  ///[EdgeInsets] you can change appBarPadding by this parameter [appBarPadding]
  ///
  final EdgeInsets? appBarPadding;

  ///[Widget] you can set trailing of appbar by this parameter [trailing]
  ///
  final Widget? trailing;

  ///[Color] you can change drawer icon by this parameter [drawerIconColor]
  ///
  final Color drawerIconColor;

  ///[Widget] you can change drawer icon by this parameter [drawerIcon]
  ///
  final Widget? drawerIcon;

  ///[double] you can change drawer icon size by this parameter [drawerIconSize]
  ///
  final double drawerIconSize;

  const SliderAppBar({
    this.appBarHeight = 70,
    this.title = const Text('AppBar',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
    this.isTitleCenter = true,
    this.appBarColor = const Color(0xffffffff),
    this.appBarPadding = const EdgeInsets.only(top: 24),
    this.trailing,
    this.drawerIconColor = const Color(0xff2c2b2b),
    this.drawerIcon,
    this.drawerIconSize = 27,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage();
  }
}
