import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData light = ThemeData.light().copyWith(
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: primary,
          onPrimary: onPrimary,
          secondary: secondary,
          onSecondary: onSecondary,
          surface: surface,
          onSurface: onSurface,
        ),
    appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light,statusBarIconBrightness: Brightness.dark),backgroundColor: onPrimaryDark,foregroundColor: primaryDark,elevation: 0)
  );

  static ThemeData dark = ThemeData.dark().copyWith(
    colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: primaryDark,
          onPrimary: onPrimaryDark,
          secondary: secondary,
          onSecondary: onSecondary,
          surface: surfaceDark,
          onSurface: onSurfaceDark,
        ),
  );

  //right background
  static const primaryDark = Color(0xFF1c1d1f);
  static const onPrimaryDark = Colors.white;
  static const primary = Color(0xFFd7d9d8);
  static const onPrimary = Colors.white;

  //disabled or inactive background
  static const surfaceDark = Color(0xFF333436);
  static const onSurfaceDark = Color(0xFF6e7073);
  static const surface = Color(0xff787878);
  static const onSurface =Color(0xFFAEAEAE);

  //accent color
  //TODO change blue
  static const secondary = Colors.white;
  static const onSecondary = Colors.white;

  //charge colors
  //todo change colors
  static const min = Colors.red;
  static const middle = Colors.yellow;
  static const max = Colors.green;
  static const empty = Colors.grey;

  //main red accent
  //TODO change red
  static const red = Colors.red;
  static const onRed = Colors.white;

  static const iconBorder = Colors.white;
  static const topTextColor = Colors.white;
}
