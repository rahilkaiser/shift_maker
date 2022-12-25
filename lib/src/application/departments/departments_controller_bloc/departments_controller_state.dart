part of 'departments_controller_bloc.dart';

@freezed
class DepartmentsControllerState with _$DepartmentsControllerState {
  const factory DepartmentsControllerState({
    required DepartmentEntity departmentEntity,
    required bool isLoading,
    required Option<Either<DepartmentFailure, Unit>> failureOrSuccessOption,
  }) = _DepartmentsControllerState;

    const DepartmentsControllerState._();

  factory DepartmentsControllerState.initial() => DepartmentsControllerState(
        departmentEntity: DepartmentEntity.empty(),
        isLoading: false,
        failureOrSuccessOption: none(),
      );
}
