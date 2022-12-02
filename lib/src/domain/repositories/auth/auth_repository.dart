import 'package:dartz/dartz.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../../entities/user/user_entity.dart';
import '../../entities/users/worker/worker_entity.dart';

abstract class AuthRepository {
  /// Registers User with Email and Password
  ///
  ///
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPasswort(
      {required String emailAddress, required String password});

  /// Logs User in with Email and Password
  ///
  ///
  Future<Either<AuthFailure, Unit>> loginWithEmailAndPasswort(
      {required String emailAddress, required String password});

  /// Logs current User out
  ///
  ///
  Future<void> logout();

  Future<Option<UserEntity>> getSignedInUser();
}
