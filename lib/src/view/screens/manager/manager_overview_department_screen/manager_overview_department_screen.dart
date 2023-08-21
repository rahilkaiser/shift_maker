import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../application/departments/selected_department_bloc/selected_department_bloc.dart';
import '../../../routes/router.gr.dart';
import 'components/manager_overview_department_screen_body.dart';

class ManagerOverviewDepartmentScreen extends StatelessWidget {
  const ManagerOverviewDepartmentScreen({Key? key}) : super(key: key);

  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "create-departments",
        child: const Icon(Icons.add, size: 35),
        onPressed: () {
          // context.read<SelectedDepartmentBloc>().add(const SelectedDepartmentEvent.unselectDepartmentEntityEvent());
          AutoRouter.of(context).push(ManagerDepartmentEditorRoute(departmentEntity: null)).then(
            (value) {
              context.read<IsEditableBloc>().add(ChangeWorkerToIsNotEditableEvent());
            },
          );
        },
      ),
      body: ManagerOverviewDepartmentScreenBody(),
    );
  }
}
