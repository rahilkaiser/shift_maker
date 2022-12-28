import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../routes/router.gr.dart';
import 'components/manager_overview_worker_screen_body.dart';

class ManagerOverviewWorkerScreen extends StatelessWidget {
  const ManagerOverviewWorkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "create-worker",
        child: const Icon(Icons.add, size: 35),
        onPressed: () {
          // context.read<SelectedDepartmentBloc>().add(const SelectedDepartmentEvent.unselectDepartmentEntityEvent());
          AutoRouter.of(context)
              .push(ManagerWorkerEditorRoute(
            worker: null,
          ))
              .then(
            (value) {
              context.read<IsEditableBloc>().add(ChangeWorkerToIsNotEditableEvent());
            },
          );
        },
      ),
      body: ManagerOverviewWorkerScreenBody(),
    );
  }
}
