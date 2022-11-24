part of 'auth_bloc.dart';

@immutable
class AuthState {
  final bool isSubmitting;
  final bool showValidationMessages;

  AuthState({required this.isSubmitting, required this.showValidationMessages});
}
