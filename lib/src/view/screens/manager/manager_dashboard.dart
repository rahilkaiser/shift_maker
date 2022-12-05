import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../application/auth/auth_status_bloc/auth_status_bloc.dart';
import '../../../application/current_user/theme_mode_bloc/theme_mode_bloc.dart';
import '../../routes/router.gr.dart';
import '../components/app_title_component/app_title_component.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return AutoTabsScaffold(
      routes: const [
        ManagerHomeRouter(),
        ManagerOverviewDepartmentRouter(),
        ManagerOverviewWorkerRouter(),
        ManagerProfileRouter(),
      ],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cached),
        onPressed: () {
          final provider = BlocProvider.of<ThemeModeBloc>(context);

          if (provider.state.themeMode == ThemeMode.dark) {
            provider.add(const ThemeModeEvent.ThemeModeLightSelectEvent());
          } else {
            provider.add(const ThemeModeEvent.ThemeModeDarkSelectEvent());
          }
        },
      ),
      animationDuration: const Duration(milliseconds: 500),
      animationCurve: Curves.easeIn,
      appBarBuilder: (context, tabsRouter) {
        return AppBar(
          leading: const AutoLeadingButton(),
          centerTitle: true,
          title: const AppTitleComponent(),
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return FittedBox(
          clipBehavior: Clip.hardEdge,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.0,
                vertical: size.height * 0.0,
              ),
              child: GNav(
                selectedIndex: tabsRouter.activeIndex,
                onTabChange: tabsRouter.setActiveIndex,
                backgroundColor: themeData.colorScheme.inversePrimary.withOpacity(0.3),
                activeColor: themeData.colorScheme.secondary,
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: size.height * 0.04,
                ),
                gap: 8,
                haptic: true,
                tabs: const [

                  GButton(
                    icon: Icons.home,
                    text: "Startseite",
                  ),
                  GButton(
                    icon: Icons.home_work_rounded,
                    text: "Objekte",
                  ),
                  GButton(
                    icon: Icons.supervised_user_circle_rounded,
                    text: "Arbeiter",
                  ),
                  GButton(
                    icon: Icons.person,
                    text: "Profil",
                  ),
                ],
              ),
            ),
          ),
        );
      },
      // builder: (context, child, animation) {
      //
      // },
    );
  }
}
