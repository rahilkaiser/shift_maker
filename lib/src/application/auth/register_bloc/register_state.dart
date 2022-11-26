part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    required GlobalKey<FormState> formKey,
    required String emailAddress,
    required String password,
    required bool isSubmitting,
  }) = _RegisterState;

  const RegisterState._();

  factory RegisterState.initial() => RegisterState(
    formKey: GlobalKey<FormState>(),
    emailAddress: "",
    password: "",
    isSubmitting: false,
  );
}
