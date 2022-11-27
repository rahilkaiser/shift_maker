import 'package:flutter/material.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../register_bloc/register_bloc.dart';

class RegisterExecutor {
  RegisterExecutor._();

  static void onRegistrationAttempt(RegisterState state, BuildContext context) =>
      state.failureOrSuccessOption.fold(
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
              "Successfully registered",
              color: Colors.green,
            );
            // Automatically sign in
            Navigator.pop(context);
          },
        ),
      );

  static String _mapFailureMessage(AuthFailure failure, RegisterState state) {
    switch (failure.runtimeType) {
      case EmailAlreadyInUseFailure:
        return "${state.emailAddress} is already in use.";
      case InvalidEmailFailure:
        return "${state.emailAddress} is already is not valid.";
      case WeakPasswordFailure:
        return "Password is too weak.";
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
