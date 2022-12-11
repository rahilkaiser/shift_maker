part of 'department_observer_bloc.dart';

@immutable
abstract class DepartmentObserverState {}

class DepartmentObserverInitialState extends DepartmentObserverState {}

class DepartmentObserverLoadingState extends DepartmentObserverState {}

class DepartmentObserverSuccessState extends DepartmentObserverState {
  final List<DepartmentEntity> departmentEntities;

  DepartmentObserverSuccessState({
    required this.departmentEntities,
  });
}

class DepartmentObserverFailureState extends DepartmentObserverState {
  final DepartmentFailure departmentFailure;

  DepartmentObserverFailureState({
    required this.departmentFailure,
  });
}
