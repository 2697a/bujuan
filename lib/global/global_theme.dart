import 'package:flutter/material.dart';
//主题
final ThemeData lightTheme = ThemeData(
  accentColor: Colors.green[300],
  brightness: Brightness.light,
  primaryColor: Colors.grey[50],
  scaffoldBackgroundColor: Colors.grey[50],
  bottomAppBarColor: Colors.grey[800],
  iconTheme: IconThemeData(),
  // appBarTheme: AppBarTheme(elevation: 0),
  cardTheme: CardTheme(
    shadowColor: Colors.green[300].withOpacity(.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12.0)),
    clipBehavior: Clip.antiAlias,
  ),
);
final ThemeData darkTheme = ThemeData(
  accentColor: Colors.blue[300],
  brightness: Brightness.dark,
  bottomAppBarColor: Colors.white,
  primaryColor: Colors.grey[850],
  // appBarTheme: AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: Colors.grey[850],
  cardTheme: CardTheme(
    shadowColor: Colors.blue[300].withOpacity(.1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12.0)),
    clipBehavior: Clip.antiAlias,
  ),
);
