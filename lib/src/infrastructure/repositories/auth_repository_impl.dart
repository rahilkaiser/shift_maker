import 'package:firebase_auth/firebase_auth.dart';

import '../../core/util/failures/auth_failures/auth_failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPasswort(
      {required String emailAddress, required String password}) async {

    try {
      await firebaseAuth.signInWithEmailAndPassword(email: emailAddress, password: password);

      return right(unit);

    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {

        print("EEEE " + e.code);

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
    ;
  }
}
