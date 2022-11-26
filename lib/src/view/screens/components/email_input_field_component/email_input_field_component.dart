import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/login_bloc/login_bloc.dart';
import '../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../core/util/validators/AuthenticationInputValidators.dart';

class EmailInputFieldComponent extends StatelessWidget {
  const EmailInputFieldComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (newEmail) {
        // Can be called by LoginBloc and also by RegisterBloc TODO: Find a better solution
        try {
          context.read<LoginBloc>().add(LoginEvent.emailChanged(email: newEmail));
        } catch (e) {}

        try {
          context.read<RegisterBloc>().add(RegisterEvent.emailChanged(email: newEmail));
        } catch (e) {}
      },
      keyboardType: TextInputType.emailAddress,
      validator: AuthenticationInputValidators.validateEmail,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
      ),
    );
  }
}
