import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/auth/listener/login_executor.dart';
import '../../../../../application/auth/login_bloc/login_bloc.dart';
import '../../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../routes/router.gr.dart';
import '../../../components/app_title_component/app_title_component.dart';
import '../../../components/continue_button_component/continue_button_component.dart';
import 'login_form_component/login_form_component.dart';

class LoginScreenBodyLandscape extends StatelessWidget {
  const LoginScreenBodyLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: ((previous, current) => previous.failureOrSuccessOption != current.failureOrSuccessOption),
      listener: (context, state) {
        LoginExecutor.onLoginAttempt(state, context);
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              LoginFormComponent(),
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
                Expanded(
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
                                children: [
                                  const AppTitleComponent(),
                                  SizedBox(height: size.height * 0.045),
                                  const Text("Sign in with your email and password.",
                                      textAlign: TextAlign.center),
                                ],
                              ),
                              CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Don’t have an account? "),
                                      GestureDetector(
                                        onTap: () {
                                          AutoRouter.of(context).push(RegisterScreenRoute());
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
