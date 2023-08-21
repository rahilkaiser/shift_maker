import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/departments/department_observer_bloc/department_observer_bloc.dart';


class HomeScreenBodyPortrait extends StatelessWidget {
  const HomeScreenBodyPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
        return BlocBuilder<DepartmentObserverBloc, DepartmentObserverState>(
          builder: (context, state) {
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
            } else if (state is DepartmentObserverPaginationState) {
              return ListView.builder(
                  itemCount: state.departments.length,
                  itemBuilder: (context, index) {
                    final depart = state.departments[index];
                    return Container(
                      color: Colors.green,
                      height: 40,
                      child: Text(depart.label),
                    );
                  });
            }
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
  }
}
