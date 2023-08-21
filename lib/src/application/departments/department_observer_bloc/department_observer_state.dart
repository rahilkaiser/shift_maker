part of 'department_observer_bloc.dart';

@immutable
abstract class DepartmentObserverState {}

class DepartmentObserverInitialState extends DepartmentObserverState {}

class DepartmentObserverLoadingState extends DepartmentObserverState {}

class DepartmentObserverPaginationState extends DepartmentObserverState {
  final List<DepartmentEntity> departments;
  final int currentPage;
  final DocumentSnapshot? lastDoc;

  DepartmentObserverPaginationState({
    required this.currentPage,
    required this.departments,
    required this.lastDoc,
  });

}

class DepartmentObserverFailureState extends DepartmentObserverState {
  final DepartmentFailure departmentFailure;

  DepartmentObserverFailureState({
    required this.departmentFailure,
  });
}
