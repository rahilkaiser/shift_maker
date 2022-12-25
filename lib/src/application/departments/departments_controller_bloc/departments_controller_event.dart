part of 'departments_controller_bloc.dart';

@freezed
class DepartmentsControllerEvent with _$DepartmentsControllerEvent {
  const factory DepartmentsControllerEvent.createDepartment({
    required DepartmentEntity departmentEntity,
    required List<File> imageFileList,
  }) = CreateDepartment;

  const factory DepartmentsControllerEvent.deleteDepartment({
    required UniqueId departId,
  }) = DeleteDepartment;

  const factory DepartmentsControllerEvent.updateDepartment({
    required DepartmentEntity departmentEntity,
    required List<File> imageFileList,
  }) = UpdateDepartment;
}
