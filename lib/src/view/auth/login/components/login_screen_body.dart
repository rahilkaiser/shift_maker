import 'package:flutter/material.dart';

import '../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../core-components/app_title_component.dart';
import '../../../core-components/core-continue-button-component/continue_button_component.dart';
import '../../register/register_screen.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
            ),
            const AppTitleComponent(),
            SizedBox(height: size.height * 0.025),
            const Text(
              "Sign in with your email and password.",
              textAlign: TextAlign.center,
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            TextFormField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.email),
                labelText: 'Email',
              ),
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            TextFormField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: themeData.colorScheme.secondary),
                  ),
                ),
              ],
            ),
            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
            ContinueButtonComponent(
              text: "Login",
              onPressed: () {
                this._showButtonPressDialog(context, "Login pressed");
              },
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
