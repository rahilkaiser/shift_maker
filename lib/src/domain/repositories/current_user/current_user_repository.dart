import 'package:dartz/dartz.dart';


import '../../../core/util/failures/current_user_failure/current_user_failure.dart';

import '../../entities/user/user_entity.dart';

abstract class CurrentUserRepository {

  /// Listens to the current logged in User
  ///
  ///
  Future<Either<CurrentUserFailure,UserEntity>> getCurrentUserEntity();

  // Settings und Systemeinstellungen updaten

  // eigene Favoriten liste und FilterListe updaten


  // Daten Updaten und so
  // /// Updates a Department
  // ///
  // ///
  // Either<DepartmentFailure,Unit> update(DepartmentEntity departmentEntity);

}
