import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/auth/auth_bloc/auth_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';

import '../../../components/continue_button_component/continue_button_component.dart';
import 'register_form_component/register_form_component.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    String? email;
    String? password;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Register Account", style: themeData.textTheme.headline5),
                SizedBox(height: size.height * 0.025),
                const Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                SizedBox(height: size.height * 0.025),
                RegisterFormComponent(
                  formKey: formKey,
                  emailValOnChange: (String? value) {
                    email = value;
                  },
                  passwordValOnChange: (String? value) {
                    password = value;
                  },
                ),
                // CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                ContinueButtonComponent(
                    text: "Register",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(RegisterWithEmailAndPasswordPressed(email: email, password: password));
                      } else {
                        ContinueButtonComponent.showButtonPressDialogForInvalidInputs(context, "Invalid Input");
                      }
                    }),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                Text(
                  'By continuing your confirm that you agree \nwith our Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                // SizedBox(height: size.height * 0.025),
                // if (state.isSubmitting) ...[const CircularProgressIndicator()]
                // if (state.isSubmitting) ...
                const LinearProgressIndicator()
              ],
            );
          },
        ),
      ),
    );
  }
}
