import 'package:flutter/material.dart';
//主题
final ThemeData lightTheme = ThemeData(
  accentColor: Colors.green,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  // appBarTheme: AppBarTheme(elevation: 0),
  cardTheme: CardTheme(color: Colors.white),
);
final ThemeData darkTheme = ThemeData(
  accentColor: Colors.blue,
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  // appBarTheme: AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: Colors.grey[900],
  cardTheme: CardTheme(color: Color.fromRGBO(28, 28, 28, 1)),
);
