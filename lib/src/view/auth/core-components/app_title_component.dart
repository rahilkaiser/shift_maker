import 'package:flutter/material.dart';

class AppTitleComponent extends StatelessWidget {
  const AppTitleComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Shift',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
        ),
        TextSpan(
          text: 'Maker',
          style: TextStyle(
            color: themeData.colorScheme.secondary,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    );
  }
}


// Future<List<TextSpan>> listOfEventsAtDay({String day, String monthNum}) async {
//   final result = await DatabaseHelper.instance
//       .queryForEventsAtDay(mnth: monthNum, dy: day);
//   List<TextSpan> textSpans = [];
//   int count = result.length;
//   for (int i = 0; i < count; i++) {
//     final String string = "-${result[i]['year']}: ${result[i]['title']}\n";
//     textSpans.add(TextSpan(
//       text: string,
//     ));
//   }
//
//   return textSpans;
// }
