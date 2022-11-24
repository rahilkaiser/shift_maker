import 'package:flutter/material.dart';

import '../../../../../../core/util/validators/AuthenticationInputValidators.dart';

class ConfirmPasswordInputField extends StatelessWidget {
  const ConfirmPasswordInputField({
    Key? key,
    required this.password,
  }) : super(key: key);

  final String? password;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.disabled,
      validator: (input) => AuthenticationInputValidators.validateConfirmPassword(input, password),
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.lock),
        hintText: "Re-enter your password",
        labelText: "Confirm Password",
      ),
      obscureText: true,
    );
  }
}