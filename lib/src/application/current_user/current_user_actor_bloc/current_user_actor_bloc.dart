import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_user_actor_event.dart';
part 'current_user_actor_state.dart';

class CurrentUserActorBloc extends Bloc<CurrentUserActorEvent, CurrentUserActorState> {
  CurrentUserActorBloc() : super(CurrentUserActorInitial()) {
    on<CurrentUserActorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
