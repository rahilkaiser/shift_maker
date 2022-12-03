import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/util/errors/errors.dart';
import '../../../core/util/failures/current_user_failure/current_user_failure.dart';
import '../../../domain/entities/user/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../domain/entities/user/user_role.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../../domain/repositories/current_user/current_user_repository.dart';
import '../../../injection.dart';
import '../../models/auth/manager_model/manager_model.dart';
import '../../models/auth/worker_model/worker_model.dart';

class CurrentUserRepositoryImpl implements CurrentUserRepository {
  final FirebaseFirestore firestore;

  CurrentUserRepositoryImpl({
    required this.firestore,
  });

  @override
  Future<Either<CurrentUserFailure, UserEntity>> getCurrentUserEntity() async {
    final userOption = await serviceLocator<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    final userDoc = this.firestore.collection("users").doc(user.id.value);
    final DocumentSnapshot snap = await userDoc.snapshots().first;
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    String role = data['role'];

    if (role == UserRole.MANAGER) {
      return right(ManagerModel.fromFireStore(snap).toEntity());
    } else if (role == UserRole.WORKER){
      return right(WorkerModel.fromFireStore(snap).toEntity());
    }
    return left(CurrentUserGeneralFailure());
  }
}
