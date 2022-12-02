import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/core/unique_id.dart';
import '../../domain/entities/user/user_entity.dart';
import '../../domain/entities/user/user_role.dart';
import '../../domain/entities/users/manager/manager_entity.dart';
import '../../domain/entities/users/worker/worker_entity.dart';
import '../../injection.dart';
import '../models/auth/manager_model/manager_model.dart';
import '../models/auth/worker_model/worker_model.dart';

extension FirebaseUserMapper on User {
  Future<UserEntity> toEntity() async {
    // final userId = this.uid;
    // final firestore = serviceLocator<FirebaseFirestore>();
    //
    // final DocumentReference userDoc = await firestore.collection("users").doc(this.uid);
    //
    // final DocumentSnapshot snap = await userDoc.snapshots().first;
    //
    // final Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    //
    // print("QEWEWEEW");
    // print(data);

    return UserEntity(
      id: UniqueId.fromUniqueString(uid),
      role: UserRole.MANAGER,
      email: '',
    );
    // try {
    //   // Get reference to Firestore collection
    //
    //   print("QQQQQ");
    //   print(ManagerModel.fromFireStore(docSnap).toEntity());
    //   if (userData['role'] == UserRole.MANAGER) {
    //     return ManagerModel.fromFireStore(docSnap).toEntity();
    //   } else if (userData['role'] == UserRole.WORKER) {
    //     return WorkerModel.fromFireStore(docSnap).toEntity();
    //   }
    //
    //
    // } catch (e) {
    //   throw e;
    // }

    // print("Heloooooo");
    //
    //
  }
}
