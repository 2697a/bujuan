import 'package:flutter/material.dart';
//主题
final ThemeData lightTheme = ThemeData(
  accentColor: Colors.green[300],
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.black,
  // appBarTheme: AppBarTheme(elevation: 0),
  // cardTheme: CardTheme(elevation: 0.3),
);
final ThemeData darkTheme = ThemeData(
  accentColor: Colors.blue[300],
  brightness: Brightness.dark,
  bottomAppBarColor: Colors.white,
  primaryColor: Colors.grey[900],
  // appBarTheme: AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: Colors.grey[900],
  // cardTheme: CardTheme(elevation: 0.6),
);
