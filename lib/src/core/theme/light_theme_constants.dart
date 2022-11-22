import 'package:flutter/material.dart';

class LightThemeConstants {
  LightThemeConstants._();

  static Color get lightPrimaryColor => Colors.blueGrey.shade50;
  static Color get lightPrimaryContainerColor => Colors.blueGrey.shade800;
  static Color get lightOnPrimaryColor => Colors.blueGrey.shade200;
  static Color get _lightTextColorPrimary => Colors.black;
  static Color get lightAppBarColor => Colors.blue;

  static TextStyle get _lightHeadingTextStyle => TextStyle(
        color: _lightTextColorPrimary,
        fontFamily: "Rubik",
      );

  static TextStyle get _lightBodyTextStyle => TextStyle(
        color: _lightTextColorPrimary,
        fontFamily: "Rubik",
      );

  static TextTheme get lightTextTheme => TextTheme(
        headline1: _lightHeadingTextStyle,
        bodyText1: _lightBodyTextStyle,
      );
}
