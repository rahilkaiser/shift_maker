import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../application/departments/departments_controller_bloc/departments_controller_bloc.dart';
import '../../../../../../domain/entities/department/department_entity.dart';
import '../../../../../../injection.dart';
import 'components/manager_edit_department_screen_body.dart';

class ManagerDepartmentDetailsScreen extends StatelessWidget {
  final DepartmentEntity departmentEntity;

  const ManagerDepartmentDetailsScreen({Key? key, required this.departmentEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DepartmentsControllerBloc>(
        create: (context) => serviceLocator<DepartmentsControllerBloc>(),
      child: Scaffold(
        body: ManagerEditDepartmentScreenBody(
          departmentEntity: this.departmentEntity,
        ),
      ),
    );
  }
}
