part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class EmailChanged extends AuthEvent {
  final String? email;

  EmailChanged({required this.email});
}

class PasswordChanged extends AuthEvent {
  final String? password;

  PasswordChanged({required this.password});
}

class RegisterWithEmailAndPasswordPressed extends AuthEvent {
  final String? email;
  final String? password;

  RegisterWithEmailAndPasswordPressed({required this.email, required this.password});
}

class LoginWithEmailAndPasswordPressed extends AuthEvent {
  final String? email;
  final String? password;

  LoginWithEmailAndPasswordPressed({required this.email, required this.password});
}
