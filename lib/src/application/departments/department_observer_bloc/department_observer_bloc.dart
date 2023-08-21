import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';

import '../../../core/util/failures/object_failures/department_failure.dart';
import '../../../domain/entities/department/department_entity.dart';
import '../../../domain/repositories/department/department_repository.dart';

part 'department_observer_event.dart';

part 'department_observer_state.dart';

class DepartmentObserverBloc extends Bloc<DepartmentObserverEvent, DepartmentObserverState> {
  final DepartmentRepository departmentRepository;
  final PagingController<int, DepartmentEntity> pagingController = PagingController(firstPageKey: 1);

  DepartmentObserverBloc({required this.departmentRepository}) : super(DepartmentObserverInitialState()) {


     on<RefreshEvent>((event, emit) async {
       pagingController.refresh();
       emit(DepartmentObserverInitialState()); // or any other appropriate initial state
       emit(DepartmentObserverLoadingState());
       final failureOrDepart = await departmentRepository.getDepartments(1, null);
       emit(
         failureOrDepart.fold(
           (failure) => DepartmentObserverFailureState(departmentFailure: failure),
           (result) => DepartmentObserverPaginationState(
             currentPage: 1,
             departments: result.value1,
             lastDoc: result.value2,
           ),
         ),
       );
     });


    on<ObserveAllEvent>((event, emit) async {
      emit(DepartmentObserverLoadingState());
      final failureOrDepart = await departmentRepository.getDepartments(1, null);
      emit(
        failureOrDepart.fold(
          (failure) => DepartmentObserverFailureState(departmentFailure: failure),
          (result) => DepartmentObserverPaginationState(
            currentPage: 1,
            departments: result.value1,
            lastDoc: result.value2,
          ),
        ),
      );
    });

    on<FetchNextPageEvent>((event, emit) async {
      if (this.state is DepartmentObserverPaginationState) {
        final currentState = this.state as DepartmentObserverPaginationState;
        final nextPage = currentState.currentPage + 1;
        final failureOrDepart = await departmentRepository.getDepartments(nextPage, currentState.lastDoc);
        emit(
          failureOrDepart.fold(
            (failure) => DepartmentObserverFailureState(departmentFailure: failure),
            (result) => DepartmentObserverPaginationState(
              currentPage: nextPage,
              departments: currentState.departments + result.value1,
              lastDoc: result.value2,
            ),
          ),
        );
      }
    });

  }
}
