import 'package:flutter/material.dart';

import 'components/manager_home_screen_body.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return const ManagerHomeScreenBody();
  }
}

// Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           final provider = BlocProvider.of<ThemeModeBloc>(context);
//
//           if (provider.state.themeMode == ThemeMode.dark) {
//             provider.add(ThemeModeEvent.ThemeModeLightSelectEvent());
//           } else {
//             provider.add(ThemeModeEvent.ThemeModeDarkSelectEvent());
//           }
//         },
//       ),
//
//
//       body:
//     );

//
// BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Startseite',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_work_rounded),
//             label: 'Objekte',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.supervised_user_circle_rounded),
//             label: 'Mitarbeiter',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profil',
//           ),
//         ],
//         // selectedItemColor: themeData.colorScheme.secondary,
//       ),
