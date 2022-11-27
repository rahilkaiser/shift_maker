part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    required GlobalKey<FormState> formKey,
    required String emailAddress,
    required String password,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> failureOrSuccessOption,
  }) = _LoginState;

  const LoginState._();

  factory LoginState.initial() => LoginState(
        formKey: GlobalKey<FormState>(),
        emailAddress: "",
        password: "",
        isSubmitting: false,
        failureOrSuccessOption: none(),
      );
}
