import 'package:flutter/material.dart';

import '../../../../core/util/validators/AuthenticationInputValidators.dart';


class EmailInputFieldComponent extends StatelessWidget {
  final ValueChanged<String?> emailVal;

  const EmailInputFieldComponent({
    Key? key,
    required this.emailVal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => emailVal(value),
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