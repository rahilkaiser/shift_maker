import 'package:flutter/material.dart';

class CoreTextThemeConstants {
  CoreTextThemeConstants._();

  static TextStyle getBodyTextStyle1(Color color) => TextStyle(
        color: color,
        fontFamily: "Rubik",
        fontSize: 22,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      );

  static TextStyle getHeadingTextStyle(Color color) => TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        height: 1.5,
      );
}
