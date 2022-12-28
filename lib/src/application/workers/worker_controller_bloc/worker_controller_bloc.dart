import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/failures/worker_failures/worker_failures.dart';
import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/users/worker/worker_entity.dart';
import '../../../domain/repositories/worker/worker_repo.dart';

part 'worker_controller_event.dart';

part 'worker_controller_state.dart';

part 'worker_controller_bloc.freezed.dart';

class WorkerControllerBloc extends Bloc<WorkerControllerEvent, WorkerControllerState> {
  final WorkerRepo workerRepo;

  WorkerControllerBloc({required this.workerRepo}) : super(WorkerControllerState.initial()) {
    on<CreateWorker>((event, emit) {
      // TODO: implement event handler
    });
    on<UpdateWorker>((event, emit) {
      // TODO: implement event handler
    });

    on<DeleteWorker>((event, emit) {
      // TODO: implement event handler
    });
  }
}
