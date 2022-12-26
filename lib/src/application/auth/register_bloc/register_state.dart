part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  factory RegisterState({
    required GlobalKey<FormState> formKey,
    required GlobalKey<FormState> formKeyData,
    required String emailAddress,
    required String password,
    required String name,
    required String phoneNum,
    required bool isSubmitting,
    required Option<Either<AuthFailure, Unit>> failureOrSuccessOption,
  }) = _RegisterState;

  const RegisterState._();

  factory RegisterState.initial() => RegisterState(
        formKey: GlobalKey<FormState>(),
        formKeyData: GlobalKey<FormState>(),
        emailAddress: "",
        password: "",
        name: "",
        phoneNum: "",
        isSubmitting: false,
        failureOrSuccessOption: none(),
      );
}
