part of 'department_observer_bloc.dart';

@immutable
abstract class DepartmentObserverEvent {}

class ObserveAllEvent extends DepartmentObserverEvent {}

class FetchNextPageEvent extends DepartmentObserverEvent {}

class RefreshEvent extends DepartmentObserverEvent {}

class DepartmentUpdatedEvent extends DepartmentObserverEvent {
  final Either<DepartmentFailure, List<DepartmentEntity>> failureOrDepart;

  DepartmentUpdatedEvent({
    required this.failureOrDepart,
  });
}
