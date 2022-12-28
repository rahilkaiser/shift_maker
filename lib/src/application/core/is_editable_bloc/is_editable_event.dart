part of 'is_editable_bloc.dart';

@immutable
abstract class IsEditableEvent {}

class ChangeDepartToIsEditableEvent extends IsEditableEvent {}

class ChangeDepartToIsNotEditableEvent extends IsEditableEvent {}

class ChangeWorkerToIsEditableEvent extends IsEditableEvent {}

class ChangeWorkerToIsNotEditableEvent extends IsEditableEvent {}
