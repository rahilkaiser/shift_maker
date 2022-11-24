import 'package:flutter/material.dart';

import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../core_components/input_fields_components/email_input_field_component.dart';

class LoginFormComponent extends StatelessWidget {
  const LoginFormComponent({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const EmailInputFieldComponent(),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            validator: AuthenticationInputValidators.validatePassword,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.lock),
              labelText: 'Password',
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
