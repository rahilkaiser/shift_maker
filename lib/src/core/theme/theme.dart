import 'package:flutter/material.dart';

import 'dark_theme_constants.dart';
import 'light_theme_constants.dart';

class AppTheme {
  AppTheme._();

  static const _iconColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: LightThemeConstants.lightPrimaryColor,
    appBarTheme: AppBarTheme(
      color: LightThemeConstants.lightAppBarColor,
    ),
    textTheme: LightThemeConstants.lightTextTheme,
    colorScheme: ColorScheme.light(
      primary: LightThemeConstants.lightPrimaryColor,
      onPrimary: LightThemeConstants.lightOnPrimaryColor,
      primaryContainer: LightThemeConstants.lightPrimaryContainerColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkThemeConstants.darkBackGroundColor,
    appBarTheme: AppBarTheme(
      color: DarkThemeConstants.darkAppBarColor,
      iconTheme: const IconThemeData(color: _iconColor),
    ),
    colorScheme: ColorScheme.dark(
      primary: DarkThemeConstants.darkPrimaryColor,
      onPrimary: DarkThemeConstants.darkOnPrimaryColor,
      primaryContainer: DarkThemeConstants.darkPrimaryContainerColor,
      secondary: DarkThemeConstants.darkAccentColor,
    ),
    textTheme: DarkThemeConstants.darkTextTheme,
  );
}
