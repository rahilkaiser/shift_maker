part of 'selected_worker_bloc.dart';

@freezed
class SelectedWorkerState with _$SelectedWorkerState {
  factory SelectedWorkerState({
    required WorkerEntity? workerEntity,
  }) = _SelectedWorkerState;

  factory SelectedWorkerState.initial() => SelectedWorkerState(
        workerEntity: null,
      );
}
