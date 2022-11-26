import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../application/auth/login_bloc/login_bloc.dart';
import '../../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../../components/email_input_field_component/email_input_field_component.dart';

class LoginFormComponent extends StatelessWidget {
  const LoginFormComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginBloc>().state.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          const EmailInputFieldComponent(),
          CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
          TextFormField(
            onChanged: (newPassword) {
              BlocProvider.of<LoginBloc>(context).add(LoginEvent.passwordChanged(password: newPassword));
            },
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
