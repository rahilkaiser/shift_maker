part of 'worker_controller_bloc.dart';

@freezed
class WorkerControllerEvent with _$WorkerControllerEvent {
  const factory WorkerControllerEvent.createWorker({
    required WorkerEntity workerEntity,
  }) = CreateWorker;

  const factory WorkerControllerEvent.deleteWorker({
    required UniqueId workerId,
  }) = DeleteWorker;

  const factory WorkerControllerEvent.updateWorker({
    required WorkerEntity workerEntity,
  }) = UpdateWorker;
}
