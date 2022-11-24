import 'package:get_it/get_it.dart';

import 'application/auth/auth_bloc/auth_bloc.dart';


final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! state-management
  serviceLocator.registerFactory(() => AuthBloc());
}
