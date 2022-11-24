import 'package:flutter/material.dart';

import 'core_text_theme_constants.dart';

class LightThemeConstants {
  LightThemeConstants._();

  static Color get lightBackGroundColor => Colors.blueGrey.shade50;

  static Color get lightAppBarColor => Colors.blueGrey.shade300;

  static Color get lightPrimaryColor => Colors.blueGrey.shade300;

  static Color get lightOnPrimaryColor => Colors.blueGrey.shade700;

  static Color get lightPrimaryContainerColor => Colors.white54;

  static Color get lightAccentColor => const Color.fromRGBO(74, 217, 217, 1);

  static Color get _lightTextColorPrimary => lightBackGroundColor;

  static TextTheme get lightTextTheme => TextTheme(
        headline1: CoreTextThemeConstants.getHeadingTextStyle(_lightTextColorPrimary),
        bodyText1: CoreTextThemeConstants.getBodyTextStyle1(_lightTextColorPrimary),
      );
}
