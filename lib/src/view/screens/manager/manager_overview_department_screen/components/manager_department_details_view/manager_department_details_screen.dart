import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/entities/department/department_entity.dart';
import 'components/manager_create_department_screen_body.dart';
import 'components/manager_edit_department_screen_body.dart';

class ManagerDepartmentDetailsScreen extends StatelessWidget {
  final DepartmentEntity? departmentEntity;

  const ManagerDepartmentDetailsScreen({Key? key, required this.departmentEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.check, size: 35),
      //   onPressed: () {},
      // ),
      body: this.departmentEntity == null
          ? const ManagerCreatDepartmentScreenBody()
          : ManagerEditDepartmentScreenBody(
              departmentEntity: this.departmentEntity!,
            ),
    );
  }
}
