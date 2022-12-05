import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';
import '../../../../../domain/entities/users/manager/manager_entity.dart';

class ManagerHomeScreenBody extends StatelessWidget {
  const ManagerHomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<CurrentUserWatcherBloc>().state as CurrentUserWatcherSuccessState;
    final user = state.userEntity as ManagerEntity;

    return Center(
      child: Container(
        child: Text(user.name),
      ),
    );
  }
}
