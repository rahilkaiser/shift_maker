part of 'auth_bloc.dart';

@immutable
abstract class AuthBlocEvent {}

class RegisterWithEmailAndPasswordPressed extends AuthBlocEvent {
  final String? email;
  final String? password;

  RegisterWithEmailAndPasswordPressed({required this.email, required this.password});
}

class LoginWithEmailAndPasswordPressed extends AuthBlocEvent {
  final String? email;
  final String? password;

  LoginWithEmailAndPasswordPressed({required this.email, required this.password});
}
