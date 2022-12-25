import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/departments/department_observer_bloc/department_observer_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../core/sliver_search_app_bar_component/sliver_search_app_bar_component.dart';
import '../../core/tweens/custom_rect_tween.dart';
import 'manager_department_card_component.dart';

class ManagerOverviewDepartmentScreenBody extends StatelessWidget {
  const ManagerOverviewDepartmentScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    // List<DepartmentEntity?> test = [DepartmentEntity.empty(), null, DepartmentEntity(id: UniqueId(), label: "EE", description: "NJNJN")];
    //
    // List<DepartmentEntity> test2 = test.whereType<DepartmentEntity>().toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverSearchAppBar(
          hintText: "Suche Objekte",
        ),
        BlocBuilder<DepartmentObserverBloc, DepartmentObserverState>(
          builder: (context, state) {
            if (state is DepartmentObserverSuccessState) {
              return SliverGrid.count(
                crossAxisCount: 1,
                childAspectRatio: 1.1,
                children: List.generate(
                  state.departmentEntities.length,
                  (i) {
                    return Padding(
                      padding: CoreSpacingConstants.getCoreBodyContentPaddingHorizontal(size),
                      child: Hero(
                        tag: i,
                        createRectTween: (Rect? begin, Rect? end) {
                          return CustomRectTween(a: begin!, b: end!);
                        },
                        child: ManagerDepartmentCardComponent(department: state.departmentEntities[i]),
                      ),
                    );
                  },
                ),
              );
            } else if (state is DepartmentObserverInitialState) {
              return SliverGrid.count(
                crossAxisCount: 2,
                children: [
                  Container(),
                ],
              );
            } else if (state is DepartmentObserverLoadingState) {
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: themeData.colorScheme.secondary,
                  ),
                ),
              );
            } else if (state is DepartmentObserverFailureState) {
              return SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: themeData.errorColor,
                        ),
                  ),
                ),
              );
            }
            return const SliverFillRemaining(
              child: Center(
                child: Text("Empty"),
              ),
            );
          },
        ),

        // SliverPadding(
        //   padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        // )
      ],
    );
  }
}
