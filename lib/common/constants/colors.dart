import 'package:auto_route/auto_route.dart';
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
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: NoShadowCupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
      }),
      cardColor: const Color(0xFF2C2C2C),
      iconTheme: const IconThemeData(color: Color(0xFF4D4D4D)),
      primaryColor: const Color(0xffe56260),
      textTheme: const TextTheme(
        titleLarge:TextStyle(color: Color(0xFF4D4D4D)) ,
        titleMedium:TextStyle(color: Color(0xFF4D4D4D)) ,
        titleSmall:TextStyle(color: Color(0xFF4D4D4D)) ,
        displayLarge:TextStyle(color: Color(0xFF4D4D4D)) ,
        displayMedium:TextStyle(color: Color(0xFF4D4D4D)) ,
        displaySmall:TextStyle(color: Color(0xFF4D4D4D)) ,
        bodyLarge:TextStyle(color: Color(0xFF4D4D4D)) ,
        bodyMedium:TextStyle(color: Color(0xFF4D4D4D)) ,
        bodySmall:TextStyle(color: Color(0xFF4D4D4D)) ,
        headlineLarge:TextStyle(color: Color(0xFF4D4D4D)) ,
        headlineMedium:TextStyle(color: Color(0xFF4D4D4D)) ,
        headlineSmall:TextStyle(color: Color(0xFF4D4D4D)) ,
      ),
      bottomAppBarColor: onPrimaryDark,
      scaffoldBackgroundColor: const Color(0xFFF5F3F3),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF5F3F3), foregroundColor: primaryDark, elevation: 0));

  static ThemeData dark = ThemeData.dark().copyWith(
    useMaterial3: false,
      colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: primaryDark,
            onPrimary: onPrimaryDark,
            secondary: onSecondary,
            onSecondary: secondary,
            surface: surfaceDark,
            onSurface: onSurfaceDark,
          ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
      }),
      cardColor: const Color(0xFFECEBEB),
      primaryColor: const Color(0xffe56260),
      bottomAppBarColor: onSurfaceDark,
      scaffoldBackgroundColor: const Color(0xff121212),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light),
          backgroundColor:  Color(0xff121212),
          foregroundColor: primary,
          elevation: 0));

  //right background
  static const primaryDark = Color(0xFF1c1d1f);
  static const onPrimaryDark = Color(0xF9F1F1F1);
  static const primary = Color(0xFFd7d9d8);
  static const onPrimary = Color(0xFF1c1d1f);

  //disabled or inactive background
  static const surfaceDark = Color(0xff121212);
  static const onSurfaceDark = Color(0xff121212);
  static const surface = Color(0xff787878);
  static const onSurface = Color(0xFFAEAEAE);

  //accent color
  //TODO change blue
  static const secondary = Color(0xff121212);
  static const onSecondary = Colors.white;

  //charge colors
  //todo change colors
  static const min = Colors.red;
  static const middle = Colors.yellow;
  static const max = Colors.green;
  static const empty = Colors.grey;

  //rust red accent
  //TODO change red
  static const red = Colors.red;
  static const onRed = Colors.white;

  static const iconBorder = Colors.white;
  static const topTextColor = Colors.white;
}
