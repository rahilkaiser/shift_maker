import 'package:flutter/material.dart';

import 'dark_theme_constants.dart';
import 'light_theme_constants.dart';

class AppTheme {
  AppTheme._();

  static const _iconColor = Colors.white;

  // static final ThemeData darkTheme = ThemeData(
  //   scaffoldBackgroundColor: DarkThemeConstants.darkBackGroundColor,
  //   appBarTheme: AppBarTheme(
  //     color: DarkThemeConstants.darkAppBarColor,
  //     iconTheme: const IconThemeData(color: _iconColor),
  //   ),
  //   colorSchemeSeed: DarkThemeConstants.darkAccentColor,
  //   brightness: Brightness.dark,
  //   useMaterial3: false,
  //   colorScheme: ColorScheme.dark(
  //     primary: DarkThemeConstants.darkPrimaryColor,
  //     onPrimary: DarkThemeConstants.darkOnPrimaryColor,
  //     primaryContainer: DarkThemeConstants.darkPrimaryContainerColor,
  //     secondary: DarkThemeConstants.darkAccentColor,
  //   ),
  //   textTheme: DarkThemeConstants.darkTextTheme,
  // );
  //
  // static final ThemeData lightTheme = ThemeData(
  //   scaffoldBackgroundColor: LightThemeConstants.lightBackGroundColor,
  //   appBarTheme: AppBarTheme(
  //     color: LightThemeConstants.lightAppBarColor,
  //   ),
  //   textTheme: LightThemeConstants.lightTextTheme,
  //   colorScheme: ColorScheme.light(
  //     primary: LightThemeConstants.lightPrimaryColor,
  //     onPrimary: LightThemeConstants.lightOnPrimaryColor,
  //     primaryContainer: LightThemeConstants.lightPrimaryContainerColor,
  //     secondary: DarkThemeConstants.darkAccentColor,
  //   ),
  // );

  static final ThemeData darkTheme = ThemeData(
    colorSchemeSeed: DarkThemeConstants.darkAccentColor,
    brightness: Brightness.dark,
    useMaterial3: false,
    textTheme: DarkThemeConstants.darkTextTheme,
  );

  static final ThemeData lightTheme = ThemeData(
    textTheme: LightThemeConstants.lightTextTheme,
    colorSchemeSeed: DarkThemeConstants.darkOnPrimaryColor,
    brightness: Brightness.light,
    useMaterial3: false,
  );
}
