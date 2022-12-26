import 'package:flutter/material.dart';

import '../../../../../../domain/entities/users/worker/worker_entity.dart';

class ManagerWorkerDetailsScreen extends StatelessWidget {
  final WorkerEntity? worker;

  const ManagerWorkerDetailsScreen({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}
