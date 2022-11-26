import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/auth/auth_bloc/auth_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../components/app_title_component/app_title_component.dart';
import '../../../components/continue_button_component/continue_button_component.dart';
import '../../register_screen/register_screen.dart';
import 'login_form_component/login_form_component.dart';

class LoginScreenBodyPortrait extends StatelessWidget {
  const LoginScreenBodyPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

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
              children: [
                const AppTitleComponent(),
                SizedBox(height: size.height * 0.025),
                const Text("Sign in with your email and password.", textAlign: TextAlign.center),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                LoginFormComponent(
                  formKey: AuthenticationInputValidators.formKey,
                  passwordVal: (String? value) {
                    password = value;
                  },
                  emailVal: (String? value) {
                    email = value;
                  },
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<RegisterScreen>(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text("Register now", style: TextStyle(color: themeData.colorScheme.secondary)),
                    ),
                  ],
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                ContinueButtonComponent(
                  text: "Login",
                  onPressed: () {
                    debugPrint(email);
                    debugPrint(password);
                    if (AuthenticationInputValidators.formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(LoginWithEmailAndPasswordPressed(email: email, password: password));
                    } else {
                      ContinueButtonComponent.showButtonPressDialogForInvalidInputs(context, "Invalid Input");
                    }
                  },
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                SizedBox(height: size.height * 0.025),
                // CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                // CircularProgressIndicator(color: themeData.colorScheme.secondary,),
                if (state.isSubmitting) ...[const CircularProgressIndicator()]
              ],
            );
          },
        ),
      ),
    );
  }
}