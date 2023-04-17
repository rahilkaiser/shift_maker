import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'application/auth/auth_status_bloc/auth_status_bloc.dart';
import 'application/auth/login_bloc/login_bloc.dart';
import 'application/auth/register_bloc/register_bloc.dart';

import 'application/current_user/current_user_watcher_bloc/current_user_watcher_bloc.dart';
import 'application/current_user/theme_mode_bloc/theme_mode_bloc.dart';
import 'application/departments/department_observer_bloc/department_observer_bloc.dart';
import 'application/departments/departments_controller_bloc/departments_controller_bloc.dart';
import 'application/departments/places_locator/places_locator_bloc.dart';
import 'application/workers/worker_controller_bloc/worker_controller_bloc.dart';
import 'application/workers/worker_observer_bloc/worker_observer_bloc.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/repositories/current_user/current_user_repository.dart';
import 'domain/repositories/department/department_repository.dart';
import 'domain/repositories/suggestion/suggestion_repository.dart';
import 'domain/repositories/worker/worker_repo.dart';
import 'infrastructure/repositories/auth/auth_repository_impl.dart';
import 'infrastructure/repositories/current_user_repository_impl/current_user_repository_impl.dart';
import 'infrastructure/repositories/department/department_repository_impl.dart';
import 'infrastructure/repositories/suggestion/suggestion_repo_impl.dart';
import 'infrastructure/repositories/worker/worker_repo_impl.dart';

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

  //! Theme
  serviceLocator.registerFactory(() => ThemeModeBloc());

  //! currUser
  serviceLocator.registerFactory(() => CurrentUserWatcherBloc(currentUserRepository: serviceLocator()));

  //! departments
  serviceLocator.registerFactory(() => DepartmentObserverBloc(departmentRepository: serviceLocator()));
  serviceLocator.registerFactory(() => DepartmentsControllerBloc(departmentRepository: serviceLocator()));
  serviceLocator.registerFactory(() => PlacesLocatorBloc(suggestionRepository: serviceLocator()));

  //! workers
  serviceLocator.registerFactory(() => WorkerObserverBloc(workerRepo: serviceLocator()));
  serviceLocator.registerFactory(() => WorkerControllerBloc(workerRepo: serviceLocator()));
}

Future<void> registerRepositoryDependencies() async {
  serviceLocator.registerLazySingleton<WorkerRepo>(() => WorkerRepoImpl(
        firebaseFunctions: serviceLocator(),
        firestore: serviceLocator(),
        firebaseStorage: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton<SuggestionRepository>(() => SuggestionRepoImpl(client: serviceLocator()));
  //! departments
  serviceLocator.registerLazySingleton<DepartmentRepository>(() => DepartmentRepositoryImpl(
        firestore: serviceLocator(),
        firebaseStorage: serviceLocator(),
      ));

  //! curr_user
  serviceLocator.registerLazySingleton<CurrentUserRepository>(() => CurrentUserRepositoryImpl(firestore: serviceLocator()));

  //! auth
  serviceLocator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(firebaseAuth: serviceLocator(), firestore: serviceLocator()));
}

Future<void> registerExtDependencies() async {
  final client = Client();
  serviceLocator.registerLazySingleton(() => client);

  final firebaseStorage = FirebaseStorage.instance;
  serviceLocator.registerLazySingleton(() => firebaseStorage);

  final firestore = FirebaseFirestore.instance;
  serviceLocator.registerLazySingleton(() => firestore);

  final firebaseAuth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuth);

  final firebaseFunctions = FirebaseFunctions.instanceFor(region: 'europe-west3');
  serviceLocator.registerLazySingleton(() => firebaseFunctions);
}
