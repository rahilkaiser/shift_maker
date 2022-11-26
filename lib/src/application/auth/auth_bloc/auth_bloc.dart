import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(isSubmitting: false, showValidationMessages: false)) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) {
      emit(AuthState(isSubmitting: false, showValidationMessages: true));
    });

    on<LoginWithEmailAndPasswordPressed>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(AuthState(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(AuthState(isSubmitting: true, showValidationMessages: false));
        // TODO: Trigger authentication
      }
    });
    //
    // void changeEmailAddress(EmailChanged event, Emitter<SignInFormState> emit) {
    //   emit(
    //     state.copyWith(
    //       emailAddress: EmailAddress(event.email),
    //       authFailureOrSuccessOption: none(),
    //     ),
    //   );
    // }
    //
    // void changePassword(PasswordChanged event, Emitter<SignInFormState> emit) {
    //   emit(
    //     state.copyWith(
    //       password: Password(event.password),
    //       authFailureOrSuccessOption: none(),
    //     ),
    //   );
    // }
  }
}
