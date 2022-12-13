import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../screens/authentication/login_screen/login_screen.dart';
import '../screens/authentication/register_screen/register_screen.dart';
import '../screens/home/home_screen.dart';

import '../screens/manager/manager_dashboard.dart';
import '../screens/manager/manager_home_screen/manager_home_screen.dart';

import '../screens/manager/manager_overview_department_screen/components/manager_department_editor_screen/components/manager__adress_map_screen.dart';
import '../screens/manager/manager_overview_department_screen/components/manager_department_editor_screen/manager_department_editor_screen.dart';
import '../screens/manager/manager_overview_department_screen/components/manager_department_details_view/components/manager_edit_department_screen_body.dart';
import '../screens/manager/manager_overview_department_screen/components/manager_department_details_view/manager_department_details_screen.dart';
import '../screens/manager/manager_overview_department_screen/manager_overview_department_screen.dart';
import '../screens/manager/manager_overview_worker_screen/manager_overview_worker_screen.dart';
import '../screens/manager/manager_profile_screen/manager_profile_screen.dart';

import '../screens/manager/manager_profile_screen/settings_views/manager_my_account_screen/manager_my_account_screen.dart';
import '../screens/splash/splash_screen.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: <AutoRoute>[
  AutoRoute(path: "/", page: SplashScreen),
  AutoRoute(path: "login", page: LoginScreen),
  AutoRoute(path: "register", page: RegisterScreen),
  AutoRoute(path: "adress_edit", page: ManagerAdressMapScreen),
  AutoRoute(path: "home", page: HomeScreen, children: [
    AutoRoute(name: 'ManagerHomeRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerHomeScreen),
    ]),

    AutoRoute(name: 'ManagerOverviewDepartmentRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerOverviewDepartmentScreen, deferredLoading: true),
      CustomRoute(
        path: 'department',
        page: ManagerDepartmentDetailsScreen,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        deferredLoading: true,
      ),
      CustomRoute(
        path: 'edit',
        page: ManagerDepartmentEditorScreen,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        deferredLoading: true,
      ),
    ]),

    AutoRoute(name: 'ManagerOverviewWorkerRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerOverviewWorkerScreen),
    ]),

    AutoRoute(name: 'ManagerProfileRouter', page: EmptyRouterScreen, children: [
      AutoRoute(path: '', page: ManagerProfileScreen, deferredLoading: true),
      CustomRoute(
        path: 'account',
        page: ManagerMyAccountScreen,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        deferredLoading: true,
      ),
    ]),
    //SettingsViews
  ]),
])
class $AppRouter {}
