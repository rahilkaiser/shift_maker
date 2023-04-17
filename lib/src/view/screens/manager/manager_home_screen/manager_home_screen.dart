import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/current_user/theme_mode_bloc/theme_mode_bloc.dart';
import 'components/manager_home_screen_body.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      //TODO: REMOVE THIS ONE
      floatingActionButton: FloatingActionButton(
        heroTag: "Test",
        child: Icon(Icons.refresh),
        onPressed: () {
          final provider = BlocProvider.of<ThemeModeBloc>(context);

          if (provider.state.themeMode == ThemeMode.dark) {
            provider.add(const ThemeModeEvent.ThemeModeLightSelectEvent());
          } else {
            provider.add(const ThemeModeEvent.ThemeModeDarkSelectEvent());
          }
        },
      ),
      body: const ManagerHomeScreenBody(),
    );
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
