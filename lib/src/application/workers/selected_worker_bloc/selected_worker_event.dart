part of 'selected_worker_bloc.dart';

@freezed
class SelectedWorkerEvent with _$SelectedWorkerEvent {
  const factory SelectedWorkerEvent.selectWorkerEntityEvent({required WorkerEntity workerEntity}) = SelectWorkerEntityEvent;
  const factory SelectedWorkerEvent.unselectWorkerEntityEvent() = UnselectWorkerEntityEvent;
}
