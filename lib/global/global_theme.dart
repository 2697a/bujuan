import 'package:flutter/material.dart';

//主题
final ThemeData lightTheme = ThemeData(
    accentColor: Colors.green[300],
    brightness: Brightness.light,
    primaryColor: Colors.grey[50],
    scaffoldBackgroundColor: Colors.grey[50],
    // secondaryHeaderColor: Colors.black,
    bottomAppBarColor: Colors.black,
    cardTheme: CardTheme(
      shadowColor: Colors.green[300].withOpacity(.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12.0)),
      clipBehavior: Clip.antiAlias,
    ),
    appBarTheme: AppBarTheme(
      shadowColor: Colors.green[300].withOpacity(.1),
      elevation: 0.0,
    ));
final ThemeData darkTheme = ThemeData(
    accentColor: Colors.blue[300],
    brightness: Brightness.dark,
    // secondaryHeaderColor: Colors.white,
    bottomAppBarColor: Colors.white,
    primaryColor: Colors.grey[850],
    scaffoldBackgroundColor: Colors.grey[850],
    cardTheme: CardTheme(
      shadowColor: Colors.blue[300].withOpacity(.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12.0)),
      clipBehavior: Clip.antiAlias,
    ),
    appBarTheme: AppBarTheme(
      shadowColor: Colors.blue[300].withOpacity(.1),
      elevation: 0.0,
    ));
