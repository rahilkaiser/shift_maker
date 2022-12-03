import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/util/failures/current_user_failure/current_user_failure.dart';
import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/repositories/current_user/current_user_repository.dart';

part 'current_user_watcher_event.dart';

part 'current_user_watcher_state.dart';

class CurrentUserWatcherBloc extends Bloc<CurrentUserWatcherEvent, CurrentUserWatcherState> {
  final CurrentUserRepository currentUserRepository;

  CurrentUserWatcherBloc({required this.currentUserRepository}) : super(CurrentUserWatcherInitialState()) {
    on<CurrentUserGetEvent>((event, emit) async {
      print("CURRENT USER");

      emit(CurrentUserWatcherLoadingState());

      final failureOrUserEntity = await this.currentUserRepository.getCurrentUserEntity();

      failureOrUserEntity.fold(
        (failure) => emit(CurrentUserWatcherFailureState(currentUserFailure: failure)),
        (userEntity) => emit(CurrentUserWatcherSuccessState(userEntity: userEntity)),
      );
    });
  }

// @override
// Future<void> close() async {
//   await this._streamSubscription?.cancel();
//   return super.close();
// }
}
