import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/auth/auth_status_bloc/auth_status_bloc.dart';
import '../../../application/auth/auth_status_bloc/auth_status_bloc.dart';
import '../../../application/departments/department_observer_bloc/department_observer_bloc.dart';
import '../../../injection.dart';
import '../../routes/router.gr.dart';
import '../components/app_title_component/app_title_component.dart';
import 'components/home_screen_body_portrait.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final departObserverBloc = serviceLocator<DepartmentObserverBloc>()..add(ObserveAllEvent());
    return MultiBlocProvider(
      providers: [BlocProvider<DepartmentObserverBloc>(create: (context) => departObserverBloc)],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthStatusBloc, AuthStatusState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                AutoRouter.of(context).replace(const LoginScreenRoute());
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const AppTitleComponent(),
            actions: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthStatusBloc>(context).add(const AuthStatusEvent.logout());
                },
                child: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: const HomeScreenBodyPortrait(),
        ),
      ),
    );
  }
}
