part of 'current_user_watcher_bloc.dart';

@immutable
abstract class CurrentUserWatcherEvent {
}

class CurrentUserGetEvent extends CurrentUserWatcherEvent {}
class CurrentUserUpdatedEvent extends CurrentUserWatcherEvent {}
