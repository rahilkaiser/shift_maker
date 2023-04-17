import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final FirebaseFunctions firebaseFunctions;

  WorkerRepoImpl({
    required this.firestore,
    required this.firebaseStorage,
    required this.firebaseFunctions,
    // required this.firebaseAdmin,
  });

  @override
  Future<Either<WorkerFailure, Unit>> create(WorkerEntity workerEntity, File? image) async {
    // FirebaseApp app = await Firebase.initializeApp(name: 'Secondary', options: Firebase.app().options);
    // await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(email: workerEntity.email, password: "qqqqqqqq");

    // await app.delete();
    try {
      HttpsCallable callable = this.firebaseFunctions.httpsCallable("createWorker");
      final resp = await callable.call(WorkerModel.fromEntity(workerEntity).toMap());
      print(resp);
    } on FirebaseFunctionsException catch (e) {
      if (e.code == "invalid-argument") {
        return left(WorkerCreateInvalidArgument());
      }
      if (e.code == "permission-denied") {
        return left(WorkerInsufficientPermissions());
      }

      return left(WorkerGeneralFailure());
    } catch (e) {
      return left(WorkerGeneralFailure());
    }

    return right(unit);
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
            if (currUserRole == UserRole.MANAGER) {
              // am i currently manager
              if (doc.data()['role'] == UserRole.WORKER) {
                //is doc a worker
                if (doc.data()['manager'].id == userDocRef.id) {
                  // only pick my workers
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
