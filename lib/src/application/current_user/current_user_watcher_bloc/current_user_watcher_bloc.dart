import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'current_user_watcher_event.dart';
part 'current_user_watcher_state.dart';

class CurrentUserWatcherBloc extends Bloc<CurrentUserWatcherEvent, CurrentUserWatcherState> {
  CurrentUserWatcherBloc() : super(CurrentUserWatcherInitial()) {
    on<CurrentUserWatcherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
