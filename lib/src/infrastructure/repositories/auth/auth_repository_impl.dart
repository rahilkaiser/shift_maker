import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/util/errors/errors.dart';
import '../../../core/util/failures/auth_failures/auth_failure.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../extensions/firebase_helpers.dart';
import '../../extensions/firebase_user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepositoryImpl({required this.firebaseAuth, required this.firestore});

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPasswort(
      {required String emailAddress, required String password}) async {
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
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPasswort(
      {required String emailAddress, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: emailAddress, password: password);

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
  Future<void> logout() => Future.wait([firebaseAuth.signOut()]);

  @override
  Future<Option<UserEntity>> getSignedInUser() async {
    return optionOf(await firebaseAuth.currentUser?.toEntity());
  }
}
