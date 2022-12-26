import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../../domain/entities/users/worker/worker_entity.dart';
import '../../../../routes/router.gr.dart';
import '../../core/sliver_search_app_bar_component/sliver_search_app_bar_component.dart';

class ManagerOverviewWorkerScreenBody extends StatelessWidget {
  const ManagerOverviewWorkerScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        const SliverSearchAppBar(hintText: "Suche Personal"),
        SliverList(
          // Use a delegate to build items as they're scrolled on screen.
          delegate: SliverChildBuilderDelegate(
            // The builder function returns a ListTile with a title that
            // displays the index of the current item.
            (context, index) => InkWell(
              onTap: () {
                // context.read<SelectedDepartmentBloc>().add(
                //       SelectedDepartmentEvent.selectDepartmentEntityEvent(
                //         departmentEntity: depart,
                //       ),
                //     ); workerEntity: worker

                AutoRouter.of(context).push(ManagerWorkerDetailsRoute(
                  worker: WorkerEntity.empty(),
                )).then(
                  (value) {
                    context.read<IsEditableBloc>().add(ChangeToIsNotEditableEvent());
                    // context.read<SelectedDepartmentBloc>().add(
                    //       const SelectedDepartmentEvent.unselectDepartmentEntityEvent(),
                    //     );
                  },
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: themeData.canvasColor,
                  backgroundImage: const AssetImage("assets/images/flutter_logo.png"),
                ),
                title: Text("Mehmet Bilgic"),
                subtitle: Text("23 Tage /27 Tage eingesetzt"),
                trailing: RichText(
                  text: TextSpan(
                      text: "23",
                      style: themeData.textTheme.bodyText2?.copyWith(color: Colors.green, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(text: "/27", style: themeData.textTheme.bodyText2),
                      ]),
                ),
              ),
            ),
            // Builds 1000 ListTiles
            childCount: 1000,
          ),
        )
      ],
    );
  }
}
