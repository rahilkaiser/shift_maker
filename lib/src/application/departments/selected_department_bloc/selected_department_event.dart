part of 'selected_department_bloc.dart';

@freezed
class SelectedDepartmentEvent with _$SelectedDepartmentEvent {
  const factory SelectedDepartmentEvent.selectDepartmentEntityEvent({required DepartmentEntity departmentEntity}) = SelectDepartmentEntityEvent;

  const factory SelectedDepartmentEvent.unselectDepartmentEntityEvent() = UnselectDepartmentEntityEvent;
}
