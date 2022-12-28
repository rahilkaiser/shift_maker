part of 'worker_observer_bloc.dart';

@freezed
class WorkerObserverEvent with _$WorkerObserverEvent {
  const factory WorkerObserverEvent.observeAllEvent() = WorkerObserveAllEvent;

  const factory WorkerObserverEvent.workerUpdatedEvent({
    required Either<WorkerFailure, List<WorkerEntity>> failureOrWorker,
  }) = WorkerUpdatedEvent;
}
