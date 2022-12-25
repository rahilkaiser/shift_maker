import 'dart:io';

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
  Future<Either<DepartmentFailure,Unit>> create(DepartmentEntity departmentEntity, List<File> imageList);

  /// Updates a Department
  ///
  ///
  Future<Either<DepartmentFailure,Unit>> update(DepartmentEntity departmentEntity, List<File> imageList);

  /// Deletes a Department
  ///
  ///
  Future<Either<DepartmentFailure,Unit>> delete(UniqueId uniqueId);
}
