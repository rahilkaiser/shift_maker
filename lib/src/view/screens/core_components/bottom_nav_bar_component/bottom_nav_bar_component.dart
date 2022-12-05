// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// import '../../../../application/departments/department_observer_bloc/department_observer_bloc.dart';
// import '../../../routes/router.gr.dart';
//
// enum MenuState { HOME, DEPARTS, USERS, PROFILE }
//
// class BottomNavBar extends StatelessWidget {
//   final MenuState selectedMenu;
//
//   const BottomNavBar({
//     required this.selectedMenu,
//     Key? key,
//   }) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final themeData = Theme.of(context);
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//             vertical: size.height * 0.03,
//           ),
//       child: GNav(
//         selectedIndex: this.selectedMenu.index,
//         onTabChange: (index) {
//           switch (index) {
//             case 0:
//               print("qWQWQWQW");
//               AutoRouter.of(context).replaceAll([const HomeScreenRoute()]);
//               break;
//             case 1:
//               break;
//             case 2:
//               break;
//             case 3:
//
//               AutoRouter.of(context).replaceAll([const ProfileScreenManagerRoute()]);
//               break;
//           }
//         },
//         backgroundColor: themeData.focusColor,
//         activeColor: themeData.colorScheme.secondary,
//         padding: EdgeInsets.symmetric(
//           horizontal: size.width * 0.05,
//           vertical: size.height * 0.03,
//         ),
//         gap: 8,
//         tabs: const [
//           GButton(
//             icon: Icons.home,
//             text: "Startseite",
//           ),
//           GButton(
//             icon: Icons.home_work_rounded,
//             text: "Objekte",
//           ),
//           GButton(
//             icon: Icons.supervised_user_circle_rounded,
//             text: "Arbeiter",
//           ),
//           GButton(
//             icon: Icons.person,
//             text: "Profil",
//           ),
//         ],
//       ),
//     );
//   }
// }
