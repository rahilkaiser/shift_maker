import 'package:flutter/material.dart';

import '../../../../../../domain/entities/users/worker/worker_entity.dart';

class ManagerWorkerEditorScreen extends StatelessWidget {
  final WorkerEntity? worker;

  const ManagerWorkerEditorScreen({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
