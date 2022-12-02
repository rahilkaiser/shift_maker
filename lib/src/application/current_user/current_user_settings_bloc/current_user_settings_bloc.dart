import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_user_settings_event.dart';
part 'current_user_settings_state.dart';

class CurrentUserSettingsBloc extends Bloc<CurrentUserSettingsEvent, CurrentUserSettingsState> {
  CurrentUserSettingsBloc() : super(CurrentUserSettingsInitial()) {
    on<CurrentUserSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
