import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../../components/email_input_field_component/email_input_field_component.dart';

class RegisterFormComponent extends StatelessWidget {
  const RegisterFormComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: context.read<RegisterBloc>().state.formKey,
      child: Column(
        children: [
          EmailInputFieldComponent(),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            onChanged: (newPassword) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(RegisterEvent.passwordChanged(password: newPassword));
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
            validator: (input) => AuthenticationInputValidators.validateConfirmPassword(input, context.read<RegisterBloc>().state.password),
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
