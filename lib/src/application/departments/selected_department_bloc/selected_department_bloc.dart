import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/department/department_entity.dart';

part 'selected_department_event.dart';

part 'selected_department_state.dart';

part 'selected_department_bloc.freezed.dart';

class SelectedDepartmentBloc extends Bloc<SelectedDepartmentEvent, SelectedDepartmentState> {
  SelectedDepartmentBloc() : super(SelectedDepartmentState.initial()) {
    on<SelectDepartmentEntityEvent>((event, emit) {
      emit(SelectedDepartmentState(departmentEntity: event.departmentEntity));
    });

    on<UnselectDepartmentEntityEvent>((event, emit) {
      emit(SelectedDepartmentState(departmentEntity: null));
    });
  }
}
