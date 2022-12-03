part of 'current_user_watcher_bloc.dart';

@immutable
abstract class CurrentUserWatcherState {}

class CurrentUserWatcherInitialState extends CurrentUserWatcherState {}

class CurrentUserWatcherLoadingState extends CurrentUserWatcherState {}

class CurrentUserWatcherSuccessState extends CurrentUserWatcherState {
  final UserEntity userEntity;

  CurrentUserWatcherSuccessState({required this.userEntity});
}

class CurrentUserWatcherFailureState extends CurrentUserWatcherState {
  final CurrentUserFailure currentUserFailure;

  CurrentUserWatcherFailureState({
    required this.currentUserFailure,
  });
}
