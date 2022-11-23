import 'package:flutter/material.dart';

import 'core_text_theme_constants.dart';

class DarkThemeConstants {
  DarkThemeConstants._();

  static Color get darkBackGroundColor => Colors.blueGrey.shade900;

  static Color get darkAppBarColor => Colors.blueGrey.shade700;

  static Color get darkPrimaryColor => Colors.blueGrey.shade300;

  static Color get darkOnPrimaryColor => Colors.blueGrey.shade300;

  static Color get darkPrimaryContainerColor => Colors.black45;

  static Color get darkAccentColor => const Color.fromRGBO(74, 217, 217, 1);

  static Color get _darkTextColorPrimary => Colors.white;

  static TextTheme get darkTextTheme => TextTheme(
        headline1: CoreTextThemeConstants.getHeadingTextStyle(_darkTextColorPrimary),
        bodyText1: CoreTextThemeConstants.getBodyTextStyle1(_darkTextColorPrimary),
      );
}
