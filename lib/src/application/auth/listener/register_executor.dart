import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/failures/auth_failures/auth_failure.dart';
import '../../../view/routes/router.gr.dart';
import '../auth_status_bloc/auth_status_bloc.dart';
import '../register_bloc/register_bloc.dart';

class RegisterExecutor {
  RegisterExecutor._();

  static void onRegistrationAttempt(RegisterState state, BuildContext context) => state.failureOrSuccessOption.fold(
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
            BlocProvider.of<AuthStatusBloc>(context).add(const AuthStatusEvent.authCheckRequested());
            AutoRouter.of(context).replaceAll([const LoginRoute()]);
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
