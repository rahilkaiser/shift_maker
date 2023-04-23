import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/entities/user/user_role.dart';
import '../../../domain/entities/users/manager/manager_entity.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../extensions/firebase_user_mapper.dart';
import '../../models/auth/manager_model/manager_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPasswort({required String emailAddress, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {
        switch (e.code) {
          case "user-disabled":
            return left(UserDisabledFailure());
          case "user-not-found":
            return left(UserNotFoundFailure());
          default:
            return left(ServerFailure());
        }
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPasswort({
    required String emailAddress,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCred = await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      ManagerEntity managerEntity = ManagerEntity(
        id: UniqueId.fromUniqueString(userCred.user?.uid),
        role: UserRole.MANAGER,
        email: emailAddress,
        name: name,
        phoneNumber: phoneNumber,
      );

      ManagerModel managerModel = ManagerModel.fromEntity(managerEntity);
      await this.firestore.collection("users").doc(userCred.user?.uid).set(managerModel.toMap());

      return right(unit);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return left(InvalidEmailFailure());
        case "email-already-in-use":
          return left(EmailAlreadyInUseFailure());
        case "operation-not-allowed":
          return left(OperationNotAllowedFailure());
        case "weak-password":
          return left(WeakPasswordFailure());
        default:
          return left(ServerFailure());
      }
    }
  }

  @override
  Future<void> logout() {
    return Future.wait([firebaseAuth.signOut()]);
  }

  @override
  Future<Option<UserEntity>> getSignedInUser() async {
    return optionOf(await firebaseAuth.currentUser?.toEntity());
  }
}
