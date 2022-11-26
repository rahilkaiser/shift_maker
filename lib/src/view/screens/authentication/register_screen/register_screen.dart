import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/auth/auth_bloc/auth_bloc.dart';
import '../../../../injection.dart';

import '../../components/app_bar_title_component/app_bar_title_component.dart';
import 'components/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitleComponent(title: "Register")),
      body: BlocProvider(
        create: (context) => serviceLocator<AuthBloc>(),
        child: const RegisterScreenBody(),
      ),
    );
  }
}
