import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'is_editable_event.dart';

part 'is_editable_state.dart';

class IsEditableBloc extends Bloc<IsEditableEvent, IsEditableState> {
  IsEditableBloc()
      : super(IsEditableState(
          departIsEditable: false,
          workerIsEditable: false,
        )) {
    on<ChangeDepartToIsEditableEvent>((event, emit) {
      emit(state.copyWith(departIsEditable: true));
    });

    on<ChangeDepartToIsNotEditableEvent>((event, emit) {
      emit(state.copyWith(departIsEditable: false));
    });

    on<ChangeWorkerToIsEditableEvent>((event, emit) {
      emit(state.copyWith(workerIsEditable: true));
    });

    on<ChangeWorkerToIsNotEditableEvent>((event, emit) {
      emit(state.copyWith(workerIsEditable: false));
    });
  }
}
