part of 'selected_department_bloc.dart';

@freezed
class SelectedDepartmentState with _$SelectedDepartmentState {
  factory SelectedDepartmentState({
    required DepartmentEntity? departmentEntity,
  }) = _SelectedDepartmentState;

  const SelectedDepartmentState._();

  factory SelectedDepartmentState.initial() => SelectedDepartmentState(
        departmentEntity: null,
      );
}
