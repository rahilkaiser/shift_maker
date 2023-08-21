import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  final FirebaseStorage firebaseStorage;

  DepartmentRepositoryImpl({
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<DepartmentFailure, Unit>> create(DepartmentEntity departmentEntity, List<File> imageList) async {
    try {
      final managerDocRef = await this.firestore.getCurrentUserDocument();

      for (var file in imageList) {
        await this.firebaseStorage.ref('${managerDocRef.id}/departments/${departmentEntity.id.value}/${file.path
            .split("/")
            .last}').putFile(
          file,
        );
      }

      ListResult result = await this.firebaseStorage.ref('${managerDocRef.id}/departments/${departmentEntity.id.value}').listAll();

      List<String> downloadUrls = await Future.wait(result.items.map((item) => item.getDownloadURL()).toList());

      //Store in Firestore
      DepartmentModel departmentModel = DepartmentModel.fromEntity(departmentEntity).copyWith(images: downloadUrls, manager: managerDocRef);

      await this.firestore.collection("departments").doc(departmentModel.id).set(departmentModel.toMap());

      return right(unit);
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<DepartmentFailure, Unit>> update(DepartmentEntity departmentEntity, List<File> imageList) async {
    try {
      final managerDocRef = await this.firestore.getCurrentUserDocument();

      await this.firebaseStorage.ref('${managerDocRef.id}/departments/${departmentEntity.id.value}').listAll().then((images) {
        images.items.forEach((image) async {
          await this.firebaseStorage.ref(image.fullPath).delete();
        });
      });

      for (var file in imageList) {
        await this.firebaseStorage.ref('${managerDocRef.id}/departments/${departmentEntity.id.value}/${file.path
            .split("/")
            .last}').putFile(
          file,
        );
      }

      ListResult result = await this.firebaseStorage.ref('${managerDocRef.id}/departments/${departmentEntity.id.value}').listAll();
      List<String> downloadUrls = await Future.wait(result.items.map((item) => item.getDownloadURL()).toList());

      DepartmentModel departmentModel = DepartmentModel.fromEntity(departmentEntity).copyWith(images: downloadUrls, manager: managerDocRef);
      await this.firestore.collection("departments").doc(departmentModel.id).update(departmentModel.toMap());

      return right(unit);
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<DepartmentFailure, Unit>> delete(UniqueId depId) async {
    try {
      final managerDocRef = await this.firestore.getCurrentUserDocument();

      //DELETE FIRESTOrage
      await this.firebaseStorage.ref('${managerDocRef.id}/departments/${depId.value}').listAll().then((images) {
        images.items.forEach((image) async {
          print("NJNKJNKNKNNJKKNKJNKN");
          print(image.fullPath);
          await this.firebaseStorage.ref(image.fullPath).delete();
        });
      });

      //DELETE Doc from Firestore
      await this.firestore.collection("departments").doc(depId.value).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        // NOT_FOUND
        return left(InsufficientPermissions());
      }

      return left(GeneralFailure());
    }
  }

  Future<Either<DepartmentFailure, Tuple2<List<DepartmentEntity>, DocumentSnapshot?>>> getDepartments(int page, DocumentSnapshot? lastDoc) async {
    try {
      final userDocRef = await firestore.getCurrentUserDocument();
      final currUserRole = await firestore.getCurrentUserRole();

      QuerySnapshot snapshot;
      int documentsToRetrieve = 20;

      if (page == 1 || lastDoc == null) {
        snapshot = await firestore.collection("departments").limit(documentsToRetrieve).get();
      } else {
        snapshot = await firestore.collection("departments").startAfterDocument(lastDoc).limit(documentsToRetrieve).get();
      }

      final departments = snapshot.docs
          .map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        if (currUserRole == UserRole.MANAGER && data['manager']?.id == userDocRef.id) {
          return DepartmentModel.fromFireStore(doc as QueryDocumentSnapshot<Map<String, dynamic>>).toEntity();
        }
        return null;
      })
          .where((item) => item != null)
          .cast<DepartmentEntity>()
          .toList();

      DocumentSnapshot? lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;

      return right(Tuple2(departments, lastDocument));
    } catch (e) {
      print(e);
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') || e.code.contains('PERMISSION_DENIED')) {
          return left(InsufficientPermissions());
        }
        return left(GeneralFailure());
      } else {
        return left(GeneralFailure());
      }
    }
  }
}
