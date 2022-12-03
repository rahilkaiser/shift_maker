import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';

import '../../../../application/departments/department_observer_bloc/department_observer_bloc.dart';

import '../../../../domain/entities/users/manager/manager_entity.dart';
import '../../../../domain/entities/users/worker/worker_entity.dart';

class HomeScreenBodyPortrait extends StatelessWidget {
  const HomeScreenBodyPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<CurrentUserWatcherBloc, CurrentUserWatcherState>(
      builder: (context, currUserState) {
        return BlocBuilder<DepartmentObserverBloc, DepartmentObserverState>(
          builder: (context, state) {
            if (currUserState is CurrentUserWatcherSuccessState) {
              print("JNJNJNNJN");
              final uEntity = currUserState.userEntity;
              print(uEntity);
              if (uEntity is ManagerEntity) {
                return Center(
                  child: Text(
                    uEntity.name,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: themeData.errorColor,
                        ),
                  ),
                );
              } else if (uEntity is WorkerEntity) {
                return Center(
                  child: Text(
                    uEntity.email,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: themeData.errorColor,
                        ),
                  ),
                );
              }
            }

            if (state is DepartmentObserverInitialState) {
              return Container();
            } else if (state is DepartmentObserverLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: themeData.colorScheme.secondary,
                ),
              );
            } else if (state is DepartmentObserverFailureState) {
              return Center(
                child: Text(
                  state.toString(),
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: themeData.errorColor,
                      ),
                ),
              );
            } else if (state is DepartmentObserverSuccessState) {
              return ListView.builder(
                  itemCount: state.departmentEntities.length,
                  itemBuilder: (context, index) {
                    if (state.departmentEntities[index] != null) {
                      final depart = state.departmentEntities[index];
                      return Container(
                        color: Colors.green,
                        height: 40,
                        child: Text(depart!.label),
                      );
                    }
                    return Container();
                  });
            }
            // return Container();
            return Center(
              child: Text(
                state.toString(),
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: themeData.errorColor,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}

// return Center(
//   child: Container(
//     color: Colors.green,
//     child: Text(state.toString(), style: Theme.of(context).textTheme.headline2,),
//   ),
// );
