import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'application/auth/login_bloc/login_bloc.dart';
import 'application/auth/register_bloc/register_bloc.dart';
import 'domain/repositories/auth_repository.dart';
import 'infrastructure/repositories/auth_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! state-management
  serviceLocator.registerFactory(() => LoginBloc(authRepository: serviceLocator()));
  serviceLocator.registerFactory(() => RegisterBloc(authRepository: serviceLocator()));

  //! repos
  serviceLocator
      .registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(firebaseAuth: serviceLocator()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuth);
}
