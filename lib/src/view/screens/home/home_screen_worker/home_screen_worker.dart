import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/auth_status_bloc/auth_status_bloc.dart';
import '../../components/app_title_component/app_title_component.dart';
import 'components/home_screen_worker_body.dart';

class HomeScreenWorker extends StatelessWidget {
  const HomeScreenWorker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const HomeScreenWorkerBody(),
    );
  }
}
