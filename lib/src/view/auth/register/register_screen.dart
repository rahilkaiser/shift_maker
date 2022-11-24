import 'package:flutter/material.dart';

import '../core_components/app-bar-title-component/app_bar_title_component.dart';
import 'components/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitleComponent(title: "Register")),
      body: const RegisterScreenBody(),
    );
  }
}
