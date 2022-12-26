import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/auth/auth_status_bloc/auth_status_bloc.dart';

import '../../../application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';
import '../../../application/departments/department_observer_bloc/department_observer_bloc.dart';
import '../../../domain/entities/users/manager/manager_entity.dart';

import '../../../domain/entities/users/worker/worker_entity.dart';
import '../../../injection.dart';
import '../../routes/router.gr.dart';

import '../manager/manager_dashboard.dart';

import 'home_screen_worker/home_screen_worker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final departObserverBloc = serviceLocator<DepartmentObserverBloc>()..add(ObserveAllEvent());

    return MultiBlocProvider(
      providers: [
        BlocProvider<DepartmentObserverBloc>(create: (context) => departObserverBloc),
        BlocProvider<CurrentUserWatcherBloc>(
          create: (context) => serviceLocator<CurrentUserWatcherBloc>()..add(CurrentUserGetEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthStatusBloc, AuthStatusState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                AutoRouter.of(context).replace(const LoginRoute());
              }
            },
          ),
        ],
        child: BlocBuilder<CurrentUserWatcherBloc, CurrentUserWatcherState>(
          builder: (context, state) {
            if (state is CurrentUserWatcherSuccessState) {
              final userEntity = state.userEntity;
              if (userEntity is ManagerEntity) {
                return const ManagerDashboard();
              } else if (userEntity is WorkerEntity) {
                return const HomeScreenWorker();
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text(
                      "Your Userrole is not identifiable. Please contact support or create a new Account.",
                    ),
                  ),
                );
              }
            }
            return Scaffold(
              // floatingActionButton: FloatingActionButton(heroTag: "LOGOUT-DEFAULT", onPressed: () {
              //   AutoRouter.of(context).replace(const LoginRoute());
              // }),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
