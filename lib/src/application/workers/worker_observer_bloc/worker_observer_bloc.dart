import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/failures/worker_failures/worker_failures.dart';
import '../../../domain/entities/users/worker/worker_entity.dart';
import '../../../domain/repositories/worker/worker_repo.dart';

part 'worker_observer_event.dart';

part 'worker_observer_state.dart';

part 'worker_observer_bloc.freezed.dart';

class WorkerObserverBloc extends Bloc<WorkerObserverEvent, WorkerObserverState> {
  final WorkerRepo workerRepo;

  StreamSubscription<Either<WorkerFailure, List<WorkerEntity>>>? _streamSubscription;

  WorkerObserverBloc({required this.workerRepo}) : super(const WorkerObserverState.workerObserverInitialState()) {
    on<WorkerObserveAllEvent>((event, emit) {
      this.observeAllEvents(event, emit);
    });

    on<WorkerUpdatedEvent>((event, emit) {
      this.observeWorkerUpdated(event, emit);
    });
  }

  void observeAllEvents(WorkerObserveAllEvent event, Emitter<WorkerObserverState> emit) async {
    emit(const WorkerObserverState.workerObserverLoadingState());
    await this._streamSubscription?.cancel();

    this._streamSubscription = workerRepo.watchAll().listen(
      (failureOrWorker) {
        print("WORKER THIS IS IT");
        add(WorkerUpdatedEvent(failureOrWorker: failureOrWorker));
      },
    );
  }

  void observeWorkerUpdated(WorkerUpdatedEvent event, Emitter<WorkerObserverState> emit) async {
    event.failureOrWorker.fold(
        (failure) => emit(WorkerObserverState.workerObserverFailureState(
              workerFailure: failure,
            )), (workers) {
      print(workers);
      return emit(WorkerObserverState.workerObserverSuccessState(workerEntities: workers));
    });
  }

  @override
  Future<void> close() async {
    await this._streamSubscription?.cancel();
    return super.close();
  }
}
