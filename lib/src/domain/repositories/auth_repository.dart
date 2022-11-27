import 'package:dartz/dartz.dart';

import '../../core/util/failures/auth_failures/auth_failure.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPasswort(
      {required String emailAddress, required String password});

  Future<Either<AuthFailure, Unit>> loginWithEmailAndPasswort(
      {required String emailAddress, required String password});
}
