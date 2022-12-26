import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/users/worker/worker_entity.dart';


part 'selected_worker_event.dart';

part 'selected_worker_state.dart';

part 'selected_worker_bloc.freezed.dart';

class SelectedWorkerBloc extends Bloc<SelectedWorkerEvent, SelectedWorkerState> {
  SelectedWorkerBloc() : super(SelectedWorkerState.initial()) {
    on<SelectWorkerEntityEvent>((event, emit) {
      emit(SelectedWorkerState(workerEntity: event.workerEntity));
    });

    on<UnselectWorkerEntityEvent>((event, emit) {
      emit(SelectedWorkerState(workerEntity: null));
    });
  }
}
