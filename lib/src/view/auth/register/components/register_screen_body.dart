import 'package:flutter/material.dart';

import '../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../core-components/core-continue-button-component/continue_button_component.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),

                  CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                  TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.lock),
                      hintText: "Re-enter your password",
                      labelText: "Confirm Password",
                    ),
                    obscureText: true,
                  ),
                  CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                  TextFormField(
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
                  ContinueButtonComponent(
                    text: "Register",
                    onPressed: () {
                      this._showButtonPressDialog(context, "Register pressed");
                    },
                  ),
                ],
              ),
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            //
            // SizedBox(height: SizeConfig.screenHeight * 0.08),
            //
            // SizedBox(height: size.height * 0.08),
            //
            //

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
