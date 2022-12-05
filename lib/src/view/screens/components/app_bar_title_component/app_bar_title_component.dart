import 'package:flutter/material.dart';

class AppBarTitleComponent extends StatelessWidget {
  final String title;

  const AppBarTitleComponent({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Text(
      this.title,
      style: themeData.textTheme.headline5!.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600
      ),
    );
  }
}
