import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../application/core/is_editable_bloc/is_editable_bloc.dart';

import '../../../application/departments/department_observer_bloc/department_observer_bloc.dart';
import '../../../application/departments/selected_department_bloc/selected_department_bloc.dart';
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IsEditableBloc(),
        ),
        BlocProvider(
          create: (context) => SelectedDepartmentBloc(),
        ),
      ],
      child: BlocBuilder<SelectedDepartmentBloc, SelectedDepartmentState>(
        builder: (context, selectedDepartmentstate) {
          return BlocBuilder<IsEditableBloc, IsEditableState>(
            builder: (context, isEditableState) {
              return AutoTabsScaffold(
                routes: const [
                  ManagerHomeRouter(),
                  ManagerOverviewDepartmentRouter(),
                  ManagerOverviewWorkerRouter(),
                  ManagerProfileRouter(),
                ],
                lazyLoad: false,
                animationDuration: const Duration(milliseconds: 500),
                animationCurve: Curves.easeIn,
                appBarBuilder: (context, tabsRouter) {
                  return AppBar(
                    actions: [
                      // AutoLeadingButton(),
                      AutoLeadingButton(
                        showIfChildCanPop: true,
                        builder: (context, leadingType, action) {
                          if (isEditableState.isEditable && selectedDepartmentstate.departmentEntity != null && tabsRouter.activeIndex == 1) {
                            return IconButton(
                              onPressed: () {
                                context.read<IsEditableBloc>().add(ChangeToIsNotEditableEvent());

                                AutoRouter.of(context)
                                    .push(
                                      ManagerDepartmentEditorRoute(
                                        departmentEntity: selectedDepartmentstate.departmentEntity!,
                                      ),
                                    )
                                    .then(
                                      (value) => context.read<IsEditableBloc>().add(ChangeToIsEditableEvent()),
                                    );
                              },
                              icon: const Icon(Icons.edit),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
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
                          // haptic: true,
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
                              text: "Personal",
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
            },
          );
        },
      ),
    );
  }
}
