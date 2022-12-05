import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/auth/listener/login_executor.dart';
import '../../../../../application/auth/login_bloc/login_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';

import '../../../../routes/router.gr.dart';
import '../../../components/app_title_component/app_title_component.dart';
import '../../../components/continue_button_component/continue_button_component.dart';
import 'login_form_component/login_form_component.dart';

class LoginScreenBodyPortrait extends StatelessWidget {
  const LoginScreenBodyPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: BlocConsumer<LoginBloc, LoginState>(
          listenWhen: ((previous, current) => previous.failureOrSuccessOption != current.failureOrSuccessOption),
          listener: (context, state) {
            LoginExecutor.onLoginAttempt(state, context);
          },
          builder: (context, state) {
            return Column(
              children: [
                const AppTitleComponent(),
                SizedBox(height: size.height * 0.025),
                const Text("Sign in with your email and password.", textAlign: TextAlign.center),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                const LoginFormComponent(),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        AutoRouter.of(context).push(RegisterRoute());
                      },
                      child: Text("Register now", style: TextStyle(color: themeData.colorScheme.secondary)),
                    ),
                  ],
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                ContinueButtonComponent(
                  showSpinner: state.isSubmitting,
                  text: "Login",
                  onPressed: () {
                    if (state.formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(const LoginEvent.loginWithEmailAndPasswordPressed());
                    } else {
                      ContinueButtonComponent.showButtonPressDialogForInvalidInputs(context, "Invalid Input");
                    }
                  },
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                SizedBox(height: size.height * 0.025),
                // CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                // CircularProgressIndicator(color: themeData.colorScheme.secondary,),
                // if (state.isSubmitting) ...[const CircularProgressIndicator()]
              ],
            );
          },
        ),
      ),
    );
  }
}
