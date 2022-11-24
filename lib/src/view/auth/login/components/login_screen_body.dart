import 'package:flutter/material.dart';

import '../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../core_components/core_continue_button_component/continue_button_component.dart';
import '../../core_components/app_title_component.dart';
import '../../register/register_screen.dart';
import 'login_form_component/login_form_component.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: Column(
          children: [
            const AppTitleComponent(),
            SizedBox(height: size.height * 0.025),
            const Text("Sign in with your email and password.", textAlign: TextAlign.center),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            LoginFormComponent(formKey: formKey),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                  child: Text("Register now", style: TextStyle(color: themeData.colorScheme.secondary)),
                ),
              ],
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ContinueButtonComponent(
              text: "Login",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                } else {
                  ContinueButtonComponent.showButtonPressDialogForInvalidInputs(context, "Invalid Input");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
