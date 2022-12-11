import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'is_editable_event.dart';

part 'is_editable_state.dart';

class IsEditableBloc extends Bloc<IsEditableEvent, IsEditableState> {
  IsEditableBloc() : super(IsEditableState(isEditable: false)) {
    on<ChangeToIsEditableEvent>((event, emit) {
      emit(IsEditableState(isEditable: true));
    });

    on<ChangeToIsNotEditableEvent>((event, emit) {
      emit(IsEditableState(isEditable: false));
    });
  }
}
