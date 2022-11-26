import 'package:flutter/material.dart';

import '../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../../components/email_input_field_component/email_input_field_component.dart';

class RegisterFormComponent extends StatelessWidget {
  final ValueChanged<String?> emailValOnChange;
  final ValueChanged<String?> passwordValOnChange;

  const RegisterFormComponent({
    Key? key,
    required this.formKey,
    required this.emailValOnChange,
    required this.passwordValOnChange,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    String? mainPassword;

    return Form(
      key: formKey,
      child: Column(
        children: [
          EmailInputFieldComponent(
            emailVal: this.emailValOnChange,
          ),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: (newValue) {
              mainPassword = newValue;
              this.passwordValOnChange(newValue);
            },
            validator: AuthenticationInputValidators.validatePassword,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Enter your password",
              labelText: "Password",
            ),
            obscureText: true,
          ),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            validator: (input) => AuthenticationInputValidators.validateConfirmPassword(input, mainPassword),
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              hintText: "Re-enter your password",
              labelText: "Confirm Password",
            ),
            obscureText: true,
          ),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
        ],
      ),
    );
  }
}
