import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../application/core/is_editable_bloc/is_editable_bloc.dart';
import '../../../../../../../domain/entities/users/worker/worker_entity.dart';

class ManagerWorkerDetailsScreenBody extends StatefulWidget {
  final WorkerEntity worker;

  const ManagerWorkerDetailsScreenBody({Key? key, required this.worker}) : super(key: key);

  @override
  State<ManagerWorkerDetailsScreenBody> createState() => _ManagerWorkerDetailsScreenBodyState();
}

class _ManagerWorkerDetailsScreenBodyState extends State<ManagerWorkerDetailsScreenBody> {


  @override
  void initState() {
    context.read<IsEditableBloc>().add(ChangeWorkerToIsEditableEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.worker.forename),
    );
  }
}
