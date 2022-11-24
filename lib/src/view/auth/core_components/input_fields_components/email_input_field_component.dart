import 'package:flutter/material.dart';

import '../../../../core/util/validators/AuthenticationInputValidators.dart';

class EmailInputFieldComponent extends StatelessWidget {
  const EmailInputFieldComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.disabled,
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