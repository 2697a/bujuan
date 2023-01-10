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
      cardColor: Color(0xFF1C1B1B),
      iconTheme: const IconThemeData(color: Color(0xFF494949)),
      primaryColor: const Color(0xffe56260),
      bottomAppBarColor: const Color(0xFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF5F3F3),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark),
          backgroundColor: Color(0xFFF5F3F3),
          foregroundColor: primaryDark,
          elevation: 0));

  static ThemeData dark = ThemeData.dark().copyWith(
      colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: primaryDark,
            onPrimary: onPrimaryDark,
            secondary: onSecondary,
            onSecondary: secondary,
            surface: surfaceDark,
            onSurface: onSurfaceDark,
          ),
      cardColor: const Color(0xFFFFFFFF),
      primaryColor:  const Color(0xffe56260),
      bottomAppBarColor: primaryDark,
      scaffoldBackgroundColor: const Color(0xFF2C2B2B),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light),
          backgroundColor:  Color(0xFF2C2B2B),
          foregroundColor: primary,
          elevation: 0));

  //right background
  static const primaryDark = Color(0xFF1c1d1f);
  static const onPrimaryDark = Color(0xF9F1F1F1);
  static const primary = Color(0xFFd7d9d8);
  static const onPrimary = Color(0xFF1c1d1f);

  //disabled or inactive background
  static const surfaceDark = Color(0xFF333436);
  static const onSurfaceDark = Color(0xFF2C2B2B);
  static const surface = Color(0xff787878);
  static const onSurface = Color(0xFFAEAEAE);

  //accent color
  //TODO change blue
  static const secondary = Color(0xFF1C1B1B);
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
