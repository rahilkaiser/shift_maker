import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/auth_status_bloc/auth_status_bloc.dart';
import '../../../../application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';
import '../../../routes/router.gr.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({Key? key}) : super(key: key);

  _navigateAfterTimer(BuildContext context, screen) async {
    var duration = const Duration(seconds: 1);
    Timer(duration, () async {
      await context.router.replace(screen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthStatusBloc, AuthStatusState>(
          listener: (context, state) {
            if (state is Authenticated) {
              this._navigateAfterTimer(context, const HomeRoute());
            } else if (state is Unauthenticated) {
              //Navigate to LoginScreen
              this._navigateAfterTimer(context, const LoginRoute());
            }
          },
        ),
      ],
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 30),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('Shift'),
                ],
              ),
            ),
            DefaultTextStyle(
              style: TextStyle(
                color: themeData.colorScheme.secondary,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('Maker'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
