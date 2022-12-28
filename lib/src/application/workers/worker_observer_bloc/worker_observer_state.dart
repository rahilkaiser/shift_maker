part of 'worker_observer_bloc.dart';

@freezed
class WorkerObserverState with _$WorkerObserverState {
  const factory WorkerObserverState.workerObserverInitialState() = WorkerObserverInitialState;

  const factory WorkerObserverState.workerObserverLoadingState() = WorkerObserverLoadingState;

  const factory WorkerObserverState.workerObserverSuccessState({
    required List<WorkerEntity> workerEntities,
  }) = WorkerObserverSuccessState;

  const factory WorkerObserverState.workerObserverFailureState({
    required WorkerFailure workerFailure,
  }) = WorkerObserverFailureState;
}
