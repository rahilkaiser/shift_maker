import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/login_bloc/login_bloc.dart';
import '../../../../core/settings/settings_controller.dart';

import '../../../../injection.dart';
import '../../components/app_bar_title_component/app_bar_title_component.dart';
import 'components/login_screen_body_landscape.dart';
import 'components/login_screen_body_portrait.dart';

class LoginScreen extends StatelessWidget {
  final SettingsController settingsController;

  const LoginScreen({Key? key, required this.settingsController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitleComponent(title: "Login"),
        actions: [
          DropdownButton<ThemeMode>(
            value: this.settingsController.themeMode,
            onChanged: this.settingsController.updateThemeMode,
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark Theme'),
              )
            ],
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<LoginBloc>(),
        lazy: true,
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? const LoginScreenBodyPortrait()
            : const LoginScreenBodyLandscape(),
      ),
    );
  }
}
