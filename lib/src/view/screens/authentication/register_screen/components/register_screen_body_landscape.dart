import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../application/auth/listener/register_executor.dart';
import '../../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';

import '../../../components/continue_button_component/continue_button_component.dart';
import 'register_form_component/register_form_component.dart';

class RegisterScreenBodyLandscape extends StatelessWidget {
  const RegisterScreenBodyLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        RegisterExecutor.onRegistrationAttempt(state, context);
      },
      builder: (context, state) {
        return Padding(
          padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          fillOverscroll: true,
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              RegisterFormComponent(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.04,
                ),
                Flexible(
                  child: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          fillOverscroll: true,
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Register Account", style: themeData.textTheme.headline5),
                                  SizedBox(height: size.height * 0.045),
                                  const Text(
                                    "Complete your details or continue \nwith social media",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                              Column(
                                children: [
                                  Text(
                                    'By continuing your confirm that you agree \nwith our Terms and Conditions',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: size.height * 0.035),
                                  ContinueButtonComponent(
                                    showSpinner: state.isSubmitting,
                                    text: "Register",
                                    onPressed: () {
                                      if (state.formKey.currentState!.validate()) {
                                        BlocProvider.of<RegisterBloc>(context)
                                            .add(const RegisterEvent.registerWithEmailAndPasswordPressed());
                                      } else {
                                        ContinueButtonComponent.showButtonPressDialogForInvalidInputs(
                                            context, "Invalid Input");
                                      }
                                    },
                                  ),
                                ],
                              ),
                              //
                            ],
                          ),
                        ),
                      ],
                    ),
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
