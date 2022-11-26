import 'package:get_it/get_it.dart';

import 'application/auth/login_bloc/login_bloc.dart';
import 'application/auth/register_bloc/register_bloc.dart';




final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! state-management
  serviceLocator.registerFactory(() => LoginBloc());
  serviceLocator.registerFactory(() => RegisterBloc());
}
