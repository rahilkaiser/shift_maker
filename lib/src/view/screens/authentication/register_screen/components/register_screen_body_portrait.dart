import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/auth/listener/register_executor.dart';
import '../../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';

import '../../../components/continue_button_component/continue_button_component.dart';
import 'register_form_component/register_form_component.dart';

class RegisterScreenBodyPortrait extends StatelessWidget {
  const RegisterScreenBodyPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            RegisterExecutor.onRegistrationAttempt(state, context);
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
                const RegisterFormComponent(),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                ContinueButtonComponent(
                  showSpinner: state.isSubmitting,
                  text: "Register",
                  onPressed: () {
                    if (state.formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterBloc>(context)
                          .add(const RegisterEvent.registerWithEmailAndPasswordPressed());
                    } else {
                      ContinueButtonComponent.showButtonPressDialogForInvalidInputs(
                        context,
                        "Invalid Input",
                      );
                    }
                  },
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                Text(
                  'By continuing your confirm that you agree \nwith our Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                SizedBox(height: size.height * 0.025),
              ],
            );
          },
        ),
      ),
    );
  }
}