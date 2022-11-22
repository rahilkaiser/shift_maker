import 'package:flutter/material.dart';

class DarkThemeConstants {
  DarkThemeConstants._();

  static Color get darkBackGroundColor => Colors.blueGrey.shade900;

  static Color get darkPrimaryColor => Colors.blueGrey.shade300;

  static Color get darkPrimaryContainerColor => Colors.black45;

  static Color get darkOnPrimaryColor => Colors.blueGrey.shade300;

  static Color get darkAppBarColor => Colors.blueGrey.shade800;

  static Color get darkAccentColor => const Color.fromRGBO(74, 217, 217, 1);

  static TextTheme get darkTextTheme => TextTheme(
        headline1: _darkHeadingTextStyle,
        bodyText1: _darkBodyTextStyle,
      );

  static Color get _darkTextColorPrimary => Colors.white;

  static TextStyle get _darkHeadingTextStyle => TextStyle(
        color: _darkTextColorPrimary,
        fontFamily: "Rubik",
      );

  static TextStyle get _darkBodyTextStyle => TextStyle(
        color: _darkTextColorPrimary,
        fontFamily: "Rubik",
        fontSize: 22,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      );
}
