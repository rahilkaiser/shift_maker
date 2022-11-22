import 'package:flutter/material.dart';

import '../../core-components/app_title_component.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.yellow,
                ),
                SizedBox(height: size.height * 0.04),
                const AppTitleComponent(),
                SizedBox(height: size.height * 0.02),
                const Text(
                  "Sign in with your email and password.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.06),
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: size.height * 0.06),
                TextFormField(
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: size.height * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account? "),
                    GestureDetector(
                      // onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
                      onTap: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: themeData.colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.06),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {  },
                    child: Text(
                      "Login",
                      style: themeData.textTheme.bodyLarge,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showButtonPressDialog(BuildContext context, String provider) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: const Duration(milliseconds: 400),
    ));
  }
}
