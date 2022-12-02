import 'package:auto_route/auto_route.dart';

import '../screens/authentication/login_screen/login_screen.dart';
import '../screens/authentication/register_screen/register_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/splash/splash_screen.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SplashScreen, initial: true),
  AutoRoute(page: LoginScreen, initial: false),
  AutoRoute(page: RegisterScreen, initial: false),
  AutoRoute(page: HomeScreen, initial: false),
])
class $AppRouter {}
