import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'application/auth/auth_status_bloc/auth_status_bloc.dart';
import 'application/auth/login_bloc/login_bloc.dart';
import 'application/auth/register_bloc/register_bloc.dart';

import 'application/departments/department_observer_bloc/department_observer_bloc.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/repositories/department/department_repository.dart';
import 'infrastructure/repositories/auth/auth_repository_impl.dart';
import 'infrastructure/repositories/department/department_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await registerStateManagementDependencies();
  await registerRepositoryDependencies();
  await registerExtDependencies();
}

Future<void> registerStateManagementDependencies() async {
  //! auth
  serviceLocator.registerFactory(() => LoginBloc(authRepository: serviceLocator()));
  serviceLocator.registerFactory(() => RegisterBloc(authRepository: serviceLocator()));
  serviceLocator.registerFactory(() => AuthStatusBloc(authRepository: serviceLocator()));

  //! departments
  serviceLocator.registerFactory(() => DepartmentObserverBloc(departmentRepository: serviceLocator()));
}

Future<void> registerRepositoryDependencies() async {
  //! departments
  serviceLocator.registerLazySingleton<DepartmentRepository>(
      () => DepartmentRepositoryImpl(firestore: serviceLocator()));

  //! auth
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: serviceLocator(), firestore: serviceLocator()));
}

Future<void> registerExtDependencies() async {
  final firestore = FirebaseFirestore.instance;
  serviceLocator.registerLazySingleton(() => firestore);

  final firebaseAuth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuth);
}
