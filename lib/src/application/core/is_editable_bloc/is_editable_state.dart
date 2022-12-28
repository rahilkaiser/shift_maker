part of 'is_editable_bloc.dart';

class IsEditableState {
  final bool departIsEditable;
  final bool workerIsEditable;

  IsEditableState({
    required this.departIsEditable,
    required this.workerIsEditable,
  });

  IsEditableState copyWith({
    bool? departIsEditable,
    bool? workerIsEditable,
  }) {
    return IsEditableState(
      departIsEditable: departIsEditable ?? this.departIsEditable,
      workerIsEditable: workerIsEditable ?? this.workerIsEditable,
    );
  }
}
