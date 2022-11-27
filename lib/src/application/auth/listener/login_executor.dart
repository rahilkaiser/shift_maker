import 'package:flutter/material.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../login_bloc/login_bloc.dart';

class LoginExecutor {
  LoginExecutor._();

  static void onLoginAttempt(LoginState state, BuildContext context) => state.failureOrSuccessOption.fold(
        () => {},
        (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
          (failure) {
            showButtonPressDialogForInvalidInputs(
              context,
              _mapFailureMessage(failure, state),
            );
          },
          (_) {
            showButtonPressDialogForInvalidInputs(
              context,
              "Successfully logged in",
              color: Colors.green,
            );
          },
        ),
      );

  static String _mapFailureMessage(AuthFailure failure, LoginState state) {
    switch (failure.runtimeType) {
      case InvalidEmailAndPasswordCombinationFailure:
        return "Wrong email and password-combination.";
      case UserDisabledFailure:
        return "${state.emailAddress} is disabled.";
      case UserNotFoundFailure:
        return "${state.emailAddress} not found.";
      default:
        return "Something went wrong.";
    }
  }

  static void showButtonPressDialogForInvalidInputs(BuildContext context, String innerText, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color ?? Colors.redAccent,
      content: Text(innerText),
      duration: const Duration(milliseconds: 1300),
    ));
  }
}
