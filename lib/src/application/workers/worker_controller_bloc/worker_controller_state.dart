part of 'worker_controller_bloc.dart';

@freezed
class WorkerControllerState with _$WorkerControllerState {
  const factory WorkerControllerState({
    required WorkerEntity workerEntity,
    required bool isLoading,
    required Option<Either<WorkerFailure, Unit>> failureOrSuccessOption,
  }) = _WorkerControllerState;

  factory WorkerControllerState.initial() => WorkerControllerState(
        workerEntity: WorkerEntity.empty(),
        isLoading: false,
        failureOrSuccessOption: none(),
      );
}
