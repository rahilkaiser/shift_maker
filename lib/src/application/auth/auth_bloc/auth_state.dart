part of 'auth_bloc.dart';

@immutable
class AuthState {
  // final String? email;
  // final String? password;
  final bool isSubmitting;
  final bool showValidationMessages;

  AuthState({
    required this.isSubmitting,
    required this.showValidationMessages,
    // required this.email,
    // required this.password,
  });
}
