import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/auth/listener/register_executor.dart';
import '../../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';

import '../../../../routes/router.gr.dart';
import '../../../components/continue_button_component/continue_button_component.dart';
import 'register_form_component/register_form_component.dart';

class RegisterScreenBodyPortrait extends StatelessWidget {
  const RegisterScreenBodyPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext superContext) {
    Size size = MediaQuery.of(superContext).size;
    final themeData = Theme.of(superContext);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
        child: BlocBuilder<RegisterBloc, RegisterState>(
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
                  text: "Weiter",
                  onPressed: () {
                    if (state.formKey.currentState!.validate()) {
                      AutoRouter.of(superContext).push(RegisterAddDataRoute(
                        registerBloc: superContext.read<RegisterBloc>(),
                      ));
                      // BlocProvider.of<RegisterBloc>(context)
                      //     .add(const RegisterEvent.registerWithEmailAndPasswordPressed());
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
