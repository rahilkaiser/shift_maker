import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/auth/register_bloc/register_bloc.dart';
import '../../../../injection.dart';

import '../../components/app_bar_title_component/app_bar_title_component.dart';
import '../register_add_data_screen/register_add_data_screen.dart';
import 'components/register_screen_body_landscape.dart';
import 'components/register_screen_body_portrait.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitleComponent(title: "Register")),
      body: BlocProvider(
        create: (context) => serviceLocator<RegisterBloc>(),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? RegisterScreenBodyPortrait(
                // registerBloc: context.read<RegisterBloc>(),
              )
            : const RegisterScreenBodyLandscape(
                // registerBloc: context.read<RegisterBloc>(),
                ),
      ),
    );
  }
}
