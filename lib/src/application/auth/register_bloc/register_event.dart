part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.emailChanged({required String email}) = EmailChanged;

  const factory RegisterEvent.passwordChanged({required String password}) = PasswordChanged;

  const factory RegisterEvent.nameChanged({required String name}) = NameChanged;

  const factory RegisterEvent.phoneNumberChanged({required String phoneNum}) = PhoneNumberChanged;

  const factory RegisterEvent.registerWithEmailAndPasswordPressed() = RegisterWithEmailAndPasswordPressed;
}
