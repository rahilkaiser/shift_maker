import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../screens/authentication/login_screen/login_screen.dart';
import '../screens/authentication/register_screen/register_screen.dart';
import '../screens/home/home_screen.dart';

import '../screens/manager/manager_dashboard.dart';
import '../screens/manager/manager_home_screen/manager_home_screen.dart';

import '../screens/manager/manager_overview_department_screen/manager_overview_department_screen.dart';
import '../screens/manager/manager_overview_worker_screen/manager_overview_worker_screen.dart';
import '../screens/manager/manager_profile_screen/manager_profile_screen.dart';

import '../screens/manager/manager_profile_screen/settings_views/manager_my_account_screen/manager_my_account_screen.dart';
import '../screens/splash/splash_screen.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: <AutoRoute>[
  AutoRoute(path: "/", page: SplashScreen),
  AutoRoute(path: "login", page: LoginScreen),
  AutoRoute(path: "register", page: RegisterScreen),
  AutoRoute(path: "home", page: HomeScreen, children: [
    AutoRoute(name: 'ManagerHomeRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerHomeScreen),
    ]),

    AutoRoute(name: 'ManagerOverviewDepartmentRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerOverviewDepartmentScreen),
    ]),

    AutoRoute(name: 'ManagerOverviewWorkerRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerOverviewWorkerScreen),
    ]),

    AutoRoute(name: 'ManagerProfileRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerProfileScreen),
      AutoRoute(path: 'account', page: ManagerMyAccountScreen),
    ]),
    //SettingsViews
  ]),
])
class $AppRouter {}
