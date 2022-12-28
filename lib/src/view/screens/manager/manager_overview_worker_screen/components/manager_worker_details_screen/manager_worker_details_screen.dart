import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../application/workers/worker_controller_bloc/worker_controller_bloc.dart';
import '../../../../../../domain/entities/users/worker/worker_entity.dart';
import '../../../../../../injection.dart';
import 'components/manager_worker_details_screen_body.dart';

class ManagerWorkerDetailsScreen extends StatelessWidget {
  final WorkerEntity worker;

  const ManagerWorkerDetailsScreen({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkerControllerBloc>(
      create: (context) => serviceLocator<WorkerControllerBloc>(),
      child: Scaffold(
        body: ManagerWorkerDetailsScreenBody(worker: this.worker),
      ),
    );
  }
}
