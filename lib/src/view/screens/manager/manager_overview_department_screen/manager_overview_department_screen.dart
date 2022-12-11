import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

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
        child: const Icon(Icons.add, size: 35),
        onPressed: () {
          AutoRouter.of(context).push(ManagerDepartmentDetailsRoute(departmentEntity: null));
        },
      ),
      body: const ManagerOverviewDepartmentScreenBody(),
    );
  }
}
