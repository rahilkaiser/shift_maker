import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../core/util/failures/object_failures/department_failure.dart';

import '../../../domain/entities/core/unique_id.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/department/department_entity.dart';
import '../../../domain/entities/user/user_role.dart';
import '../../../domain/repositories/department/department_repository.dart';
import '../../extensions/firebase_helpers.dart';
import '../../models/department/department_model.dart';

class DepartmentRepositoryImpl implements DepartmentRepository {
  final FirebaseFirestore firestore;

  DepartmentRepositoryImpl({required this.firestore});

  @override
  Either<DepartmentFailure, Unit> create(DepartmentEntity departmentEntity) {
    // // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Either<DepartmentFailure, Unit> delete(UniqueId uniqueId) {
    // // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Either<DepartmentFailure, Unit> update(DepartmentEntity departmentEntity) {
    // // TODO: implement update
    //
    throw UnimplementedError();
  }

  @override
  Stream<Either<DepartmentFailure, List<DepartmentEntity>>> watchAll() async* {
    final userDocRef = await firestore.getCurrentUserDocument();
    final currUserRole = await firestore.getCurrentUserRole();

    var result = firestore.collection("departments").snapshots().map(
      (snap) {
        return right<DepartmentFailure, List<DepartmentEntity>>(
          snap.docs
              .map(
                (doc) {
                  if (currUserRole == UserRole.MANAGER && doc.data()['manager'].id == userDocRef.id) {
                    return DepartmentModel.fromFireStore(doc).toEntity();
                  }
                },
              )
              .whereType<DepartmentEntity>()
              .toList(),
        );
      },
    )
        //Error handling Left Side
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') || e.code.contains('PERMISSION_DENIED')) {
          return left(InsufficientPermissions());
        }
        return left(GeneralFailure());
      } else {
        return left(GeneralFailure());
      }
    });

    yield* result;
  }
}
