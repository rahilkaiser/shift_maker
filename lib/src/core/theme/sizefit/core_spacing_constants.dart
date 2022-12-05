import 'package:flutter/material.dart';

class CoreSpacingConstants {
  CoreSpacingConstants._();

  /// The main Padding for app-content
  ///
  ///
  static EdgeInsets getCoreBodyContentPadding(Size screenSize) =>
      EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: screenSize.height * 0.07);

  static SizedBox getCoreFormSpacingSizedBox(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    if (mediaQuery.orientation == Orientation.portrait) {
      return SizedBox(height: mediaQuery.size.height * 0.04);
    }

    return SizedBox(height: mediaQuery.size.height * 0.08);
  }
}
