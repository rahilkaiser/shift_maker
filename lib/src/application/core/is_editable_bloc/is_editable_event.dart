part of 'is_editable_bloc.dart';

@immutable
abstract class IsEditableEvent {}

class ChangeToIsEditableEvent extends IsEditableEvent {}

class ChangeToIsNotEditableEvent extends IsEditableEvent {}
