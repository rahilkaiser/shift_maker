import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/auth/login_bloc/login_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../components/app_title_component/app_title_component.dart';
import '../../../components/continue_button_component/continue_button_component.dart';
import '../../register_screen/register_screen.dart';
import 'login_form_component/login_form_component.dart';

class LoginScreenBodyLandscape extends StatelessWidget {
  const LoginScreenBodyLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // if (state.isSubmitting) ...[const LinearProgressIndicator()],

                // Padding(
                //   padding: EdgeInsets.only(top: 2),
                //   child: state.isSubmitting ? const LinearProgressIndicator() : Container(),
                // ),
                Padding(
                  padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            LoginFormComponent(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      // Flexible(
                      //   child: SizedBox(w),
                      // ),
                      Flexible(
                        child: Column(
                          children: [
                            const AppTitleComponent(),
                            SizedBox(height: size.height * 0.025),
                            const Text("Sign in with your email and password.", textAlign: TextAlign.center),
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
                                  child: Text("Register now",
                                      style: TextStyle(color: themeData.colorScheme.secondary)),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.035),
                            ContinueButtonComponent(
                              showSpinner: state.isSubmitting,
                              text: "Login",
                              onPressed: () {
                                if (state.formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(const LoginEvent.loginWithEmailAndPasswordPressed());
                                } else {
                                  ContinueButtonComponent.showButtonPressDialogForInvalidInputs(
                                      context, "Invalid Input");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
