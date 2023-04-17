import 'dart:io';

import 'package:dartz/dartz.dart';


import '../../../core/util/failures/object_failures/department_failure.dart';
import '../../../core/util/failures/worker_failures/worker_failures.dart';
import '../../entities/core/unique_id.dart';
import '../../entities/department/department_entity.dart';
import '../../entities/users/worker/worker_entity.dart';

abstract class WorkerRepo {

  /// Listens to all Workers
  ///
  ///
  Stream<Either<WorkerFailure,List<WorkerEntity>>> watchAll();

  /// Creates a new Worker
  ///
  ///
  Future<Either<WorkerFailure,Unit>> create(WorkerEntity workerEntity, File? image);

  /// Updates a Worker
  ///
  ///
  Future<Either<WorkerFailure,Unit>> update(WorkerEntity workerEntity);

  /// Deletes a Worker
  ///
  ///
  Future<Either<WorkerFailure,Unit>> delete(UniqueId uniqueId);
}
