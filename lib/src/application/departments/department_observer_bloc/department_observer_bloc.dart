import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/util/failures/object_failures/department_failure.dart';
import '../../../domain/entities/department/department_entity.dart';
import '../../../domain/repositories/department/department_repository.dart';

part 'department_observer_event.dart';

part 'department_observer_state.dart';

class DepartmentObserverBloc extends Bloc<DepartmentObserverEvent, DepartmentObserverState> {
  final DepartmentRepository departmentRepository;

  StreamSubscription<Either<DepartmentFailure, List<DepartmentEntity?>>>? _streamSubscription;

  DepartmentObserverBloc({required this.departmentRepository}) : super(DepartmentObserverInitialState()) {
    on<ObserveAllEvent>((event, emit) async {
      this.observeAllEvents(event, emit);
    });

    on<DepartmentUpdatedEvent>((event, emit) async {
      this.observeDepartmentUpdated(event, emit);
    });
  }

  Future<void> observeAllEvents(ObserveAllEvent event, Emitter<DepartmentObserverState> emit) async {
    print("AAAAA");

    emit(DepartmentObserverLoadingState());
    await this._streamSubscription?.cancel();

    this._streamSubscription = departmentRepository.watchAll().listen(
      (failureOrDepart) {
        print("TEST");
        add(DepartmentUpdatedEvent(failureOrDepart: failureOrDepart));
      },
    );
  }

  void observeDepartmentUpdated(DepartmentUpdatedEvent event, Emitter<DepartmentObserverState> emit) {
    print("EEEEE");
    print(event.failureOrDepart);

    event.failureOrDepart.fold(
      (failure) => emit(DepartmentObserverFailureState(departmentFailure: failure)),
      (departs) => emit(DepartmentObserverSuccessState(departmentEntities: departs)),
    );
  }

  @override
  Future<void> close() async {
    print("CLOSE");
    await this._streamSubscription?.cancel();
    return super.close();
  }
}
