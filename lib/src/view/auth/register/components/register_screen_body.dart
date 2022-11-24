import 'package:flutter/material.dart';

import '../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../core_components/core_continue_button_component/continue_button_component.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    String? password;

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
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    validator: AuthenticationInputValidators.validateEmail,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),

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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (input) => AuthenticationInputValidators.validateConfirmPassword(input, password),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.lock),
                      hintText: "Re-enter your password",
                      labelText: "Confirm Password",
                    ),
                    obscureText: true,
                  ),
                  // FormError(errors: errors),
                  CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                  CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                ],
              ),
            ),
            ContinueButtonComponent(
                text: "Register",
                onPressed: () {
                  if(formKey.currentState!.validate()) {
                    this._showButtonPressDialog(context, "Validated");
                  } else {
                    this._showButtonPressDialog(context, "Invalid");
                  }
                  // this._showButtonPressDialog(context, "Register pressed");
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

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      duration: const Duration(milliseconds: 400),
    ));
  }
}
