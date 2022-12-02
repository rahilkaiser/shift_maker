import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/util/errors/errors.dart';
import '../../domain/repositories/auth/auth_repository.dart';
import '../../injection.dart';

extension FireStoreExt on FirebaseFirestore {
  /// Gets the doc-path of the current-user
  ///
  ///
  Future<DocumentReference> getCurrentUserDocument() async {
    final userOption = await serviceLocator<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }

  /// Gets the UserRole
  ///
  ///
  Future<String> getCurrentUserRole() async {
    final userOption = await serviceLocator<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    final userDoc = FirebaseFirestore.instance.collection("users").doc(user.id.value);

    final DocumentSnapshot snap = await userDoc.snapshots().first;
    final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

    return data['role'];
  }
}
