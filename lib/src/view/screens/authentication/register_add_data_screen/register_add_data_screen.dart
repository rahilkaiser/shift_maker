import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/listener/register_executor.dart';
import '../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../core/theme/sizefit/core_spacing_constants.dart';
import '../../../../core/util/validators/AuthenticationInputValidators.dart';
import '../../../../injection.dart';
import '../../../routes/router.gr.dart';
import '../../components/app_bar_title_component/app_bar_title_component.dart';
import '../../components/continue_button_component/continue_button_component.dart';

class RegisterAddDataScreen extends StatelessWidget {
  final RegisterBloc registerBloc;

  const RegisterAddDataScreen({Key? key, required this.registerBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return BlocProvider.value(
      value: this.registerBloc,
      child: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: this.registerBloc,
        listener: (context, state) {
          RegisterExecutor.onRegistrationAttempt(state, context);
        },
        builder: (context, state) {
          TextEditingController nameController = TextEditingController(text: state.name);
          nameController.selection = TextSelection.collapsed(offset: nameController.text.length);

          TextEditingController phoneController = TextEditingController(text: state.phoneNum);
          phoneController.selection = TextSelection.collapsed(offset: phoneController.text.length);

          return Scaffold(
              appBar: AppBar(title: const AppBarTitleComponent(title: "Register")),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: CoreSpacingConstants.getCoreBodyContentPadding(size),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Profildaten einrichten", style: themeData.textTheme.headline5),
                      SizedBox(height: size.height * 0.025),
                      const Text(
                        "Complete your details",
                        textAlign: TextAlign.center,
                      ),
                      CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                      SizedBox(height: size.height * 0.025),
                      Form(
                        autovalidateMode: AutovalidateMode.disabled,
                        key: context.read<RegisterBloc>().state.formKeyData,
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (newName) {
                                print(newName);
                                context.read<RegisterBloc>().add(RegisterEvent.nameChanged(
                                      name: newName,
                                    ));
                              },
                              controller: nameController,
                              validator: (newName) {
                                return AuthenticationInputValidators.validateName(newName);
                              },
                              decoration: const InputDecoration(
                                labelText: "Name",
                                hintText: "Enter your name",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                suffixIcon: Icon(Icons.account_circle),
                              ),
                            ),
                            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.disabled,
                              onChanged: (newPhoneNum) {
                                phoneController.text = newPhoneNum;
                                context.read<RegisterBloc>().add(RegisterEvent.phoneNumberChanged(
                                      phoneNum: newPhoneNum,
                                    ));
                              },
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.phone),
                                hintText: "Enter your phonenumber",
                                labelText: "Telefonnummer",
                              ),
                            ),
                            CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                          ],
                        ),
                      ),
                      CoreSpacingConstants.getCoreFormSpacingSizedBox(context),
                      ContinueButtonComponent(
                        showSpinner: state.isSubmitting,
                        text: "Registrieren",
                        onPressed: () {
                          if (state.formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterBloc>(context).add(const RegisterEvent.registerWithEmailAndPasswordPressed());
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
                  ),
                ),
              ));
        },
      ),
    );
  }
}
