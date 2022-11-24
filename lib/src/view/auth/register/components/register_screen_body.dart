import 'package:flutter/material.dart';

import '../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../core_components/core_continue_button_component/continue_button_component.dart';
import 'register_form_component/register_form_component.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: Column(
          children: [
            Text("Register Account", style: themeData.textTheme.headline5),
            SizedBox(height: size.height * 0.025),
            const Text(
              "Complete your details or continue \nwith social media",
              textAlign: TextAlign.center,
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            RegisterFormComponent(formKey: formKey),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ContinueButtonComponent(
                text: "Register",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
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
            )
          ],
        ),
      ),
    );
  }
}
