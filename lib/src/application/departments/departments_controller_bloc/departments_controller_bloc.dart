import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/util/failures/object_failures/department_failure.dart';
import '../../../domain/entities/core/unique_id.dart';
import '../../../domain/entities/department/department_entity.dart';
import '../../../domain/repositories/department/department_repository.dart';

part 'departments_controller_event.dart';

part 'departments_controller_state.dart';

part 'departments_controller_bloc.freezed.dart';

class DepartmentsControllerBloc extends Bloc<DepartmentsControllerEvent, DepartmentsControllerState> {
  final DepartmentRepository departmentRepository;

  DepartmentsControllerBloc({required this.departmentRepository}) : super(DepartmentsControllerState.initial()) {
    on<CreateDepartment>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      Either<DepartmentFailure, Unit> failureOrDepart = await this.departmentRepository.create(event.departmentEntity, event.imageFileList);

      emit(state.copyWith(isLoading: false, failureOrSuccessOption: optionOf(failureOrDepart)));
    });

    on<UpdateDepartment>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      Either<DepartmentFailure, Unit> failureOrDepart = await this.departmentRepository.update(event.departmentEntity, event.imageFileList);

      emit(state.copyWith(isLoading: false, failureOrSuccessOption: optionOf(failureOrDepart)));
    });

    on<DeleteDepartment>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      Either<DepartmentFailure, Unit> failureOrDepart = await this.departmentRepository.delete(event.departId);

      emit(state.copyWith(isLoading: false, failureOrSuccessOption: optionOf(failureOrDepart)));
    });


  }
}
