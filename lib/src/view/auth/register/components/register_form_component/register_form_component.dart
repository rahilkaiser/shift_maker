import 'package:flutter/material.dart';

import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../core_components/input_fields_components/email_input_field_component.dart';
import 'components/confirm_password_input_field.dart';

class RegisterFormComponent extends StatelessWidget {
  const RegisterFormComponent({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    String? password;

    return Form(
      key: formKey,
      child: Column(
        children: [
          const EmailInputFieldComponent(),

          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: (newInput) {
              password = newInput;
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
          ConfirmPasswordInputField(password: password),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
        ],
      ),
    );
  }
}
