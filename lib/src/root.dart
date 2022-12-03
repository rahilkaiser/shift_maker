import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'application/auth/auth_status_bloc/auth_status_bloc.dart';
import 'application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';
import 'core/theme/theme.dart';

import 'core/settings/settings_controller.dart';
import 'injection.dart';
import 'view/routes/router.gr.dart';

class RootWidget extends StatelessWidget {
  final SettingsController settingsController;
  final AppRouter appRouter;

  const RootWidget({
    Key? key,
    required this.settingsController,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthStatusBloc>(
          //Get The Corresponding UserEntity
          create: (context) =>
              serviceLocator<AuthStatusBloc>()..add(const AuthStatusEvent.authCheckRequested()),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: this.appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale(
            'en',
          ),
        ],
        onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settingsController.themeMode,
      ),
    );

    // return AnimatedBuilder(
    //   animation: settingsController,
    //   builder: (BuildContext context, Widget? child) {
    //     return MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       restorationScopeId: 'app',
    //       localizationsDelegates: const [
    //         AppLocalizations.delegate,
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //         GlobalCupertinoLocalizations.delegate,
    //       ],
    //       supportedLocales: const [
    //         Locale(
    //           'en',
    //         ),
    //       ],
    //       onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
    //       theme: AppTheme.lightTheme,
    //       darkTheme: AppTheme.darkTheme,
    //       themeMode: settingsController.themeMode,
    //       home: const LoginScreen(),
    //     );
    //   },
    // );
  }
}
