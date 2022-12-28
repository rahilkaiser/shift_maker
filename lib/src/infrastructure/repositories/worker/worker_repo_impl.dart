import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/util/failures/worker_failures/worker_failures.dart';
import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/user/user_role.dart';
import '../../../domain/entities/users/worker/worker_entity.dart';
import '../../../domain/repositories/worker/worker_repo.dart';
import '../../extensions/firebase_helpers.dart';
import '../../models/auth/worker_model/worker_model.dart';

class WorkerRepoImpl implements WorkerRepo {
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  WorkerRepoImpl({
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<WorkerFailure, Unit>> create(WorkerEntity workerEntity) {
    throw UnimplementedError();
  }

  @override
  Future<Either<WorkerFailure, Unit>> delete(UniqueId uniqueId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<WorkerFailure, Unit>> update(WorkerEntity workerEntity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<WorkerFailure, List<WorkerEntity>>> watchAll() async* {
    final userDocRef = await firestore.getCurrentUserDocument();
    final currUserRole = await firestore.getCurrentUserRole();

    var res = firestore.collection("users").snapshots().map((snap) {
      return right<WorkerFailure, List<WorkerEntity>>(snap.docs
          .map((doc) {
            if (currUserRole == UserRole.MANAGER) { // am i currently manager
              if(doc.data()['role'] == UserRole.WORKER) { //is doc a worker
                if(doc.data()['manager'].id == userDocRef.id) { // only pick my workers
                  return WorkerModel.fromFireStore(doc).toEntity();
                }
              }
            }
          })
          .whereType<WorkerEntity>()
          .toList());
    }).handleError((e) {});

    yield* res;
  }
}
