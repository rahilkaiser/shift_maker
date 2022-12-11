import 'package:dartz/dartz.dart';


import '../../../core/util/failures/object_failures/department_failure.dart';
import '../../entities/core/unique_id.dart';
import '../../entities/department/department_entity.dart';

abstract class DepartmentRepository {

  /// Listens to all Departments
  ///
  ///
  Stream<Either<DepartmentFailure,List<DepartmentEntity>>> watchAll();

  /// Creates a new Department
  ///
  ///
  Either<DepartmentFailure,Unit> create(DepartmentEntity departmentEntity);

  /// Updates a Department
  ///
  ///
  Either<DepartmentFailure,Unit> update(DepartmentEntity departmentEntity);

  /// Deletes a Department
  ///
  ///
  Either<DepartmentFailure,Unit> delete(UniqueId uniqueId);
}
