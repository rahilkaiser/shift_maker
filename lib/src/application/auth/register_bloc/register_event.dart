part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.emailChanged({required String email}) = EmailChanged;

  const factory RegisterEvent.passwordChanged({required String password}) = PasswordChanged;

  const factory RegisterEvent.registerWithEmailAndPasswordPressed() = RegisterWithEmailAndPasswordPressed;
}
